import 'package:flutter/material.dart';
import 'widgets/notification_bar.dart';

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '通知栏效果展示',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              '以下是不同类型的通知栏：',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            
            // 信息通知
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: NotificationBar(
                message: '这是一条信息通知，用于显示一般信息',
                type: NotificationType.info,
                autoDismiss: false,
              ),
            ),
            const SizedBox(height: 20),
            
            // 成功通知
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: NotificationBar(
                message: '操作成功！数据已保存',
                type: NotificationType.success,
                autoDismiss: false,
              ),
            ),
            const SizedBox(height: 20),
            
            // 警告通知
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: NotificationBar(
                message: '警告：请检查您的输入信息',
                type: NotificationType.warning,
                autoDismiss: false,
              ),
            ),
            const SizedBox(height: 20),
            
            // 错误通知
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: NotificationBar(
                message: '错误：操作失败，请重试',
                type: NotificationType.error,
                autoDismiss: false,
              ),
            ),
            const SizedBox(height: 40),
            
            ElevatedButton(
              onPressed: () {
                NotificationManager.info(context, '这是一条信息通知');
              },
              child: const Text('显示信息通知'),
            ),
            const SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: () {
                NotificationManager.success(context, '操作成功！');
              },
              child: const Text('显示成功通知'),
            ),
            const SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: () {
                NotificationManager.warning(context, '警告信息');
              },
              child: const Text('显示警告通知'),
            ),
            const SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: () {
                NotificationManager.error(context, '操作失败！');
              },
              child: const Text('显示错误通知'),
            ),
          ],
        ),
      ),
    );
  }
}
