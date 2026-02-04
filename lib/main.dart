import 'package:flutter/material.dart';
import 'package:aa/widgets/fl_horizontal_bar_chart.dart';

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
  // 横向柱状图数据
  final List<Map<String, dynamic>> barData1 = [
    {'value': 335, 'name': '直接访问'},
    {'value': 310, 'name': '邮件营销'},
    {'value': 234, 'name': '联盟广告'},
    {'value': 135, 'name': '视频广告'},
    {'value': 1548, 'name': '搜索引擎'}
  ];

  final List<Map<String, dynamic>> barData2 = [
    {'value': 120, 'name': 'A产品'},
    {'value': 200, 'name': 'B产品'},
    {'value': 150, 'name': 'C产品'},
    {'value': 80, 'name': 'D产品'},
    {'value': 70, 'name': 'E产品'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            // 第一个横向柱状图
            FlHorizontalBarChart(
              title: '访问来源分析',
              data: barData1,
            ),
            const SizedBox(height: 40),
            // 第二个横向柱状图
            FlHorizontalBarChart(
              title: '产品销售分布',
              data: barData2,
            ),
            const SizedBox(height: 40),
            const Text(
              '交互说明：点击柱状图查看详细信息',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
