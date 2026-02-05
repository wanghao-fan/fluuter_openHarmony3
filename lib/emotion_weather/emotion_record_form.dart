import 'package:flutter/material.dart';
import 'emotion_weather_model.dart';

class EmotionRecordForm extends StatefulWidget {
  final Function(EmotionRecord) onSubmit;

  const EmotionRecordForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _EmotionRecordFormState createState() => _EmotionRecordFormState();
}

class _EmotionRecordFormState extends State<EmotionRecordForm> {
  late EmotionType _selectedEmotion;
  late DateTime _selectedDate;
  final TextEditingController _noteController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedEmotion = EmotionType.calm;
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final record = EmotionRecord(
        id: DateTime.now().toString(),
        emotion: _selectedEmotion,
        date: _selectedDate,
        note: _noteController.text.isNotEmpty ? _noteController.text : null,
      );
      widget.onSubmit(record);
      _resetForm();
    }
  }

  void _resetForm() {
    setState(() {
      _selectedEmotion = EmotionType.calm;
      _selectedDate = DateTime.now();
      _noteController.clear();
    });
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '记录情绪',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),

              // 情绪选择
              Text(
                '今天的心情',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: EmotionType.values.map((emotion) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedEmotion = emotion;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: _selectedEmotion == emotion
                            ? emotion.color.withOpacity(0.2)
                            : Colors.grey[100],
                        border: Border.all(
                          color: _selectedEmotion == emotion
                              ? emotion.color
                              : Colors.grey[300]!,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            emotion.icon,
                            size: 16,
                            color: _selectedEmotion == emotion
                                ? emotion.color
                                : Colors.grey[600],
                          ),
                          SizedBox(width: 6),
                          Text(
                            emotion.name,
                            style: TextStyle(
                              color: _selectedEmotion == emotion
                                  ? emotion.color
                                  : Colors.grey[800],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // 日期选择
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '日期',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _selectDate,
                    icon: Icon(Icons.calendar_today),
                    label: Text(
                      '${_selectedDate.year}/${_selectedDate.month}/${_selectedDate.day}',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // 备注
              TextFormField(
                controller: _noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: '备注（可选）',
                  hintText: '记录一些细节...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // 提交按钮
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 48),
                ),
                child: Text(
                  '记录情绪',
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
