import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DynamicBarChart extends StatefulWidget {
  final List<String> labels;
  final List<double> values;
  final Function(int)? onBarTap;
  final Color? barColor;
  final Color? backgroundColor;

  const DynamicBarChart({
    super.key,
    required this.labels,
    required this.values,
    this.onBarTap,
    this.barColor = Colors.teal,
    this.backgroundColor = Colors.grey,
  });

  @override
  State<DynamicBarChart> createState() => _DynamicBarChartState();
}

class _DynamicBarChartState extends State<DynamicBarChart> {
  int _selectedIndex = -1;
  final Duration _animationDuration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: _buildBarGroups(),
        gridData: FlGridData(
          show: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.labels[value.toInt()],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                );
              },
              interval: 1,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barTouchData: BarTouchData(
          enabled: true,
          touchCallback: (event, response) {
            if (response != null && response.spot != null) {
              setState(() {
                _selectedIndex = response.spot!.touchedBarGroupIndex;
              });
              if (widget.onBarTap != null) {
                widget.onBarTap!(_selectedIndex);
              }
            }
          },
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.black.withAlpha(200),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${widget.labels[groupIndex]}: ${rod.toY}',
                TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        alignment: BarChartAlignment.spaceAround,
        maxY: widget.values.reduce((a, b) => a > b ? a : b) * 1.2,
      ),
      swapAnimationDuration: _animationDuration,
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(
      widget.labels.length,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: widget.values[index],
            color: index == _selectedIndex 
                ? widget.barColor!.withAlpha(200) 
                : widget.barColor,
            width: 20,
            borderRadius: BorderRadius.circular(4),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: widget.values.reduce((a, b) => a > b ? a : b) * 1.2,
              color: widget.barColor!.withAlpha(50),
            ),
          ),
        ],
        showingTooltipIndicators: _selectedIndex == index ? [0] : [],
      ),
    );
  }
}
