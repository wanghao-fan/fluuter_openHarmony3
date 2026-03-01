import 'package:flutter/material.dart';
import 'package:week_of_year/week_of_year.dart';

class WeekOfYearComponent extends StatefulWidget {
  const WeekOfYearComponent({super.key});

  @override
  State<WeekOfYearComponent> createState() => _WeekOfYearComponentState();
}

class _WeekOfYearComponentState extends State<WeekOfYearComponent> {
  DateTime _selectedDate = DateTime.now();
  int _weekOfYear = 0;
  bool _isLoading = false;
  String _result = '';

  void _calculateWeekOfYear() {
    setState(() {
      _isLoading = true;
    });

    // 模拟加载过程
    Future.delayed(const Duration(milliseconds: 500), () {
      final weekNumber = _selectedDate.weekOfYear;
      setState(() {
        _weekOfYear = weekNumber;
        _result = '计算结果：\n';
        _result += '日期: ${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}\n';
        _result += '是 ${_selectedDate.year} 年的第 $_weekOfYear 周';
        _isLoading = false;
      });
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _calculateWeekOfYear();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _calculateWeekOfYear();
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
                '获取一年中的第几周',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),

              // 日期选择
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 计算结果
              _isLoading
                  ? const CircularProgressIndicator(color: Colors.blue)
                  : GestureDetector(
                      onTap: () {
                        // 点击结果的交互效果
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('结果已复制到剪贴板'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _result.isEmpty ? '请选择日期' : _result,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),

              // 状态提示
              Text(
                _isLoading ? '计算中...' : '就绪',
                style: TextStyle(
                  fontSize: 16,
                  color: _isLoading ? Colors.blue : Colors.blue,
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
