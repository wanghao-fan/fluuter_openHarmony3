import 'package:flutter/material.dart';

class AnimatedPhysicalModelWidget extends StatefulWidget {
  final Widget child;
  final double initialElevation;
  final double targetElevation;
  final Color color;
  final Color shadowColor;
  final BorderRadius borderRadius;
  final bool animateColor;
  final bool animateShadowColor;
  final Duration duration;
  final Curve curve;
  final Function()? onTap;

  const AnimatedPhysicalModelWidget({
    Key? key,
    required this.child,
    this.initialElevation = 0,
    this.targetElevation = 8,
    this.color = Colors.white,
    this.shadowColor = Colors.black,
    this.borderRadius = BorderRadius.zero,
    this.animateColor = false,
    this.animateShadowColor = false,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.onTap,
  }) : super(key: key);

  @override
  State<AnimatedPhysicalModelWidget> createState() => _AnimatedPhysicalModelWidgetState();
}

class _AnimatedPhysicalModelWidgetState extends State<AnimatedPhysicalModelWidget> {
  late double _currentElevation;
  bool _isElevated = false;

  @override
  void initState() {
    super.initState();
    _currentElevation = widget.initialElevation;
  }

  void _toggleElevation() {
    setState(() {
      _isElevated = !_isElevated;
      _currentElevation = _isElevated ? widget.targetElevation : widget.initialElevation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _toggleElevation();
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: AnimatedPhysicalModel(
        elevation: _currentElevation,
        color: widget.color,
        shadowColor: widget.shadowColor,
        borderRadius: widget.borderRadius,
        animateColor: widget.animateColor,
        animateShadowColor: widget.animateShadowColor,
        duration: widget.duration,
        curve: widget.curve,
        child: widget.child,
      ),
    );
  }
}

class AnimatedPhysicalModelExample extends StatefulWidget {
  const AnimatedPhysicalModelExample({Key? key}) : super(key: key);

  @override
  State<AnimatedPhysicalModelExample> createState() => _AnimatedPhysicalModelExampleState();
}

class _AnimatedPhysicalModelExampleState extends State<AnimatedPhysicalModelExample> {
  int _clickCount = 0;

  void _incrementCounter() {
    setState(() {
      _clickCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('物理模型阴影与高程动画示例'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '物理模型阴影与高程动画示例',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),

            // 基本阴影动画
            AnimatedPhysicalModelWidget(
              child: Container(
                width: 200,
                height: 100,
                child: Center(
                  child: Text(
                    '点击我',
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              initialElevation: 0,
              targetElevation: 12,
              color: Colors.white,
              shadowColor: Colors.black,
              borderRadius: BorderRadius.circular(12),
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              onTap: _incrementCounter,
            ),
            SizedBox(height: 30),

            // 彩色阴影动画
            AnimatedPhysicalModelWidget(
              child: Container(
                width: 200,
                height: 100,
                child: Center(
                  child: Text(
                    '点击我',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              initialElevation: 0,
              targetElevation: 16,
              color: Colors.purple,
              shadowColor: Colors.purpleAccent,
              borderRadius: BorderRadius.circular(20),
              duration: Duration(milliseconds: 400),
              curve: Curves.bounceInOut,
              onTap: _incrementCounter,
            ),
            SizedBox(height: 30),

            // 点击计数显示
            Text(
              '点击计数: $_clickCount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // 提示信息
            Text(
              '提示：点击方块查看阴影与高程动画效果',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
