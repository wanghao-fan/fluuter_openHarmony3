import 'package:flutter/material.dart';
import '../template_library/template_test_input.dart';
import '../template_library/template_dashboard.dart';

class TemplateHome extends StatefulWidget {
  const TemplateHome({Key? key}) : super(key: key);

  @override
  _TemplateHomeState createState() => _TemplateHomeState();
}

class _TemplateHomeState extends State<TemplateHome> {
  final TextEditingController _inputController = TextEditingController();

  void _onTemplateInsert(String templateContent) {
    setState(() {
      _inputController.text += templateContent;
    });
    print('插入模板: $templateContent');
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('快捷短语/模板库'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 测试输入框
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '测试输入框',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _inputController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: '请输入文本或点击下方模板插入',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '提示：点击下方模板库中的模板可直接插入到输入框',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // 模板库仪表板
            Container(
              height: 600,
              child: TemplateDashboard(
                onTemplateInsert: _onTemplateInsert,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
