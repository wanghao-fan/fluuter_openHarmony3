import 'dart:math';
import 'package:flutter/material.dart';
import 'wordcloud/word_cloud.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter for openHarmony',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter for openHarmony'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 创建词云示例数据
  final List<WordData> _wordCloudData = [
    WordData(text: 'Flutter', frequency: 1.0),
    WordData(text: 'OpenHarmony', frequency: 0.9),
    WordData(text: 'Dart', frequency: 0.8),
    WordData(text: '移动开发', frequency: 0.75),
    WordData(text: '跨平台', frequency: 0.7),
    WordData(text: 'UI', frequency: 0.65),
    WordData(text: '动画', frequency: 0.6),
    WordData(text: '组件', frequency: 0.55),
    WordData(text: '状态管理', frequency: 0.5),
    WordData(text: '网络', frequency: 0.45),
    WordData(text: '存储', frequency: 0.4),
    WordData(text: '性能', frequency: 0.35),
    WordData(text: '测试', frequency: 0.3),
    WordData(text: '部署', frequency: 0.25),
    WordData(text: '生态', frequency: 0.2),
  ];

  String _selectedWordInfo = '';

  void _handleWordTap(WordData word) {
    setState(() {
      _selectedWordInfo = '选中词汇: ${word.text}, 频率: ${word.frequency.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '词云（Word Cloud）生成展示',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              width: 500,
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: WordCloud(
                words: _wordCloudData,
                width: 500,
                height: 400,
                baseColor: Colors.blue,
                onWordTap: _handleWordTap,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '交互说明：',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text('• 点击词汇查看详细信息'),
            const Text('• 选中的词汇会显示白色背景'),
            const SizedBox(height: 10),
            Text(
              _selectedWordInfo,
              style: const TextStyle(fontSize: 14, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
