import 'package:flutter/material.dart';
import '../template_library/template_model.dart';

class AddTemplateDialog extends StatefulWidget {
  final String categoryId;
  final Function() onTemplateAdded;

  const AddTemplateDialog({
    Key? key,
    required this.categoryId,
    required this.onTemplateAdded,
  }) : super(key: key);

  @override
  _AddTemplateDialogState createState() => _AddTemplateDialogState();
}

class _AddTemplateDialogState extends State<AddTemplateDialog> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _contentController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final template = Template(
        id: DateTime.now().toString(),
        content: _contentController.text.trim(),
        categoryId: widget.categoryId,
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      TemplateStorage.addTemplate(template);
      Navigator.of(context).pop();
      widget.onTemplateAdded();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('模板添加成功'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('添加模板'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _contentController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: '模板内容',
                hintText: '请输入模板内容',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '请输入模板内容';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: '描述（可选）',
                hintText: '请输入模板描述',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('添加'),
        ),
      ],
    );
  }
}
