import 'package:flutter/material.dart';

class TemplateTestInput extends StatefulWidget {
  final Function(String) onTemplateInsert;

  const TemplateTestInput({
    Key? key,
    required this.onTemplateInsert,
  }) : super(key: key);

  @override
  _TemplateTestInputState createState() => _TemplateTestInputState();
}

class _TemplateTestInputState extends State<TemplateTestInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _insertTemplate(String templateContent) {
    setState(() {
      _controller.text += templateContent;
    });
    widget.onTemplateInsert(templateContent);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            controller: _controller,
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
    );
  }
}
