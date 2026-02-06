import 'package:flutter/material.dart';
import 'dynamic_bar_chart.dart';

class ChartHome extends StatefulWidget {
  const ChartHome({super.key});

  @override
  State<ChartHome> createState() => _ChartHomeState();
}

class _ChartHomeState extends State<ChartHome> {
  final List<String> _weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  final List<double> _calorieData = [1200, 1500, 1300, 1800, 2000, 1600, 1400];
  String _message = '';

  void _handleBarTap(int index) {
    setState(() {
      _message = '点击了 ${_weekDays[index]}，卡路里: ${_calorieData[index]}';
    });

    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _message = '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动态柱状图'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 标题部分
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '动态柱状图',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '支持点击交互效果',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // 消息提示
            if (_message.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[300]!),
                ),
                child: Text(
                  _message,
                  style: TextStyle(color: Colors.blue[700]),
                ),
              ),

            // 图表部分
            Container(
              margin: const EdgeInsets.only(bottom: 30.0),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              height: 300,
              child: DynamicBarChart(
                labels: _weekDays,
                values: _calorieData,
                onBarTap: _handleBarTap,
                barColor: Colors.teal,
              ),
            ),

            // 使用说明
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '使用说明：',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('1. 图表展示了一周的卡路里消耗数据'),
                  Text('2. 点击柱状图可以查看详细信息'),
                  Text('3. 图表会高亮显示当前选中的柱状图'),
                  Text('4. 可以根据实际需求修改数据和样式'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
