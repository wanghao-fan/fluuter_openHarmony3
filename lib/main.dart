import 'package:flutter/material.dart';
import 'widgets/tap_animation.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '点击下面的按钮体验动画效果:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            
            // 缩放动画效果
            TapAnimationWidget(
              animationType: TapAnimationType.scale,
              child: ElevatedButton(
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('缩放动画', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 20),
            
            // 颜色变化动画效果
            TapAnimationWidget(
              animationType: TapAnimationType.color,
              child: ElevatedButton(
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('颜色动画', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 20),
            
            // 波纹动画效果
            TapAnimationWidget(
              animationType: TapAnimationType.ripple,
              child: ElevatedButton(
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('波纹动画', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 20),
            
            // 旋转动画效果
            TapAnimationWidget(
              animationType: TapAnimationType.rotate,
              child: ElevatedButton(
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('旋转动画', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 40),
            
            Text(
              '点击次数: $_counter',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
