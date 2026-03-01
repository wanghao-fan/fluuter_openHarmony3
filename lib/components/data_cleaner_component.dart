import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class DataCleanerComponent extends StatefulWidget {
  const DataCleanerComponent({super.key});

  @override
  State<DataCleanerComponent> createState() => _DataCleanerComponentState();
}

class _DataCleanerComponentState extends State<DataCleanerComponent> {
  final TextEditingController _inputController = TextEditingController();
  String _selectedOperation = 'toString';
  String _result = '';
  bool _isProcessing = false;

  // 数据清理操作
  void _performCleaning() {
    setState(() {
      _isProcessing = true;
    });

    // 模拟处理过程
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        final input = _inputController.text;
        switch (_selectedOperation) {
          case 'toString':
            _result = _toString(input);
            break;
          case 'toDate':
            _result = _toDate(input);
            break;
          case 'toFloat':
            _result = _toFloat(input);
            break;
          case 'toInt':
            _result = _toInt(input);
            break;
          case 'toBoolean':
            _result = _toBoolean(input);
            break;
          case 'trim':
            _result = _trim(input);
            break;
          case 'ltrim':
            _result = _ltrim(input);
            break;
          case 'rtrim':
            _result = _rtrim(input);
            break;
          default:
            _result = '请选择操作';
        }
        _isProcessing = false;
      });
    });
  }

  // 将输入转换为字符串
  String _toString(String input) {
    return input.toString();
  }

  // 将输入转换为日期
  String _toDate(String input) {
    try {
      final date = DateTime.parse(input);
      return date.toString();
    } catch (e) {
      return 'null (不是有效的日期)';
    }
  }

  // 将输入转换为浮点数
  String _toFloat(String input) {
    final floatValue = double.tryParse(input);
    if (floatValue == null) {
      return 'NaN (不是有效的浮点数)';
    }
    return floatValue.toString();
  }

  // 将输入转换为整数
  String _toInt(String input) {
    final intValue = int.tryParse(input);
    if (intValue == null) {
      return 'NaN (不是有效的整数)';
    }
    return intValue.toString();
  }

  // 将输入转换为布尔值
  String _toBoolean(String input) {
    if (input.toLowerCase() == 'true' || input == '1') {
      return 'true';
    } else if (input.toLowerCase() == 'false' || input == '0' || input.isEmpty) {
      return 'false';
    }
    return 'true (非严格模式)';
  }

  // 从输入的两侧去除字符
  String _trim(String input) {
    return input.trim();
  }

  // 从输入的左侧去除字符
  String _ltrim(String input) {
    return input.trimLeft();
  }

  // 从输入的右侧去除字符
  String _rtrim(String input) {
    return input.trimRight();
  }

  // 清空输入和结果
  void _clearInput() {
    setState(() {
      _inputController.clear();
      _result = '';
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '数据清理器',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),

              // 输入框
              TextField(
                controller: _inputController,
                decoration: InputDecoration(
                  labelText: '请输入要清理的数据',
                  hintText: '例如：123, abc, 2023-01-01等',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _clearInput,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 操作选择
              const Text(
                '选择操作：',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildOperationChip('toString', '转换为字符串'),
                  _buildOperationChip('toDate', '转换为日期'),
                  _buildOperationChip('toFloat', '转换为浮点数'),
                  _buildOperationChip('toInt', '转换为整数'),
                  _buildOperationChip('toBoolean', '转换为布尔值'),
                  _buildOperationChip('trim', '去除两侧空白'),
                  _buildOperationChip('ltrim', '去除左侧空白'),
                  _buildOperationChip('rtrim', '去除右侧空白'),
                ],
              ),
              const SizedBox(height: 20),

              // 执行按钮
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : _performCleaning,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isProcessing
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          '执行清理',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // 结果显示
              if (_result.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(
                      color: Colors.blue,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '清理结果：',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _result,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

              // 示例输入
              const SizedBox(height: 20),
              const Text(
                '示例输入：',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildExampleChip('123'),
                  _buildExampleChip('abc'),
                  _buildExampleChip('  hello  '),
                  _buildExampleChip('2023-01-01'),
                  _buildExampleChip('true'),
                  _buildExampleChip('123.45'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 构建操作选择芯片
  Widget _buildOperationChip(String value, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOperation = value;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: _selectedOperation == value
              ? Border.all(color: Colors.deepPurple, width: 1)
              : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Chip(
          label: Text(label),
          backgroundColor: _selectedOperation == value ? Colors.deepPurple[100] : Colors.grey[100],
        ),
      ),
    );
  }

  // 构建示例输入芯片
  Widget _buildExampleChip(String value) {
    return GestureDetector(
      onTap: () {
        _inputController.text = value;
      },
      child: Chip(
        label: Text(value),
        backgroundColor: Colors.green[100],
      ),
    );
  }
}
