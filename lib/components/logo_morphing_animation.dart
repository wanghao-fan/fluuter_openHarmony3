import 'package:flutter/material.dart';

class LogoMorphingAnimation extends StatefulWidget {
  const LogoMorphingAnimation({super.key});

  @override
  State<LogoMorphingAnimation> createState() => _LogoMorphingAnimationState();
}

class _LogoMorphingAnimationState extends State<LogoMorphingAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentShapeIndex = 0;
  final List<Path> _shapes = [];

  @override
  void initState() {
    super.initState();
    _initializeShapes();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _currentShapeIndex = (_currentShapeIndex + 1) % _shapes.length;
          _controller.reset();
          _controller.forward();
        }
      });
    _controller.forward();
  }

  void _initializeShapes() {
    // Flutter Logo shape
    final flutterPath = Path();
    flutterPath.moveTo(100, 50);
    flutterPath.cubicTo(150, 0, 200, 0, 200, 50);
    flutterPath.cubicTo(200, 100, 150, 150, 100, 100);
    flutterPath.cubicTo(50, 150, 0, 100, 0, 50);
    flutterPath.cubicTo(0, 0, 50, 0, 100, 50);
    _shapes.add(flutterPath);

    // OpenHarmony Logo shape (simplified)
    final openHarmonyPath = Path();
    openHarmonyPath.moveTo(100, 20);
    openHarmonyPath.lineTo(180, 60);
    openHarmonyPath.lineTo(180, 140);
    openHarmonyPath.lineTo(100, 180);
    openHarmonyPath.lineTo(20, 140);
    openHarmonyPath.lineTo(20, 60);
    openHarmonyPath.close();
    _shapes.add(openHarmonyPath);

    // Circle shape
    final circlePath = Path();
    circlePath.addOval(Rect.fromCircle(center: const Offset(100, 100), radius: 80));
    _shapes.add(circlePath);

    // Square shape
    final squarePath = Path();
    squarePath.addRect(Rect.fromLTWH(20, 20, 160, 160));
    _shapes.add(squarePath);
  }

  Path _getPathAt(double value) {
    final currentPath = _shapes[_currentShapeIndex];
    final nextPath = _shapes[(_currentShapeIndex + 1) % _shapes.length];
    return Path.combine(
      PathOperation.xor,
      currentPath,
      nextPath,
    );
  }

  void _toggleAnimation() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleAnimation,
      child: Container(
        width: 200,
        height: 200,
        child: CustomPaint(
          painter: _LogoMorphingPainter(
            animationValue: _animation.value,
            currentShape: _shapes[_currentShapeIndex],
            nextShape: _shapes[(_currentShapeIndex + 1) % _shapes.length],
          ),
        ),
      ),
    );
  }
}

class _LogoMorphingPainter extends CustomPainter {
  final double animationValue;
  final Path currentShape;
  final Path nextShape;

  _LogoMorphingPainter({
    required this.animationValue,
    required this.currentShape,
    required this.nextShape,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.fill;

    final morphPath = Path();
    final currentMetrics = currentShape.computeMetrics();
    final nextMetrics = nextShape.computeMetrics();

    final currentPathMetrics = currentMetrics.toList();
    final nextPathMetrics = nextMetrics.toList();

    for (int i = 0; i < currentPathMetrics.length && i < nextPathMetrics.length; i++) {
      final currentPathMetric = currentPathMetrics[i];
      final nextPathMetric = nextPathMetrics[i];

      final currentPath = currentPathMetric.extractPath(0, currentPathMetric.length);
      final nextPath = nextPathMetric.extractPath(0, nextPathMetric.length);

      final currentPoints = _extractPoints(currentPath);
      final nextPoints = _extractPoints(nextPath);

      for (int j = 0; j < currentPoints.length && j < nextPoints.length; j++) {
        final currentPoint = currentPoints[j];
        final nextPoint = nextPoints[j];

        final x = currentPoint.dx + (nextPoint.dx - currentPoint.dx) * animationValue;
        final y = currentPoint.dy + (nextPoint.dy - currentPoint.dy) * animationValue;

        if (j == 0) {
          morphPath.moveTo(x, y);
        } else {
          morphPath.lineTo(x, y);
        }
      }

      morphPath.close();
    }

    canvas.drawPath(morphPath, paint);
  }

  List<Offset> _extractPoints(Path path) {
    final points = <Offset>[];
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      const step = 0.1;
      for (double t = 0; t <= 1; t += step) {
        final tangent = metric.getTangentForOffset(metric.length * t);
        if (tangent != null) {
          points.add(tangent.position);
        }
      }
    }

    return points;
  }

  @override
  bool shouldRepaint(covariant _LogoMorphingPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        currentShape != oldDelegate.currentShape ||
        nextShape != oldDelegate.nextShape;
  }
}
