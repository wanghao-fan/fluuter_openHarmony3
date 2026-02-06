import 'package:flutter/material.dart';
import '../template_library/template_model.dart';

class TemplateList extends StatefulWidget {
  final String categoryId;
  final Function(Template) onTemplateSelect;
  final Function() onRefresh;

  const TemplateList({
    Key? key,
    required this.categoryId,
    required this.onTemplateSelect,
    required this.onRefresh,
  }) : super(key: key);

  @override
  _TemplateListState createState() => _TemplateListState();
}

class _TemplateListState extends State<TemplateList> {
  List<Template> _templates = [];

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  @override
  void didUpdateWidget(covariant TemplateList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryId != widget.categoryId) {
      _loadTemplates();
    }
  }

  void _loadTemplates() {
    setState(() {
      _templates = TemplateStorage.getTemplatesByCategory(widget.categoryId);
    });
  }

  void _deleteTemplate(Template template) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('确认删除'),
          content: const Text('确定要删除这个模板吗？此操作不可恢复。'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                TemplateStorage.deleteTemplate(template.id);
                Navigator.of(context).pop();
                _loadTemplates();
                widget.onRefresh();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('模板已删除'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('删除'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_templates.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_add, size: 64, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text('暂无模板', style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 8),
            Text('点击右上角添加模板', style: TextStyle(color: Colors.grey[500])),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _templates.length,
      itemBuilder: (context, index) {
        final template = _templates[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            title: Text(
              template.content,
              style: TextStyle(fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: template.description != null
                ? Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      template.description!,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  )
                : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    widget.onTemplateSelect(template);
                  },
                  icon: Icon(Icons.insert_comment, color: Colors.blue),
                  tooltip: '插入模板',
                ),
                IconButton(
                  onPressed: () {
                    _deleteTemplate(template);
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                  tooltip: '删除模板',
                ),
              ],
            ),
            onTap: () {
              widget.onTemplateSelect(template);
            },
          ),
        );
      },
    );
  }
}
