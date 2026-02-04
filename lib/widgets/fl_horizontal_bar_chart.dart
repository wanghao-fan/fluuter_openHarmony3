import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FlHorizontalBarChart extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> data;
  final double? width;
  final double? height;

  const FlHorizontalBarChart({
    Key? key,
    required this.title,
    required this.data,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<FlHorizontalBarChart> createState() => _FlHorizontalBarChartState();
}

class _FlHorizontalBarChartState extends State<FlHorizontalBarChart> {
  int? _touchedIndex;
  String _clickInfo = '';

  // 颜色列表
  final List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.yellow,
    Colors.teal,
    Colors.pink,
  ];

  void _onBarTap(BarTouchResponse? response) {
    if (response != null && response.spot != null) {
      setState(() {
        _touchedIndex = response.spot!.touchedBarGroupIndex;
        final dataItem = widget.data[_touchedIndex!];
        _clickInfo = '点击了: ${dataItem['name']} (${dataItem['value']})';
      });
      // 显示点击信息提示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.data[_touchedIndex!]['name']}: ${widget.data[_touchedIndex!]['value']}'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 计算最大值用于Y轴缩放
    double maxValue = 0;
    for (var item in widget.data) {
      final value = item['value'] as double? ?? (item['value'] as int).toDouble();
      if (value > maxValue) {
        maxValue = value;
      }
    }
    // 向上取整到最近的100的倍数
    maxValue = (maxValue / 100).ceil() * 100;

    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 400,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                barTouchData: BarTouchData(
                  touchCallback: (event, response) => _onBarTap(response),
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.blueGrey,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final dataItem = widget.data[groupIndex];
                      return BarTooltipItem(
                        '${dataItem['name']}: ${dataItem['value']}',
                        const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 && value.toInt() < widget.data.length) {
                          return Text(
                            widget.data[value.toInt()]['name'],
                            style: const TextStyle(fontSize: 12),
                          );
                        }
                        return const Text('');
                      },
                      interval: 1,
                      reservedSize: 80,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '\$value',
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                      interval: maxValue / 5,
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  drawHorizontalLine: false,
                  verticalInterval: maxValue / 5,
                ),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    bottom: BorderSide(),
                    left: BorderSide(),
                  ),
                ),
                maxY: maxValue,
                barGroups: widget.data.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  final value = data['value'] as double? ?? (data['value'] as int).toDouble();
                  final isTouched = index == _touchedIndex;
                  final barWidth = isTouched ? 25.0 : 20.0;
                  
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: value,
                        color: colors[index % colors.length],
                        width: barWidth,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          if (_clickInfo.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                _clickInfo,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}