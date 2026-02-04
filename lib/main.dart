import 'package:flutter/material.dart';
import 'package:aa/widgets/fl_pie_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter for openHarmony',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 饼图数据
  final List<Map<String, dynamic>> pieData1 = [
    {'value': 335, 'name': '直接访问'},
    {'value': 310, 'name': '邮件营销'},
    {'value': 234, 'name': '联盟广告'},
    {'value': 135, 'name': '视频广告'},
    {'value': 1548, 'name': '搜索引擎'}
  ];

  final List<Map<String, dynamic>> pieData2 = [
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
            // 第一个饼图
            FlPieChart(
              title: '访问来源分析',
              data: pieData1,
            ),
            const SizedBox(height: 40),
            // 第二个饼图
            FlPieChart(
              title: '产品销售分布',
              data: pieData2,
            ),
            const SizedBox(height: 40),
            const Text(
              '交互说明：点击饼图扇区查看详细信息',
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
