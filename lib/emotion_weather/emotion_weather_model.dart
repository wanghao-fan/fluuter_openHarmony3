import 'package:flutter/material.dart';

enum EmotionType {
  happy('开心', Icons.sunny, Colors.yellow, '晴天'),
  calm('平静', Icons.cloud, Colors.blueGrey, '多云'),
  anxious('焦虑', Icons.grain_rounded, Colors.grey, '雨天'),
  sad('难过', Icons.cloud, Colors.indigo, '雷雨'),
  excited('兴奋', Icons.sunny, Colors.orange, '晴雪'),
  tired('疲惫', Icons.cloud, Colors.lightBlue, '雾天');

  final String name;
  final IconData icon;
  final Color color;
  final String weather;

  const EmotionType(this.name, this.icon, this.color, this.weather);
}

class EmotionRecord {
  final String id;
  final EmotionType emotion;
  final DateTime date;
  final String? note;

  EmotionRecord({
    required this.id,
    required this.emotion,
    required this.date,
    this.note,
  });

  EmotionRecord copyWith({
    String? id,
    EmotionType? emotion,
    DateTime? date,
    String? note,
  }) {
    return EmotionRecord(
      id: id ?? this.id,
      emotion: emotion ?? this.emotion,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }
}

// 模拟数据
List<EmotionRecord> mockEmotionRecords = [
  EmotionRecord(
    id: '1',
    emotion: EmotionType.happy,
    date: DateTime.now().subtract(Duration(days: 6)),
    note: '今天收到了好消息，心情很棒！',
  ),
  EmotionRecord(
    id: '2',
    emotion: EmotionType.calm,
    date: DateTime.now().subtract(Duration(days: 5)),
    note: '平静的一天，做了一些自己喜欢的事情。',
  ),
  EmotionRecord(
    id: '3',
    emotion: EmotionType.anxious,
    date: DateTime.now().subtract(Duration(days: 4)),
    note: '工作压力有点大，感到焦虑。',
  ),
  EmotionRecord(
    id: '4',
    emotion: EmotionType.sad,
    date: DateTime.now().subtract(Duration(days: 3)),
    note: '遇到了一些困难，心情低落。',
  ),
  EmotionRecord(
    id: '5',
    emotion: EmotionType.calm,
    date: DateTime.now().subtract(Duration(days: 2)),
    note: '慢慢调整，心情逐渐平静。',
  ),
  EmotionRecord(
    id: '6',
    emotion: EmotionType.happy,
    date: DateTime.now().subtract(Duration(days: 1)),
    note: '问题解决了，心情又好了起来！',
  ),
];
