import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslatorComponent extends StatefulWidget {
  const TranslatorComponent({super.key});

  @override
  State<TranslatorComponent> createState() => _TranslatorComponentState();
}

class _TranslatorComponentState extends State<TranslatorComponent> {
  final TextEditingController _textController = TextEditingController(
    text: 'Hello, how are you?',
  );
  String _translatedText = '';
  bool _isLoading = false;
  String _errorMessage = '';
  final GoogleTranslator _translator = GoogleTranslator();

  void _translateText() {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // 模拟加载过程
    Future.delayed(const Duration(milliseconds: 500), () async {
      try {
        final input = _textController.text.trim();
        if (input.isEmpty) {
          throw Exception('请输入要翻译的文本');
        }

        // 使用translator库进行翻译
        final translation = await _translator.translate(input, to: 'zh-cn');
        setState(() {
          _translatedText = translation.text;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _errorMessage = '翻译失败: ${e.toString()}';
          _isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _translateText();
  }

  @override
  void dispose() {
    _textController.dispose();
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
                '英文翻译中文',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),

              // 文本输入
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: '输入英文文本',
                  border: OutlineInputBorder(),
                  hintText: '例如: Hello, how are you?',
                ),
                maxLines: 3,
                onChanged: (_) => _translateText(),
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

              // 翻译结果
              _isLoading
                  ? const CircularProgressIndicator(color: Colors.teal)
                  : GestureDetector(
                      onTap: () {
                        // 点击结果的交互效果
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('已复制: $_translatedText'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.teal, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _translatedText.isEmpty ? '请输入英文文本' : '翻译结果: $_translatedText',
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
                _isLoading ? '翻译中...' : '就绪',
                style: TextStyle(
                  fontSize: 16,
                  color: _isLoading ? Colors.teal : Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // 示例文本
              const Text(
                '示例文本:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final example in [
                    'Hello, world!',
                    'How are you today?',
                    'I love Flutter development',
                    'OpenHarmony is awesome',
                    'What a beautiful day'
                  ])
                    GestureDetector(
                      onTap: () {
                        _textController.text = example;
                        _translateText();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.teal[100],
                          border: Border.all(color: Colors.teal, width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          example,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.teal,
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
