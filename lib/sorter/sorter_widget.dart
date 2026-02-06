import 'package:flutter/material.dart';
import 'line_sorter.dart';

class SorterWidget extends StatefulWidget {
  const SorterWidget({Key? key}) : super(key: key);

  @override
  _SorterWidgetState createState() => _SorterWidgetState();
}

class _SorterWidgetState extends State<SorterWidget> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  bool _isAscending = true;
  String _errorMessage = '';

  void _sortLines() {
    setState(() {
      _errorMessage = '';
      final inputText = _inputController.text.trim();
      if (inputText.isEmpty) {
        _errorMessage = '请输入要排序的文本';
        return;
      }
      
      final lines = LineSorter.parseTextToLines(inputText);
      if (lines.isEmpty) {
        _errorMessage = '请输入有效的文本行';
        return;
      }
      
      final sortedLines = LineSorter.sortLines(lines, _isAscending);
      final sortedText = LineSorter.joinLinesToText(sortedLines);
      _outputController.text = sortedText;
    });
  }

  void _clearAll() {
    setState(() {
      _inputController.clear();
      _outputController.clear();
      _errorMessage = '';
    });
  }

  void _toggleSortOrder() {
    setState(() {
      _isAscending = !_isAscending;
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 输入区域
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '输入文本',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _inputController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: '请输入多行文本，每行一条...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
          ),

          // 控制按钮
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Switch(
                      value: _isAscending,
                      onChanged: (value) => _toggleSortOrder(),
                    ),
                    Text(
                      _isAscending ? '升序排序' : '降序排序',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _sortLines,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      ),
                      child: Text(
                        '排序',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 10),
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
                        '清空',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
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

          // 输出区域
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '排序结果',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _outputController,
                  maxLines: 6,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: '排序结果将显示在这里...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.all(12),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
              ],
            ),
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
                Text('1. 在输入文本区域输入要排序的多行文本，每行一条'),
                Text('2. 选择排序方式（升序或降序）'),
                Text('3. 点击"排序"按钮对文本进行排序'),
                Text('4. 排序结果将显示在输出区域'),
                Text('5. 点击"清空"按钮可以清空所有内容'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
