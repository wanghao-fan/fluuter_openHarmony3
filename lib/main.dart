import 'package:flutter/material.dart';
import 'components/bottom_sheet.dart';

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
  String _bottomSheetResult = '';

  Future<void> _showBasicBottomSheet() async {
    final result = await BottomSheetManager.showBottomSheet(
      context,
      title: '提示',
      content: const Text('这是一个基本的底部弹窗，用于显示简单信息。'),
    );
    setState(() {
      _bottomSheetResult = '基本底部弹窗结果: ${result ? '确定' : '取消'}';
    });
  }

  Future<void> _showCustomBottomSheet() async {
    final result = await BottomSheetManager.showBottomSheet(
      context,
      title: '自定义内容',
      height: 400,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('请选择您的兴趣爱好：'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: const Text('阅读'),
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: const Text('运动'),
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: const Text('音乐'),
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: const Text('旅游'),
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ],
      ),
      confirmText: '保存',
      cancelText: '取消',
    );
    setState(() {
      _bottomSheetResult = '自定义底部弹窗结果: ${result ? '保存' : '取消'}';
    });
  }

  Future<void> _showSelectionBottomSheet() async {
    final result = await BottomSheetManager.showSelectionBottomSheet(
      context,
      title: '选择城市',
      options: ['北京', '上海', '广州', '深圳', '杭州', '成都', '武汉', '西安'],
    );
    setState(() {
      _bottomSheetResult = '选择底部弹窗结果: ${result ?? '未选择'}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('底部弹窗示例'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              '底部弹窗示例',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            
            ElevatedButton(
              onPressed: _showBasicBottomSheet,
              child: const Text('显示基本底部弹窗'),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: _showCustomBottomSheet,
              child: const Text('显示自定义内容底部弹窗'),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: _showSelectionBottomSheet,
              child: const Text('显示选项选择底部弹窗'),
            ),
            const SizedBox(height: 40),
            
            const Text(
              '底部弹窗结果:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _bottomSheetResult,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
