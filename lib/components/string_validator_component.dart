import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class StringValidatorComponent extends StatefulWidget {
  const StringValidatorComponent({super.key});

  @override
  State<StringValidatorComponent> createState() => _StringValidatorComponentState();
}

class _StringValidatorComponentState extends State<StringValidatorComponent> {
  final TextEditingController _inputController = TextEditingController();
  String _validationResult = '';
  bool _isValid = false;
  bool _isLoading = false;

  void _validateInput() {
    setState(() {
      _isLoading = true;
    });

    // 模拟验证过程
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        final input = _inputController.text;
        final results = <String>[];

        // 验证是否为空
        if (input.isEmpty) {
          results.add('输入不能为空');
        } else {
          // 验证是否为邮箱
          if (isEmail(input)) {
            results.add('✓ 是有效的邮箱地址');
          }

          // 验证是否为URL
          if (isURL(input)) {
            results.add('✓ 是有效的URL');
          }

          // 验证是否为IP地址
          if (isIP(input)) {
            results.add('✓ 是有效的IP地址');
          }

          // 验证是否为数字
          if (isNumeric(input)) {
            results.add('✓ 是有效的数字');
          }

          // 验证是否为字母
          if (isAlpha(input)) {
            results.add('✓ 是纯字母');
          }

          // 验证是否为字母和数字
          if (isAlphanumeric(input)) {
            results.add('✓ 是字母和数字的组合');
          }

          // 验证长度
          if (input.length < 6) {
            results.add('✗ 长度至少为6个字符');
          } else if (input.length > 20) {
            results.add('✗ 长度不能超过20个字符');
          } else {
            results.add('✓ 长度符合要求');
          }

          // 验证是否包含特殊字符
          if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(input)) {
            results.add('✓ 包含特殊字符');
          }

          // 验证是否包含大写字母
          if (RegExp(r'[A-Z]').hasMatch(input)) {
            results.add('✓ 包含大写字母');
          }

          // 验证是否包含小写字母
          if (RegExp(r'[a-z]').hasMatch(input)) {
            results.add('✓ 包含小写字母');
          }

          // 验证是否包含数字
          if (RegExp(r'[0-9]').hasMatch(input)) {
            results.add('✓ 包含数字');
          }
        }

        _validationResult = results.join('\n');
        _isValid = results.every((result) => result.startsWith('✓'));
        _isLoading = false;
      });
    });
  }

  void _clearInput() {
    setState(() {
      _inputController.clear();
      _validationResult = '';
      _isValid = false;
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
                '复杂验证测试',
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
                  labelText: '请输入要验证的内容',
                  hintText: '例如：邮箱、URL、IP地址等',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _clearInput,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 验证按钮
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _validateInput,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              '验证',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _clearInput,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('清空'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 验证结果
              if (_validationResult.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isValid ? Colors.green[50] : Colors.red[50],
                    border: Border.all(
                      color: _isValid ? Colors.green : Colors.red,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _validationResult,
                    style: TextStyle(
                      color: _isValid ? Colors.green[800] : Colors.red[800],
                      fontSize: 14,
                    ),
                  ),
                ),

              // 验证状态
              if (_validationResult.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      _isValid ? '验证通过！' : '验证失败，请检查输入',
                      style: TextStyle(
                        color: _isValid ? Colors.green : Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // 示例提示
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
                  GestureDetector(
                    onTap: () {
                      _inputController.text = 'example@test.com';
                    },
                    child: Chip(
                      label: const Text('邮箱'),
                      backgroundColor: Colors.blue[100],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _inputController.text = 'https://www.example.com';
                    },
                    child: Chip(
                      label: const Text('URL'),
                      backgroundColor: Colors.green[100],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _inputController.text = '192.168.1.1';
                    },
                    child: Chip(
                      label: const Text('IP地址'),
                      backgroundColor: Colors.yellow[100],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _inputController.text = '123456';
                    },
                    child: Chip(
                      label: const Text('数字'),
                      backgroundColor: Colors.orange[100],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _inputController.text = 'Abcd123!';
                    },
                    child: Chip(
                      label: const Text('强密码'),
                      backgroundColor: Colors.purple[100],
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
