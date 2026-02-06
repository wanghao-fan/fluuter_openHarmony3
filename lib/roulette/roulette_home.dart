import 'package:flutter/material.dart';
import 'roulette_wheel.dart';

class RouletteHome extends StatefulWidget {
  const RouletteHome({Key? key}) : super(key: key);

  @override
  _RouletteHomeState createState() => _RouletteHomeState();
}

class _RouletteHomeState extends State<RouletteHome> {
  List<String> _options = [
    '选项1',
    '选项2',
    '选项3',
    '选项4',
    '选项5',
    '选项6',
  ];
  final TextEditingController _optionController = TextEditingController();
  String _message = '';

  void _addOption() {
    final option = _optionController.text.trim();
    if (option.isNotEmpty) {
      setState(() {
        _options.add(option);
        _optionController.clear();
        _message = '已添加选项: $option';
      });
      _clearMessageAfterDelay();
    }
  }

  void _removeOption(int index) {
    setState(() {
      final removedOption = _options.removeAt(index);
      _message = '已移除选项: $removedOption';
    });
    _clearMessageAfterDelay();
  }

  void _clearAllOptions() {
    setState(() {
      _options.clear();
      _message = '已清空所有选项';
    });
    _clearMessageAfterDelay();
  }

  void _clearMessageAfterDelay() {
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _message = '';
        });
      }
    });
  }

  void _onOptionSelected(String option) {
    setState(() {
      _message = '恭喜你选中了: $option';
    });
    _clearMessageAfterDelay();
  }

  @override
  void dispose() {
    _optionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('决策轮盘'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 标题部分
            Container(
              margin: const EdgeInsets.only(bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '决策轮盘',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '自定义选项，转动轮盘随机选择',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // 轮盘部分
            Container(
              margin: const EdgeInsets.only(bottom: 30.0),
              child: _options.isEmpty
                  ? Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Center(
                        child: Text(
                          '请添加选项',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  : RouletteWheel(
                      options: _options,
                      size: 300.0,
                      onSelected: _onOptionSelected,
                    ),
            ),

            // 消息提示
            if (_message.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[300]!),
                ),
                child: Text(
                  _message,
                  style: TextStyle(color: Colors.blue[700]),
                ),
              ),

            // 选项管理部分
            Container(
              margin: const EdgeInsets.only(bottom: 30.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '选项管理',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _optionController,
                          decoration: InputDecoration(
                            hintText: '请输入选项内容',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.all(12),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _addOption,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        ),
                        child: Text('添加'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  if (_options.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '当前选项:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: _options.asMap().entries.map((entry) {
                              int index = entry.key;
                              String option = entry.value;
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  border: index < _options.length - 1
                                      ? Border(bottom: BorderSide(color: Colors.grey[300]!))
                                      : null,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(option),
                                    IconButton(
                                      onPressed: () => _removeOption(index),
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      tooltip: '删除选项',
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _clearAllOptions,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                          ),
                          child: Text('清空所有选项'),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // 使用说明
            Container(
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
                  Text('1. 在选项管理中添加你想要的选项'),
                  Text('2. 点击轮盘或"开始转动"按钮开始转动'),
                  Text('3. 轮盘停止后会显示选中的选项'),
                  Text('4. 你可以随时添加、删除或清空选项'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
