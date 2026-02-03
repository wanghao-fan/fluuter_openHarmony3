import 'package:flutter/material.dart';
import 'package:aa/widgets/page_stack_manager.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  final PageStackManagerController _stackController =
      PageStackManagerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // 页面栈管理组件
          Expanded(
            child: PageStackManager(
              initialPages: [
                PageStackItem(
                  title: '页面 1',
                  color: Colors.blue,
                ),
              ],
              controller: _stackController,
            ),
          ),
          // 页面栈控制按钮
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _stackController.pushPage(
                      PageStackItem(
                        title: '页面 ${_stackController.stackLength + 1}',
                        color: Colors.primaries[_stackController.stackLength %
                            Colors.primaries.length],
                      ),
                    );
                  },
                  child: const Text('添加页面'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _stackController.popPage();
                  },
                  child: const Text('返回'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _stackController.replacePage(
                      PageStackItem(
                        title: '替换页面',
                        color: Colors.green,
                      ),
                    );
                  },
                  child: const Text('替换页面'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _stackController.resetStack(
                      PageStackItem(
                        title: '重置页面',
                        color: Colors.red,
                      ),
                    );
                  },
                  child: const Text('重置栈'),
                ),
              ],
            ),
          ),
          // 页面栈状态显示
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[100],
            child: ValueListenableBuilder<int>(
              valueListenable: _stackController.stackLengthNotifier,
              builder: (context, value, child) {
                return Text(
                  '当前页面栈长度: $value',
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
