import 'package:flutter/material.dart';
import 'components/weather_animation.dart';

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
  WeatherType _currentWeather = WeatherType.sunny;

  void _toggleWeather() {
    setState(() {
      switch (_currentWeather) {
        case WeatherType.sunny:
          _currentWeather = WeatherType.rainy;
          break;
        case WeatherType.rainy:
          _currentWeather = WeatherType.snowy;
          break;
        case WeatherType.snowy:
          _currentWeather = WeatherType.sunny;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '天气动画示例',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),

            // 天气动画
            WeatherAnimation(
              weatherType: _currentWeather,
              size: 300,
              onTap: _toggleWeather,
            ),
            SizedBox(height: 30),

            // 天气信息
            Text(
              _getWeatherText(_currentWeather),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // 提示信息
            Text(
              '点击动画区域切换天气',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  String _getWeatherText(WeatherType weatherType) {
    switch (weatherType) {
      case WeatherType.sunny:
        return '晴天';
      case WeatherType.rainy:
        return '雨天';
      case WeatherType.snowy:
        return '雪天';
    }
  }
}
