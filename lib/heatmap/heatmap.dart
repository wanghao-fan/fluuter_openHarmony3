import 'dart:math';
import 'package:flutter/material.dart';

class Heatmap extends StatefulWidget {
  final List<List<double>> data;
  final double width;
  final double height;
  final Color minColor;
  final Color maxColor;
  final double cellSpacing;
  final ValueChanged<(int, int, double)>? onCellTap;

  const Heatmap({
    Key? key,
    required this.data,
    required this.width,
    required this.height,
    this.minColor = Colors.blue,
    this.maxColor = Colors.red,
    this.cellSpacing = 1.0,
    this.onCellTap,
  }) : super(key: key);

  @override
  _HeatmapState createState() => _HeatmapState();
}

class _HeatmapState extends State<Heatmap> {
  (int, int, double)? _selectedCell;

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty || widget.data[0].isEmpty) {
      return SizedBox(width: widget.width, height: widget.height);
    }

    final rows = widget.data.length;
    final cols = widget.data[0].length;
    final cellWidth = (widget.width - (cols - 1) * widget.cellSpacing) / cols;
    final cellHeight = (widget.height - (rows - 1) * widget.cellSpacing) / rows;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: GestureDetector(
        onTapUp: (details) {
          final x = details.localPosition.dx;
          final y = details.localPosition.dy;

          int col = min(cols - 1, (x / (cellWidth + widget.cellSpacing)).floor());
          int row = min(rows - 1, (y / (cellHeight + widget.cellSpacing)).floor());

          if (row >= 0 && row < rows && col >= 0 && col < cols) {
            final value = widget.data[row][col];
            setState(() {
              _selectedCell = (row, col, value);
            });
            widget.onCellTap?.call((row, col, value));
          }
        },
        child: CustomPaint(
          painter: _HeatmapPainter(
            data: widget.data,
            cellWidth: cellWidth,
            cellHeight: cellHeight,
            cellSpacing: widget.cellSpacing,
            minColor: widget.minColor,
            maxColor: widget.maxColor,
            selectedCell: _selectedCell,
          ),
        ),
      ),
    );
  }
}

class _HeatmapPainter extends CustomPainter {
  final List<List<double>> data;
  final double cellWidth;
  final double cellHeight;
  final double cellSpacing;
  final Color minColor;
  final Color maxColor;
  final (int, int, double)? selectedCell;

  _HeatmapPainter({
    required this.data,
    required this.cellWidth,
    required this.cellHeight,
    required this.cellSpacing,
    required this.minColor,
    required this.maxColor,
    this.selectedCell,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty || data[0].isEmpty) return;

    final rows = data.length;
    final cols = data[0].length;

    // 计算数据范围
    double minValue = double.infinity;
    double maxValue = double.negativeInfinity;

    for (var row in data) {
      for (var value in row) {
        if (value < minValue) minValue = value;
        if (value > maxValue) maxValue = value;
      }
    }

    final valueRange = maxValue - minValue;

    // 绘制单元格
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final value = data[row][col];
        final normalizedValue = valueRange > 0 ? (value - minValue) / valueRange : 0.0;
        
        // 插值颜色
        final color = Color.lerp(minColor, maxColor, normalizedValue) ?? minColor;
        
        final paint = Paint()..color = color;
        
        final x = col * (cellWidth + cellSpacing);
        final y = row * (cellHeight + cellSpacing);
        
        canvas.drawRect(
          Rect.fromLTWH(x, y, cellWidth, cellHeight),
          paint,
        );

        // 绘制选中单元格的边框
        if (selectedCell != null && selectedCell!.$1 == row && selectedCell!.$2 == col) {
          final borderPaint = Paint()
            ..color = Colors.white
            ..strokeWidth = 2.0
            ..style = PaintingStyle.stroke;
          canvas.drawRect(
            Rect.fromLTWH(x, y, cellWidth, cellHeight),
            borderPaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(_HeatmapPainter oldDelegate) {
    return oldDelegate.data != data ||
           oldDelegate.selectedCell != selectedCell;
  }
}
