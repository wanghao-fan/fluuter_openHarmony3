import 'package:flutter/material.dart';
import 'decision_model.dart';

class AddWeightForm extends StatefulWidget {
  final Function(String, double, String) onAddWeight;

  const AddWeightForm({
    Key? key,
    required this.onAddWeight,
  }) : super(key: key);

  @override
  _AddWeightFormState createState() => _AddWeightFormState();
}

class _AddWeightFormState extends State<AddWeightForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  double _weightValue = 1.0;
  String _selectedOption = 'left';

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onAddWeight(
        _descriptionController.text,
        _weightValue,
        _selectedOption,
      );
      _resetForm();
    }
  }

  void _resetForm() {
    _descriptionController.clear();
    setState(() {
      _weightValue = 1.0;
      _selectedOption = 'left';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                '添加考虑因素',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: '因素描述',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入因素描述';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedOption,
                      decoration: InputDecoration(
                        labelText: '选择选项',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'left',
                          child: Text('左侧选项'),
                        ),
                        DropdownMenuItem(
                          value: 'right',
                          child: Text('右侧选项'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      initialValue: _weightValue.toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: '权重值',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '请输入权重值';
                        }
                        final doubleValue = double.tryParse(value);
                        if (doubleValue == null || doubleValue <= 0) {
                          return '请输入有效的权重值';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        final doubleValue = double.tryParse(value!);
                        if (doubleValue != null) {
                          setState(() {
                            _weightValue = doubleValue;
                          });
                        }
                      },
                    ),
                  ),
                ],
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
                  '添加因素',
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
