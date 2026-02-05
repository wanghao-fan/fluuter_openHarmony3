import 'package:flutter/material.dart';
import 'inspiration_model.dart';

class AddCardForm extends StatefulWidget {
  final Function(InspirationCard) onAddCard;

  const AddCardForm({
    Key? key,
    required this.onAddCard,
  }) : super(key: key);

  @override
  _AddCardFormState createState() => _AddCardFormState();
}

class _AddCardFormState extends State<AddCardForm> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  List<String> _selectedTags = [];

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final card = InspirationCard(
        id: DateTime.now().toString(),
        content: _contentController.text,
        tags: _selectedTags,
      );
      widget.onAddCard(card);
      _resetForm();
    }
  }

  void _resetForm() {
    _contentController.clear();
    setState(() {
      _selectedTags = [];
    });
  }

  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                '添加灵感',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: '灵感内容',
                  hintText: '一句话记录你的灵感...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入灵感内容';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              
              // Tags
              Text(
                '选择标签',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: predefinedTags.map((tag) {
                  return FilterChip(
                    label: Text(tag),
                    selected: _selectedTags.contains(tag),
                    onSelected: (selected) => _toggleTag(tag),
                    selectedColor: Colors.blue[100],
                    backgroundColor: Colors.grey[100],
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  '添加灵感',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
