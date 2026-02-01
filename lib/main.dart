import 'package:flutter/material.dart';
import 'components/tag_input.dart';

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
  List<String> _tags = [];

  void _onTagsChanged(List<String> tags) {
    setState(() {
      _tags = tags;
    });
    print('Tags changed: $tags');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('标签输入框功能'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '标签输入示例',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16.0),
            
            // 基本标签输入
            const Text('基本标签输入：'),
            const SizedBox(height: 8.0),
            TagInput(
              initialTags: ['Flutter', 'OpenHarmony', '移动开发'],
              hintText: '输入标签并按回车添加',
              onTagsChanged: _onTagsChanged,
            ),
            const SizedBox(height: 24.0),
            
            // 带最大标签限制的标签输入
            const Text('带最大标签限制的标签输入：'),
            const SizedBox(height: 8.0),
            TagInput(
              maxTags: 5,
              hintText: '最多添加5个标签',
              onTagsChanged: (tags) {
                print('Limited tags changed: $tags');
              },
            ),
            const SizedBox(height: 24.0),
            
            // 显示当前标签
            const Text('当前标签：'),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _tags.map((tag) {
                return Chip(
                  label: Text(tag),
                  backgroundColor: Colors.deepPurple[100],
                  labelStyle: TextStyle(color: Colors.deepPurple[800]),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
