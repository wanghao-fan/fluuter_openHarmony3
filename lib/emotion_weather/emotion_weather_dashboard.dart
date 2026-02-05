import 'package:flutter/material.dart';
import 'emotion_weather_model.dart';
import 'emotion_weather_widget.dart';
import 'emotion_record_form.dart';

class EmotionWeatherDashboard extends StatefulWidget {
  const EmotionWeatherDashboard({Key? key}) : super(key: key);

  @override
  _EmotionWeatherDashboardState createState() => _EmotionWeatherDashboardState();
}

class _EmotionWeatherDashboardState extends State<EmotionWeatherDashboard> {
  List<EmotionRecord> _emotionRecords = List.from(mockEmotionRecords);

  void _addEmotionRecord(EmotionRecord record) {
    setState(() {
      _emotionRecords.add(record);
    });
  }

  void _onRecordTap(EmotionRecord record) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(record.emotion.icon, color: record.emotion.color),
              SizedBox(width: 8),
              Text(record.emotion.name),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('日期: ${record.date.year}/${record.date.month}/${record.date.day}'),
              Text('天气: ${record.emotion.weather}'),
              if (record.note != null) ...[
                SizedBox(height: 8),
                Text('备注:'),
                Text(record.note!),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('确定'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 情绪天气图
        EmotionWeatherWidget(
          records: _emotionRecords,
          onRecordTap: _onRecordTap,
        ),
        SizedBox(height: 16),
        // 情绪记录表单
        EmotionRecordForm(
          onSubmit: _addEmotionRecord,
        ),
      ],
    );
  }
}
