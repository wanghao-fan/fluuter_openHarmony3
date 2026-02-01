import 'package:flutter/material.dart';
import 'components/alert_dialog.dart';

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
  String _dialogResult = '';

  Future<void> _showBasicDialog() async {
    final result = await AlertDialogManager.showAlertDialog(
      context,
      title: '提示',
      content: '这是一个基本的提示对话框',
    );
    setState(() {
      _dialogResult = '基本对话框结果: ${result ? '确定' : '取消'}';
    });
  }

  Future<void> _showConfirmDialog() async {
    final result = await AlertDialogManager.showAlertDialog(
      context,
      title: '确认操作',
      content: '您确定要执行此操作吗？',
      confirmText: '确认',
      cancelText: '取消',
    );
    setState(() {
      _dialogResult = '确认对话框结果: ${result ? '确认' : '取消'}';
    });
  }

  Future<void> _showInfoDialog() async {
    final result = await AlertDialogManager.showAlertDialog(
      context,
      title: '信息',
      content: '这是一条重要信息',
      confirmText: '我知道了',
      showCancel: false,
    );
    setState(() {
      _dialogResult = '信息对话框结果: ${result ? '确定' : '取消'}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('提示对话框示例'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              '提示对话框示例',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            
            ElevatedButton(
              onPressed: _showBasicDialog,
              child: const Text('显示基本提示对话框'),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: _showConfirmDialog,
              child: const Text('显示确认对话框'),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: _showInfoDialog,
              child: const Text('显示信息对话框'),
            ),
            const SizedBox(height: 40),
            
            const Text(
              '对话框结果:',
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
                _dialogResult,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
