import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class RealTimeChart extends StatefulWidget {
  const RealTimeChart({Key? key}) : super(key: key);

  @override
  State<RealTimeChart> createState() => _RealTimeChartState();
}

class _RealTimeChartState extends State<RealTimeChart> {
  List<double> _data = [];
  List<String> _labels = [];
  Timer? _timer;
  int _counter = 0;
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _startDataStream();
  }

  void _initializeData() {
    for (int i = 0; i < 10; i++) {
      _data.add(Random().nextDouble() * 100);
      _labels.add('${i + 1}');
    }
  }

  void _startDataStream() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_isRunning) {
        setState(() {
          _counter++;
          // 模拟WebSocket推送数据
          double newData = Random().nextDouble() * 100;
          _data.add(newData);
          _labels.add('${_counter % 10 + 1}');
          
          // 保持数据点数量在10个
          if (_data.length > 10) {
            _data.removeAt(0);
            _labels.removeAt(0);
          }
        });
      }
    });
  }

  void _toggleDataStream() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '实时数据流模拟',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: _toggleDataStream,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _isRunning ? Colors.red : Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _isRunning ? '暂停' : '开始',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            child: _buildBarChart(),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            '模拟WebSocket数据推送，每秒更新一次',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildBarChart() {
    double maxValue = _data.isNotEmpty ? _data.reduce(max) : 100;
    double chartHeight = 300;

    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_data.length, (index) {
              double barHeight = (_data[index] / maxValue) * chartHeight;
              
              return InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('数据点 ${_labels[index]}: ${_data[index].toStringAsFixed(2)}')),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 30,
                      height: barHeight,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _data[index].toStringAsFixed(0),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _labels[index],
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
