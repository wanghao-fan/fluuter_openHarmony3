import 'package:flutter/material.dart';
import 'widgets/context_menu.dart';

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
  String _selectedAction = '未选择任何操作';
  int _counter = 0;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 上下文菜单项
    final contextMenuItems = [
      ContextMenuItem(
        title: '复制',
        icon: Icons.copy,
        onTap: () {
          setState(() {
            _selectedAction = '复制';
          });
          _showSnackBar('已复制内容');
        },
      ),
      ContextMenuItem(
        title: '粘贴',
        icon: Icons.paste,
        onTap: () {
          setState(() {
            _selectedAction = '粘贴';
          });
          _showSnackBar('已粘贴内容');
        },
      ),
      ContextMenuItem(
        title: '剪切',
        icon: Icons.cut,
        onTap: () {
          setState(() {
            _selectedAction = '剪切';
          });
          _showSnackBar('已剪切内容');
        },
      ),
      ContextMenuItem(
        title: '删除',
        icon: Icons.delete,
        textColor: Colors.red,
        onTap: () {
          setState(() {
            _selectedAction = '删除';
          });
          _showSnackBar('已删除内容');
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '长按或右键点击下方元素显示上下文菜单',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // 使用上下文菜单组件
            ContextMenu(
              items: contextMenuItems,
              child: Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Center(
                  child: Text(
                    '右键/长按我',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              '最近操作: $_selectedAction',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '提示:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                '- 在桌面端：右键点击元素显示上下文菜单\n' 
                '- 在移动端：长按元素显示上下文菜单',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
