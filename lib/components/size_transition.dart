import 'package:flutter/material.dart';

class SizeTransitionWidget extends StatefulWidget {
  final Widget child;
  final Axis axis;
  final double axisAlignment;
  final Duration duration;
  final Curve curve;
  final Function()? onTap;

  const SizeTransitionWidget({
    Key? key,
    required this.child,
    this.axis = Axis.vertical,
    this.axisAlignment = 0.0,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.onTap,
  }) : super(key: key);

  @override
  State<SizeTransitionWidget> createState() => _SizeTransitionWidgetState();
}

class _SizeTransitionWidgetState extends State<SizeTransitionWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..value = 1.0; // 初始状态为展开
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSize() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _toggleSize();
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: SizeTransition(
        sizeFactor: _animation,
        axis: widget.axis,
        axisAlignment: widget.axisAlignment,
        child: widget.child,
      ),
    );
  }
}

class SizeTransitionExample extends StatefulWidget {
  const SizeTransitionExample({Key? key}) : super(key: key);

  @override
  State<SizeTransitionExample> createState() => _SizeTransitionExampleState();
}

class _SizeTransitionExampleState extends State<SizeTransitionExample> {
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
        title: Text('大小变化过渡动画示例'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '大小变化过渡动画示例',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),

            // 垂直方向大小变化
            SizeTransitionWidget(
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
              axis: Axis.vertical,
              axisAlignment: 0.0,
              duration: Duration(milliseconds: 500),
              curve: Curves.bounceInOut,
              onTap: _incrementCounter,
            ),
            SizedBox(height: 60),

            // 水平方向大小变化
            SizeTransitionWidget(
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
              axis: Axis.horizontal,
              axisAlignment: 0.0,
              duration: Duration(milliseconds: 400),
              curve: Curves.elasticOut,
              onTap: _incrementCounter,
            ),
            SizedBox(height: 40),

            // 点击计数显示
            Text(
              '点击计数: $_clickCount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // 提示信息
            Text(
              '提示：点击彩色方块查看大小变化过渡效果',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
