import 'package:flutter/material.dart';
import 'package:numeral/numeral.dart';

class NumeralComponent extends StatefulWidget {
  const NumeralComponent({super.key});

  @override
  State<NumeralComponent> createState() => _NumeralComponentState();
}

class _NumeralComponentState extends State<NumeralComponent> {
  final TextEditingController _numberController = TextEditingController(
    text: '1234567',
  );
  String _formattedNumber = '';
  bool _isLoading = false;
  String _errorMessage = '';

  void _formatNumber() {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // 模拟加载过程
    Future.delayed(const Duration(milliseconds: 300), () {
      try {
        final input = _numberController.text.trim();
        if (input.isEmpty) {
          throw Exception('请输入数字');
        }

        final number = double.tryParse(input);
        if (number == null) {
          throw Exception('请输入有效的数字');
        }

        final formatted = Numeral(number).format();
        setState(() {
          _formattedNumber = formatted;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _errorMessage = '错误: ${e.toString()}';
          _isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _formatNumber();
  }

  @override
  void dispose() {
    _numberController.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '数字格式化为美观字符串',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(height: 20),

              // 数字输入
              TextField(
                controller: _numberController,
                decoration: const InputDecoration(
                  labelText: '输入数字',
                  border: OutlineInputBorder(),
                  hintText: '例如: 1234567',
                ),
                keyboardType: TextInputType.number,
                onChanged: (_) => _formatNumber(),
              ),
              const SizedBox(height: 30),

              // 错误信息
              if (_errorMessage.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    border: Border.all(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                ),

              // 格式化结果
              _isLoading
                  ? const CircularProgressIndicator(color: Colors.purple)
                  : GestureDetector(
                      onTap: () {
                        // 点击结果的交互效果
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('已复制: $_formattedNumber'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _formattedNumber.isEmpty ? '请输入数字' : '格式化结果: $_formattedNumber',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),

              // 状态提示
              Text(
                _isLoading ? '格式化中...' : '就绪',
                style: TextStyle(
                  fontSize: 16,
                  color: _isLoading ? Colors.purple : Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // 示例数字
              const Text(
                '示例数字:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final example in [1000, 10000, 1000000, 1000000000, 0.5, 123.45])
                    GestureDetector(
                      onTap: () {
                        _numberController.text = example.toString();
                        _formatNumber();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.purple[100],
                          border: Border.all(color: Colors.purple, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          example.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
