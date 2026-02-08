import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class SpringAnimation extends StatefulWidget {
  final Widget child;
  final double initialScale;
  final double targetScale;
  final double stiffness;
  final double damping;
  final double mass;
  final Function()? onTap;

  const SpringAnimation({
    Key? key,
    required this.child,
    this.initialScale = 1.0,
    this.targetScale = 1.2,
    this.stiffness = 100.0,
    this.damping = 10.0,
    this.mass = 1.0,
    this.onTap,
  }) : super(key: key);

  @override
  State<SpringAnimation> createState() => _SpringAnimationState();
}

class _SpringAnimationState extends State<SpringAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    
    // 初始化动画对象
    _animation = _controller.drive(
      Tween<double>(
        begin: widget.initialScale,
        end: widget.targetScale,
      ),
    );
    
    // 添加动画监听器以便调试
    _controller.addListener(() {
      print('Animation value: ${_animation.value}');
    });
  }

  void _startAnimation() {
    if (_isAnimating) return;
    
    _isAnimating = true;
    print('Starting animation...');
    
    // 重置控制器状态
    _controller.reset();
    
    // 使用简单的曲线动画，确保基本功能正常
    _controller.animateTo(1.0, curve: Curves.elasticOut).whenComplete(() {
      print('Animation completed');
      // 动画完成后返回初始状态
      _controller.reverse().whenComplete(() {
        _controller.reset();
        _isAnimating = false;
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _startAnimation();
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}

class SpringAnimationExample extends StatefulWidget {
  const SpringAnimationExample({Key? key}) : super(key: key);

  @override
  State<SpringAnimationExample> createState() => _SpringAnimationExampleState();
}

class _SpringAnimationExampleState extends State<SpringAnimationExample> {
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
        title: Text('弹簧动画示例'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '弹簧动画示例',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            
            // 弹簧按钮
            SpringAnimation(
              child: ElevatedButton(
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: Text('点击我'),
              ),
              targetScale: 1.1,
              stiffness: 150.0,
              damping: 12.0,
              onTap: _incrementCounter,
            ),
            SizedBox(height: 30),
            
            // 弹簧卡片
            SpringAnimation(
              child: Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '点击计数: $_clickCount',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              targetScale: 1.05,
              stiffness: 100.0,
              damping: 8.0,
            ),
            SizedBox(height: 30),
            
            // 弹簧图标
            SpringAnimation(
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.favorite,
                  size: 48,
                  color: Colors.red,
                ),
              ),
              targetScale: 1.15,
              stiffness: 200.0,
              damping: 15.0,
            ),
            SizedBox(height: 40),
            
            Text(
              '提示：点击元素可以触发弹簧动画效果',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
