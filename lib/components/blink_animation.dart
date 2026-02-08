import 'package:flutter/material.dart';

class BlinkAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool isBlinking;
  final Function()? onTap;

  const BlinkAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.isBlinking = true,
    this.onTap,
  }) : super(key: key);

  @override
  State<BlinkAnimation> createState() => _BlinkAnimationState();
}

class _BlinkAnimationState extends State<BlinkAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.3).animate(_controller);
    _startAnimation();
  }

  void _startAnimation() {
    if (widget.isBlinking) {
      _controller.repeat(reverse: true);
    }
  }

  void _stopAnimation() {
    _controller.stop();
  }

  @override
  void didUpdateWidget(covariant BlinkAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isBlinking != oldWidget.isBlinking) {
      if (widget.isBlinking) {
        _startAnimation();
      } else {
        _stopAnimation();
      }
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
      onTap: widget.onTap,
      child: FadeTransition(
        opacity: _animation,
        child: widget.child,
      ),
    );
  }
}

class BlinkAnimationExample extends StatefulWidget {
  const BlinkAnimationExample({Key? key}) : super(key: key);

  @override
  State<BlinkAnimationExample> createState() => _BlinkAnimationExampleState();
}

class _BlinkAnimationExampleState extends State<BlinkAnimationExample> {
  List<bool> _isBlinkingList = [true, true, true, true];

  void _toggleBlink(int index) {
    setState(() {
      _isBlinkingList[index] = !_isBlinkingList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('闪烁动画示例'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '点击以下元素切换闪烁状态',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            
            // 闪烁文本
            BlinkAnimation(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '紧急通知',
                  style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              duration: Duration(milliseconds: 500),
              isBlinking: _isBlinkingList[0],
              onTap: () => _toggleBlink(0),
            ),
            SizedBox(height: 30),
            
            // 闪烁按钮
            BlinkAnimation(
              child: ElevatedButton(
                onPressed: () => _toggleBlink(1),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('点击我'),
              ),
              duration: Duration(milliseconds: 800),
              isBlinking: _isBlinkingList[1],
              onTap: () => _toggleBlink(1),
            ),
            SizedBox(height: 30),
            
            // 闪烁图标
            BlinkAnimation(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.notifications_active,
                  size: 48,
                  color: Colors.red,
                ),
              ),
              duration: Duration(milliseconds: 1200),
              isBlinking: _isBlinkingList[2],
              onTap: () => _toggleBlink(2),
            ),
            SizedBox(height: 30),
            
            // 闪烁卡片
            BlinkAnimation(
              child: Container(
                padding: EdgeInsets.all(24),
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
                child: Column(
                  children: [
                    Text(
                      '促销信息',
                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '限时折扣，机不可失',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              duration: Duration(milliseconds: 1500),
              isBlinking: _isBlinkingList[3],
              onTap: () => _toggleBlink(3),
            ),
            SizedBox(height: 40),
            
            Text(
              '提示：点击元素可以切换闪烁状态',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
