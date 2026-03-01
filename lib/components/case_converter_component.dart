import 'package:flutter/material.dart';
import 'package:change_case/change_case.dart';

class CaseConverterComponent extends StatefulWidget {
  const CaseConverterComponent({super.key});

  @override
  State<CaseConverterComponent> createState() => _CaseConverterComponentState();
}

class _CaseConverterComponentState extends State<CaseConverterComponent> {
  final TextEditingController _textController = TextEditingController(text: 'Hello World');
  String _convertedText = '';
  String _currentCase = 'Original';

  @override
  void initState() {
    super.initState();
    _updateConvertedText('Original');
  }

  void _updateConvertedText(String caseType) {
    final inputText = _textController.text;
    String result = inputText;

    switch (caseType) {
      case 'Original':
        result = inputText;
        break;
      case 'Uppercase':
        result = inputText.toUpperCase();
        break;
      case 'Lowercase':
        result = inputText.toLowerCase();
        break;
      case 'Title Case':
        result = inputText.toTitleCase();
        break;
      case 'Camel Case':
        result = inputText.toCamelCase();
        break;
      case 'Snake Case':
        result = inputText.toSnakeCase();
        break;
      case 'Kebab Case':
        result = inputText.toKebabCase();
        break;
      case 'Pascal Case':
        result = inputText.toPascalCase();
        break;
    }

    setState(() {
      _convertedText = result;
      _currentCase = caseType;
    });
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
                '大小写转换器',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),

              // 输入文本区域
              TextField(
                controller: _textController,
                onChanged: (_) => _updateConvertedText(_currentCase),
                decoration: const InputDecoration(
                  labelText: '输入文本',
                  border: OutlineInputBorder(),
                  hintText: '请输入要转换的文本',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 30),

              // 转换选项
              const Text(
                '转换选项：',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildCaseOption('Original'),
                  _buildCaseOption('Uppercase'),
                  _buildCaseOption('Lowercase'),
                  _buildCaseOption('Title Case'),
                  _buildCaseOption('Camel Case'),
                  _buildCaseOption('Snake Case'),
                  _buildCaseOption('Kebab Case'),
                  _buildCaseOption('Pascal Case'),
                ],
              ),
              const SizedBox(height: 30),

              // 转换结果
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '转换结果 (${_currentCase})：',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _convertedText.isEmpty ? '无结果' : _convertedText,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 复制按钮
              ElevatedButton(
                onPressed: _convertedText.isEmpty
                    ? null
                    : () {
                        // 复制到剪贴板的逻辑可以在这里添加
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('已复制到剪贴板'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text('复制结果'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 构建转换选项按钮
  Widget _buildCaseOption(String caseType) {
    return GestureDetector(
      onTap: () => _updateConvertedText(caseType),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: _currentCase == caseType ? Colors.deepPurple : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          caseType,
          style: TextStyle(
            color: _currentCase == caseType ? Colors.white : Colors.black87,
            fontWeight: _currentCase == caseType ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
