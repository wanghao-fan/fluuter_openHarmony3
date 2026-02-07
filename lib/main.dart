import 'dart:math';
import 'package:flutter/material.dart';
import 'heatmap/heatmap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  // 创建热力图示例数据 - 15x15 网格
  final List<List<double>> _heatmapData = List.generate(
    15,
    (row) => List.generate(
      15,
      (col) {
        // 生成随机数据，中心区域值较高，边缘较低
        final centerX = 7.0;
        final centerY = 7.0;
        final distance = sqrt(pow(row - centerX, 2) + pow(col - centerY, 2));
        final maxDistance = sqrt(pow(7, 2) + pow(7, 2));
        final normalizedDistance = distance / maxDistance;
        return (1.0 - normalizedDistance) * (0.5 + Random().nextDouble() * 0.5);
      },
    ),
  );

  String _selectedCellInfo = '';

  void _handleCellTap((int, int, double) cell) {
    setState(() {
      _selectedCellInfo = '选中单元格: (${cell.$1}, ${cell.$2}), 值: ${cell.$3.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '热力图（Heatmap）生成展示',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Heatmap(
                data: _heatmapData,
                width: 400,
                height: 300,
                minColor: Colors.blue,
                maxColor: Colors.red,
                cellSpacing: 2.0,
                onCellTap: _handleCellTap,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '交互说明：',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text('• 点击单元格查看详细信息'),
            const Text('• 选中的单元格会显示白色边框'),
            const SizedBox(height: 10),
            Text(
              _selectedCellInfo,
              style: const TextStyle(fontSize: 14, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
