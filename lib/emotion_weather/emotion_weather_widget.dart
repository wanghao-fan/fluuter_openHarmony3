import 'package:flutter/material.dart';
import 'emotion_weather_model.dart';

class EmotionWeatherWidget extends StatefulWidget {
  final List<EmotionRecord> records;
  final Function(EmotionRecord)? onRecordTap;
  final double? itemWidth;

  const EmotionWeatherWidget({
    Key? key,
    required this.records,
    this.onRecordTap,
    this.itemWidth,
  }) : super(key: key);

  @override
  _EmotionWeatherWidgetState createState() => _EmotionWeatherWidgetState();
}

class _EmotionWeatherWidgetState extends State<EmotionWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.records.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, size: 64, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text('暂无情绪记录', style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 8),
            Text('开始记录你的情绪吧！', style: TextStyle(color: Colors.grey[500])),
          ],
        ),
      );
    }

    // 按日期排序，最新的在前面
    final sortedRecords = List<EmotionRecord>.from(widget.records)
      ..sort((a, b) => b.date.compareTo(a.date));

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '情绪天气图',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sortedRecords.length,
              itemBuilder: (context, index) {
                final record = sortedRecords[index];
                return GestureDetector(
                  onTap: () {
                    if (widget.onRecordTap != null) {
                      widget.onRecordTap!(record);
                    }
                  },
                  child: Container(
                    width: widget.itemWidth ?? 80,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 天气图标
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: record.emotion.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            record.emotion.icon,
                            size: 32,
                            color: record.emotion.color,
                          ),
                        ),
                        SizedBox(height: 8),
                        // 日期
                        Text(
                          '${record.date.month}/${record.date.day}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        // 情绪
                        Text(
                          record.emotion.name,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
