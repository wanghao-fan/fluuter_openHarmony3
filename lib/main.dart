import 'package:flutter/material.dart';
import 'widgets/transition_animation.dart';

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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // 标题
            const Text(
              '页面转场动画效果展示',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30.0),
            
            // 淡入淡出动画
            const TransitionAnimationDisplay(
              transitionType: TransitionType.fade,
              title: '淡入淡出动画',
              description: '页面以淡入淡出的方式显示',
            ),
            const SizedBox(height: 30.0),
            
            // 滑动动画
            const TransitionAnimationDisplay(
              transitionType: TransitionType.slide,
              title: '滑动动画',
              description: '页面从下往上滑动显示',
            ),
            const SizedBox(height: 30.0),
            
            // 缩放动画
            const TransitionAnimationDisplay(
              transitionType: TransitionType.scale,
              title: '缩放动画',
              description: '页面以缩放的方式显示',
            ),
            const SizedBox(height: 30.0),
            
            // 旋转动画
            const TransitionAnimationDisplay(
              transitionType: TransitionType.rotate,
              title: '旋转动画',
              description: '页面以旋转的方式显示',
            ),
            const SizedBox(height: 30.0),
            
            // 向上滑动动画
            const TransitionAnimationDisplay(
              transitionType: TransitionType.slideUp,
              title: '向上滑动动画',
              description: '页面从底部向上滑动显示',
            ),
            const SizedBox(height: 30.0),
            
            // 向左滑动动画
            const TransitionAnimationDisplay(
              transitionType: TransitionType.slideLeft,
              title: '向左滑动动画',
              description: '页面从右侧向左滑动显示',
            ),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
