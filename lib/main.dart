import 'package:flutter/material.dart';
import 'widgets/permission_dialog.dart';

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
        title: const Text('Flutter for OpenHarmony'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 权限申请弹窗效果展示
            const Text(
              '权限申请弹窗效果展示',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            // 相机权限申请
            const PermissionRequestDisplay(
              permissionType: PermissionType.camera,
              title: '相机权限申请',
              description: '点击按钮申请相机权限，体验权限申请流程',
            ),
            const SizedBox(height: 20),

            // 麦克风权限申请
            const PermissionRequestDisplay(
              permissionType: PermissionType.microphone,
              title: '麦克风权限申请',
              description: '点击按钮申请麦克风权限，体验权限申请流程',
            ),
            const SizedBox(height: 20),

            // 位置权限申请
            const PermissionRequestDisplay(
              permissionType: PermissionType.location,
              title: '位置权限申请',
              description: '点击按钮申请位置权限，体验权限申请流程',
            ),
            const SizedBox(height: 20),

            // 存储权限申请
            const PermissionRequestDisplay(
              permissionType: PermissionType.storage,
              title: '存储权限申请',
              description: '点击按钮申请存储权限，体验权限申请流程',
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
