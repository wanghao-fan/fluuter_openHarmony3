import 'package:flutter/material.dart';

class AnimatedPaddingWidget extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry initialPadding;
  final EdgeInsetsGeometry targetPadding;
  final Duration duration;
  final Curve curve;
  final Function()? onTap;

  const AnimatedPaddingWidget({
    Key? key,
    required this.child,
    this.initialPadding = EdgeInsets.zero,
    this.targetPadding = const EdgeInsets.all(20),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
    this.onTap,
  }) : super(key: key);

  @override
  State<AnimatedPaddingWidget> createState() => _AnimatedPaddingWidgetState();
}

class _AnimatedPaddingWidgetState extends State<AnimatedPaddingWidget> {
  late EdgeInsetsGeometry _currentPadding;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _currentPadding = widget.initialPadding;
  }

  void _togglePadding() {
    setState(() {
      _isExpanded = !_isExpanded;
      _currentPadding = _isExpanded ? widget.targetPadding : widget.initialPadding;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _togglePadding();
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: AnimatedPadding(
        padding: _currentPadding,
        duration: widget.duration,
        curve: widget.curve,
        child: widget.child,
      ),
    );
  }
}

class AnimatedPaddingExample extends StatefulWidget {
  const AnimatedPaddingExample({Key? key}) : super(key: key);

  @override
  State<AnimatedPaddingExample> createState() => _AnimatedPaddingExampleState();
}

class _AnimatedPaddingExampleState extends State<AnimatedPaddingExample> {
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
        title: Text('内边距动画示例'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '内边距动画示例',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),

            // 基本内边距动画
            AnimatedPaddingWidget(
              child: Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '点击我',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              initialPadding: EdgeInsets.all(10),
              targetPadding: EdgeInsets.all(30),
              duration: Duration(milliseconds: 300),
              curve: Curves.bounceInOut,
              onTap: _incrementCounter,
            ),
            SizedBox(height: 30),

            // 不对称内边距动画
            AnimatedPaddingWidget(
              child: Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '点击我',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              initialPadding: EdgeInsets.only(left: 20, right: 20),
              targetPadding: EdgeInsets.only(left: 60, right: 60, top: 20, bottom: 20),
              duration: Duration(milliseconds: 600),
              curve: Curves.elasticOut,
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
              '提示：点击彩色方块查看内边距动画效果',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
