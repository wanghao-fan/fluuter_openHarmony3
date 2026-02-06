import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class RouletteWheel extends StatefulWidget {
  final List<String> options;
  final double size;
  final Function(String)? onSelected;

  const RouletteWheel({
    Key? key,
    required this.options,
    this.size = 300.0,
    this.onSelected,
  }) : super(key: key);

  @override
  _RouletteWheelState createState() => _RouletteWheelState();
}

class _RouletteWheelState extends State<RouletteWheel> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _rotation = 0.0;
  bool _isSpinning = false;
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void spin() {
    if (_isSpinning) return;

    setState(() {
      _isSpinning = true;
      _selectedOption = null;
    });

    final random = Random();
    final randomRotation = random.nextDouble() * 360 + 1080; // 至少转3圈
    final finalRotation = _rotation + randomRotation;

    _animation = Tween<double>(begin: _rotation, end: finalRotation).animate(
      CurvedAnimation(parent: _controller, curve: Curves.decelerate),
    )..addListener(() {
        setState(() {
          _rotation = _animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _rotation = finalRotation % 360;
          _determineSelectedOption();
          setState(() {
            _isSpinning = false;
          });
        }
      });

    _controller.reset();
    _controller.forward();
  }

  void _determineSelectedOption() {
    final normalizedRotation = _rotation % 360;
    final anglePerOption = 360.0 / widget.options.length;
    final selectedIndex = ((360 - normalizedRotation) / anglePerOption).floor() % widget.options.length;
    _selectedOption = widget.options[selectedIndex];
    if (widget.onSelected != null) {
      widget.onSelected!(_selectedOption!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: spin,
          child: Container(
            width: widget.size,
            height: widget.size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: _rotation * pi / 180,
                  child: CustomPaint(
                    size: Size(widget.size, widget.size),
                    painter: RoulettePainter(options: widget.options),
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Positioned(
                  top: 5,
                  child: Container(
                    width: 10,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _isSpinning ? null : spin,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          child: Text(
            _isSpinning ? '转动中...' : '开始转动',
            style: TextStyle(fontSize: 16),
          ),
        ),
        if (_selectedOption != null)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              '选中: $_selectedOption',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
      ],
    );
  }
}

class RoulettePainter extends CustomPainter {
  final List<String> options;

  RoulettePainter({required this.options});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final anglePerOption = 2 * pi / options.length;

    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
    ];

    for (int i = 0; i < options.length; i++) {
      final startAngle = i * anglePerOption;
      final endAngle = (i + 1) * anglePerOption;

      final paint = Paint()..color = colors[i % colors.length];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        endAngle - startAngle,
        true,
        paint,
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: options[i],
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: radius * 0.8);

      final textAngle = startAngle + (endAngle - startAngle) / 2;
      final textRadius = radius * 0.6;
      final textOffset = Offset(
        center.dx + cos(textAngle) * textRadius - textPainter.width / 2,
        center.dy + sin(textAngle) * textRadius - textPainter.height / 2,
      );

      textPainter.paint(canvas, textOffset);
    }

    // 绘制中心圆
    final centerPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius * 0.1, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
