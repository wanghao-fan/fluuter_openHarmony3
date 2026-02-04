import 'package:flutter/material.dart';
import 'package:aa/widgets/qr_code_generator.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            QrCodeGenerator(
              title: '文本二维码',
              initialData: 'Hello, Flutter for OpenHarmony!',
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 40),
            QrCodeGenerator(
              title: '链接二维码',
              initialData: 'https://www.openharmony.cn/',
              width: 250,
              height: 250,
              qrColor: Colors.blue,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
