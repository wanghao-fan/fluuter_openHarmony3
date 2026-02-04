import 'package:flutter/material.dart';
import 'package:aa/utils/dice_roller.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 页面标题
            Text(
              '掷骰子模拟器',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 30),
            
            // 标准6面骰子
            DiceRoller(
              sides: 6,
              size: 150,
              diceColor: Colors.white,
              dotColor: Colors.black,
            ),
            const SizedBox(height: 40),
            
            // 4面骰子
            DiceRoller(
              sides: 4,
              size: 120,
              diceColor: Colors.red,
              dotColor: Colors.white,
              textColor: Colors.white,
            ),
            const SizedBox(height: 40),
            
            // 8面骰子
            DiceRoller(
              sides: 8,
              size: 130,
              diceColor: Colors.blue,
              dotColor: Colors.white,
              textColor: Colors.white,
            ),
            const SizedBox(height: 40),
            
            // 12面骰子
            DiceRoller(
              sides: 12,
              size: 140,
              diceColor: Colors.green,
              dotColor: Colors.white,
              textColor: Colors.white,
            ),
            const SizedBox(height: 40),
            
            // 20面骰子
            DiceRoller(
              sides: 20,
              size: 160,
              diceColor: Colors.purple,
              dotColor: Colors.white,
              textColor: Colors.white,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
