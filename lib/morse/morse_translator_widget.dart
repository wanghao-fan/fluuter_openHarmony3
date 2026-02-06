import 'package:flutter/material.dart';
import 'morse_translator.dart';

class MorseTranslatorWidget extends StatefulWidget {
  const MorseTranslatorWidget({Key? key}) : super(key: key);

  @override
  _MorseTranslatorWidgetState createState() => _MorseTranslatorWidgetState();
}

class _MorseTranslatorWidgetState extends State<MorseTranslatorWidget> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _morseController = TextEditingController();
  String _errorMessage = '';

  void _translateToMorse() {
    setState(() {
      _errorMessage = '';
      final text = _textController.text.trim();
      if (text.isEmpty) {
        _errorMessage = '请输入要转换的文本';
        return;
      }
      final morse = MorseTranslator.textToMorse(text);
      _morseController.text = morse;
    });
  }

  void _translateToText() {
    setState(() {
      _errorMessage = '';
      final morse = _morseController.text.trim();
      if (morse.isEmpty) {
        _errorMessage = '请输入要转换的摩斯电码';
        return;
      }
      if (!MorseTranslator.isValidMorse(morse)) {
        _errorMessage = '无效的摩斯电码格式';
        return;
      }
      final text = MorseTranslator.morseToText(morse);
      _textController.text = text;
    });
  }

  void _clearAll() {
    setState(() {
      _textController.clear();
      _morseController.clear();
      _errorMessage = '';
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _morseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 文本输入区域
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '文本输入',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _textController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: '请输入要转换的文本...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _translateToMorse,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    '转换为摩斯电码',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),

          // 摩斯电码输入区域
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '摩斯电码输入',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _morseController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: '请输入要转换的摩斯电码... (例如: .- ... -.-. --- -.. .)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _translateToText,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    '转换为文本',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),

          // 错误提示
          if (_errorMessage.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red[300]!),
              ),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red[700]),
              ),
            ),

          // 控制按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _clearAll,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: Text(
                  '清空所有',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),

          // 使用说明
          Container(
            margin: const EdgeInsets.only(top: 30.0),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '使用说明：',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text('1. 在文本输入框中输入要转换的文本，点击"转换为摩斯电码"按钮'),
                Text('2. 在摩斯电码输入框中输入要转换的摩斯电码，点击"转换为文本"按钮'),
                Text('3. 摩斯电码中，点用"."表示，划用"-"表示，字母之间用空格分隔，单词之间用"/"分隔'),
                Text('4. 点击"清空所有"按钮可以清空两个输入框的内容'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
