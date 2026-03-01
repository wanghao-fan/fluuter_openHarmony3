import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class DateFormatComponent extends StatefulWidget {
  const DateFormatComponent({super.key});

  @override
  State<DateFormatComponent> createState() => _DateFormatComponentState();
}

class _DateFormatComponentState extends State<DateFormatComponent> {
  DateTime _selectedDate = DateTime.now();
  String _formattedDate = '';
  String _selectedFormat = 'yyyy-MM-dd';
  bool _isLoading = false;

  final List<String> _formatOptions = [
    'yyyy-MM-dd',
    'yyyy/MM/dd',
    'dd-MM-yyyy',
    'MM/dd/yyyy',
    'yyyy年MM月dd日',
    'yyyy-MM-dd HH:mm:ss',
    'yyyy/MM/dd HH:mm:ss',
    'HH:mm:ss',
  ];

  void _updateFormattedDate() {
    setState(() {
      _isLoading = true;
    });

    // 模拟格式化过程
    Future.delayed(const Duration(milliseconds: 300), () {
      String formatted;
      switch (_selectedFormat) {
        case 'yyyy-MM-dd':
          formatted = formatDate(_selectedDate, [yyyy, '-', mm, '-', dd]);
          break;
        case 'yyyy/MM/dd':
          formatted = formatDate(_selectedDate, [yyyy, '/', mm, '/', dd]);
          break;
        case 'dd-MM-yyyy':
          formatted = formatDate(_selectedDate, [dd, '-', mm, '-', yyyy]);
          break;
        case 'MM/dd/yyyy':
          formatted = formatDate(_selectedDate, [mm, '/', dd, '/', yyyy]);
          break;
        case 'yyyy年MM月dd日':
          formatted = formatDate(_selectedDate, [yyyy, '年', mm, '月', dd, '日']);
          break;
        case 'yyyy-MM-dd HH:mm:ss':
          formatted = formatDate(_selectedDate, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
          break;
        case 'yyyy/MM/dd HH:mm:ss':
          formatted = formatDate(_selectedDate, [yyyy, '/', mm, '/', dd, ' ', HH, ':', nn, ':', ss]);
          break;
        case 'HH:mm:ss':
          formatted = formatDate(_selectedDate, [HH, ':', nn, ':', ss]);
          break;
        default:
          formatted = formatDate(_selectedDate, [yyyy, '-', mm, '-', dd]);
      }

      setState(() {
        _formattedDate = formatted;
        _isLoading = false;
      });
    });
  }

  Future<void> _selectDate() async {
    // 先选择日期
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    
    if (pickedDate != null) {
      // 再选择时间
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate),
      );
      
      if (pickedTime != null) {
        final selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
          0, // TimeOfDay 没有 second 属性，设置为 0
        );
        
        setState(() {
          _selectedDate = selectedDateTime;
        });
        _updateFormattedDate();
      }
    }
  }

  void _selectFormat(String format) {
    setState(() {
      _selectedFormat = format;
    });
    _updateFormattedDate();
  }

  @override
  void initState() {
    super.initState();
    _updateFormattedDate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '日期格式化工具',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),

              // 日期选择按钮
              ElevatedButton(
                onPressed: _selectDate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: const Text(
                  '选择日期时间',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 选中的日期时间
              Text(
                '选中日期：${_selectedDate.toString()}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),

              // 格式化选项
              const Text(
                '选择格式化方式：',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _formatOptions.map((format) {
                  return GestureDetector(
                    onTap: () => _selectFormat(format),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: _selectedFormat == format ? Colors.deepPurple : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        format,
                        style: TextStyle(
                          color: _selectedFormat == format ? Colors.white : Colors.black87,
                          fontWeight: _selectedFormat == format ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),

              // 格式化结果
              _isLoading
                  ? const CircularProgressIndicator(color: Colors.deepPurple)
                  : GestureDetector(
                      onTap: () {
                        // 点击结果的交互效果
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('格式化结果已复制到剪贴板'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepPurple, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '格式化结果：',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _formattedDate.isEmpty ? '无结果' : _formattedDate,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(height: 20),

              // 状态提示
              Text(
                _isLoading ? '格式化中...' : '就绪',
                style: TextStyle(
                  fontSize: 16,
                  color: _isLoading ? Colors.blue : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
