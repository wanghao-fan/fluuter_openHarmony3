import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class PieChart extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> data;
  final double? width;
  final double? height;

  const PieChart({
    Key? key,
    required this.title,
    required this.data,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  String _clickInfo = '';

  void _onChartTap(dynamic params) {
    if (params != null) {
      setState(() {
        _clickInfo = '点击了: $params';
      });
      // 显示点击信息提示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$params'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final option = '''
    {
      "tooltip": {
        "trigger": "item",
        "formatter": "{a} <br/>{b}: {c} ({d}%)"
      },
      "legend": {
        "orient": "vertical",
        "left": "left",
        "data": ${widget.data.map((item) => item['name']).toList()}
      },
      "series": [
        {
          "name": "数据",
          "type": "pie",
          "radius": "50%",
          "center": ["50%", "60%"],
          "data": ${widget.data},
          "emphasis": {
            "itemStyle": {
              "shadowBlur": 10,
              "shadowOffsetX": 0,
              "shadowColor": "rgba(0, 0, 0, 0.5)"
            }
          }
        }
      ]
    }
    ''';

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
            child: Echarts(
              onMessage: _onChartTap,
              option: option,
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