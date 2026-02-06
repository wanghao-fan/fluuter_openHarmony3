import 'package:flutter/material.dart';
import 'input_saver_widget.dart';
import 'input_saver_model.dart';

class InputSaverDashboard extends StatefulWidget {
  const InputSaverDashboard({Key? key}) : super(key: key);

  @override
  _InputSaverDashboardState createState() => _InputSaverDashboardState();
}

class _InputSaverDashboardState extends State<InputSaverDashboard> {
  // 输入框配置
  final List<InputFieldConfig> _inputConfigs = [
    InputFieldConfig(
      key: 'post_content',
      hintText: '写点什么...',
      maxLines: 5,
    ),
    InputFieldConfig(
      key: 'email_subject',
      hintText: '邮件主题',
      maxLines: 1,
    ),
    InputFieldConfig(
      key: 'email_body',
      hintText: '邮件内容',
      maxLines: 4,
    ),
  ];

  // 清除所有缓存
  void _clearAllCache() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('确认清除'),
          content: const Text('确定要清除所有输入缓存吗？此操作不可恢复。'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                await InputSaver.clearAll();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('所有缓存已清除'),
                    duration: Duration(seconds: 2),
                  ),
                );
                // 刷新页面
                setState(() {});
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '输入框"后悔药"',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '自动保存输入内容，防止误操作导致内容丢失',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // 输入框列表
          Column(
            children: _inputConfigs.map((config) {
              return InputSaverWidget(
                config: config,
                onSubmit: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${config.hintText} 已提交'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              );
            }).toList(),
          ),

          // 清除所有缓存按钮
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ElevatedButton.icon(
              onPressed: _clearAllCache,
              icon: const Icon(Icons.delete_sweep),
              label: const Text('清除所有缓存'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          // 使用说明
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '使用说明',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1. 输入内容时会自动保存到本地',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '2. 误清空后可点击"恢复上次输入"按钮',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '3. 提交后内容会继续保存在本地',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '4. 可随时清除不需要的缓存',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
