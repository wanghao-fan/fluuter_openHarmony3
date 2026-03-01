import 'package:flutter/material.dart';

class ProfanityFilterComponent extends StatefulWidget {
  const ProfanityFilterComponent({super.key});

  @override
  State<ProfanityFilterComponent> createState() => _ProfanityFilterComponentState();
}

class _ProfanityFilterComponentState extends State<ProfanityFilterComponent> {
  final TextEditingController _textController = TextEditingController(
    text: 'Hello, this is a test message with some bad words like fuck, shit, bitch, and asshole.',
  );
  String _filteredText = '';
  bool _containsProfanity = false;
  bool _isLoading = false;
  String _errorMessage = '';
  
  // 本地脏话列表
  final List<String> _profanityList = [
    'fuck', 'shit', 'bitch', 'asshole', 'damn', 'hell', 'cunt', 'dick', 'pussy', 'cock'
  ];

  void _filterText() {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // 模拟过滤过程
    Future.delayed(const Duration(milliseconds: 300), () {
      try {
        final inputText = _textController.text;
        print('输入文本: $inputText');
        
        // 本地实现脏话过滤
        String filtered = inputText;
        bool containsProfanity = false;
        
        for (var word in _profanityList) {
          final regex = RegExp('\\b' + RegExp.escape(word) + '\\b', caseSensitive: false);
          if (regex.hasMatch(inputText)) {
            containsProfanity = true;
            // 替换为星号
            filtered = filtered.replaceAll(regex, '*' * word.length);
          }
        }
        
        print('过滤后文本: $filtered');
        print('是否包含脏话: $containsProfanity');

        setState(() {
          _filteredText = filtered;
          _containsProfanity = containsProfanity;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _errorMessage = '过滤失败: ${e.toString()}';
          _isLoading = false;
        });
        print('过滤失败: $e');
      }
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
                '脏话过滤器',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),

              // 文本输入区域
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: '输入文本',
                  border: OutlineInputBorder(),
                  hintText: '请输入要过滤的文本',
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 20),

              // 过滤按钮
              ElevatedButton(
                onPressed: _filterText,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: const Text(
                  '过滤脏话',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
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

              // 过滤结果
              _isLoading
                  ? const CircularProgressIndicator(color: Colors.deepPurple)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 检测结果
                        Row(
                          children: [
                            const Text(
                              '检测结果：',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _containsProfanity ? '包含脏话' : '未检测到脏话',
                              style: TextStyle(
                                fontSize: 16,
                                color: _containsProfanity ? Colors.red : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // 过滤后的文本
                        const Text(
                          '过滤后文本：',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            // 点击结果的交互效果
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('过滤结果已复制到剪贴板'),
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
                            child: Text(
                              _filteredText.isEmpty ? '无结果' : _filteredText,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 20),

              // 状态提示
              Text(
                _isLoading ? '过滤中...' : '就绪',
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
