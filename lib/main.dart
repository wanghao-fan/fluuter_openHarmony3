import 'package:flutter/material.dart';
import 'package:aa/widgets/collapse_widget.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Flutter for OpenHarmony - Collapse 折叠面板示例',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            CollapseWidget(
              title: '折叠面板 1',
              isExpanded: false,
              headerColor: Colors.blue[50],
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '这是第一个折叠面板的内容。点击头部可以展开或收起内容。\n\n' 
                  'Flutter for OpenHarmony 提供了良好的跨平台支持，' 
                  '可以在不同设备上实现一致的用户体验。',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              onExpansionChanged: (expanded) {
                print('折叠面板 1 状态: $expanded');
              },
            ),
            
            CollapseWidget(
              title: '折叠面板 2',
              isExpanded: true,
              headerColor: Colors.green[50],
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '这是第二个折叠面板的内容，默认是展开状态。',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '折叠面板可以包含任何类型的 Widget，' 
                      '比如列表、图片、表单等。',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              onExpansionChanged: (expanded) {
                print('折叠面板 2 状态: $expanded');
              },
            ),
            
            CollapseWidget(
              title: '折叠面板 3',
              isExpanded: false,
              headerColor: Colors.orange[50],
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '这是第三个折叠面板的内容。\n\n' 
                  '通过点击不同的折叠面板，可以看到平滑的动画效果。',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              onExpansionChanged: (expanded) {
                print('折叠面板 3 状态: $expanded');
              },
            ),
          ],
        ),
      ),
    );
  }
}
