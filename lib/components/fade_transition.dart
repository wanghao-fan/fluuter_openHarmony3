import 'package:flutter/material.dart';

class FadeTransitionWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Function()? onTap;

  const FadeTransitionWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.onTap,
  }) : super(key: key);

  @override
  State<FadeTransitionWidget> createState() => _FadeTransitionWidgetState();
}

class _FadeTransitionWidgetState extends State<FadeTransitionWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..value = 1.0; // 初始状态为完全不透明
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

  void _toggleOpacity() {
    setState(() {
      _isVisible = !_isVisible;
      if (_isVisible) {
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
        _toggleOpacity();
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: FadeTransition(
        opacity: _animation,
        child: widget.child,
      ),
    );
  }
}

class AnimatedOpacityWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Function()? onTap;

  const AnimatedOpacityWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.onTap,
  }) : super(key: key);

  @override
  State<AnimatedOpacityWidget> createState() => _AnimatedOpacityWidgetState();
}

class _AnimatedOpacityWidgetState extends State<AnimatedOpacityWidget> {
  double _opacity = 1.0; // 初始状态为完全不透明
  bool _isVisible = true;

  void _toggleOpacity() {
    setState(() {
      _isVisible = !_isVisible;
      _opacity = _isVisible ? 1.0 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _toggleOpacity();
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: widget.duration,
        curve: widget.curve,
        child: widget.child,
      ),
    );
  }
}

class FadeTransitionExample extends StatefulWidget {
  const FadeTransitionExample({Key? key}) : super(key: key);

  @override
  State<FadeTransitionExample> createState() => _FadeTransitionExampleState();
}

class _FadeTransitionExampleState extends State<FadeTransitionExample> {
  int _fadeTransitionCount = 0;
  int _animatedOpacityCount = 0;

  void _incrementFadeTransitionCounter() {
    setState(() {
      _fadeTransitionCount++;
    });
  }

  void _incrementAnimatedOpacityCounter() {
    setState(() {
      _animatedOpacityCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('透明度过渡动画示例'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '透明度过渡动画示例',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'FadeTransition vs AnimatedOpacity',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 40),

            // FadeTransition 示例
            Column(
              children: [
                Text(
                  'FadeTransition',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                FadeTransitionWidget(
                  child: Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        '点击我',
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.bounceInOut,
                  onTap: _incrementFadeTransitionCounter,
                ),
                SizedBox(height: 10),
                Text(
                  '点击计数: $_fadeTransitionCount',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 60),

            // AnimatedOpacity 示例
            Column(
              children: [
                Text(
                  'AnimatedOpacity',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                AnimatedOpacityWidget(
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
                  duration: Duration(milliseconds: 500),
                  curve: Curves.bounceInOut,
                  onTap: _incrementAnimatedOpacityCounter,
                ),
                SizedBox(height: 10),
                Text(
                  '点击计数: $_animatedOpacityCount',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 40),

            // 对比说明
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '两者区别：',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('1. FadeTransition: 需要手动管理 AnimationController，更灵活，可控制动画生命周期'),
                  Text('2. AnimatedOpacity: 内部管理动画，使用更简单，适合基本的透明度变化'),
                  Text('3. FadeTransition: 可与其他动画组合使用，适合复杂动画场景'),
                  Text('4. AnimatedOpacity: 代码更简洁，适合简单的透明度切换'),
                ],
              ),
            ),
            SizedBox(height: 20),

            // 提示信息
            Text(
              '提示：点击彩色方块查看透明度过渡效果',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
