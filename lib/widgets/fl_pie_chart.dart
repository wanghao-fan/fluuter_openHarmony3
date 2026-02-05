import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FlPieChart extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> data;
  final double? width;
  final double? height;

  const FlPieChart({
    Key? key,
    required this.title,
    required this.data,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<FlPieChart> createState() => _FlPieChartState();
}

class _FlPieChartState extends State<FlPieChart> {
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

  void _onChartTap(PieTouchResponse? response) {
    if (response != null && response.touchedSection != null) {
      setState(() {
        _touchedIndex = response.touchedSection!.touchedSectionIndex;
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
            child: Row(
              children: [
                // 饼图
                Expanded(
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (event, response) => _onChartTap(response),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 60,
                      sections: widget.data.asMap().entries.map((entry) {
                        final index = entry.key;
                        final data = entry.value;
                        final isTouched = index == _touchedIndex;
                        final radius = isTouched ? 100.0 : 80.0;
                        
                        return PieChartSectionData(
                          value: data['value'] is double ? data['value'] as double : (data['value'] is int ? (data['value'] as int).toDouble() : 0.0),
                          title: data['name'] as String,
                          color: colors[index % colors.length],
                          radius: radius,
                          titleStyle: TextStyle(
                            fontSize: isTouched ? 14 : 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                // 图例
                Container(
                  width: 100,
                  child: ListView.builder(
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      final data = widget.data[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: colors[index % colors.length],
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                data['name'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
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