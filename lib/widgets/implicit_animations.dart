import 'package:flutter/material.dart';

// 淡入淡出动画组件
class FadeAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<FadeAnimationWidget> createState() => _FadeAnimationWidgetState();
}

class _FadeAnimationWidgetState extends State<FadeAnimationWidget> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // 启动动画
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: widget.duration,
      curve: Curves.easeInOut,
      child: widget.child,
    );
  }
}

// 大小变化动画组件
class SizeAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const SizeAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<SizeAnimationWidget> createState() => _SizeAnimationWidgetState();
}

class _SizeAnimationWidgetState extends State<SizeAnimationWidget> {
  double _size = 50.0;

  @override
  void initState() {
    super.initState();
    // 启动动画
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _size = 150.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: _size,
      height: _size,
      duration: widget.duration,
      curve: Curves.bounceOut,
      child: widget.child,
    );
  }
}

// 颜色变化动画组件
class ColorAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const ColorAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 4),
  });

  @override
  State<ColorAnimationWidget> createState() => _ColorAnimationWidgetState();
}

class _ColorAnimationWidgetState extends State<ColorAnimationWidget> {
  Color _color = Colors.blue;

  @override
  void initState() {
    super.initState();
    // 启动动画
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _color = Colors.red;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: _color,
      duration: widget.duration,
      curve: Curves.easeInOut,
      child: widget.child,
    );
  }
}

// 旋转动画组件
class RotationAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const RotationAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 5),
  });

  @override
  State<RotationAnimationWidget> createState() => _RotationAnimationWidgetState();
}

class _RotationAnimationWidgetState extends State<RotationAnimationWidget> {
  double _rotation = 0.0;

  @override
  void initState() {
    super.initState();
    // 启动动画
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _rotation = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: _rotation,
      duration: widget.duration,
      curve: Curves.linear,
      child: widget.child,
    );
  }
}

// 综合动画容器组件
class ImplicitAnimationContainer extends StatefulWidget {
  const ImplicitAnimationContainer({super.key});

  @override
  State<ImplicitAnimationContainer> createState() => _ImplicitAnimationContainerState();
}

class _ImplicitAnimationContainerState extends State<ImplicitAnimationContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const Center(
            child: Text(
              '隐式动画效果展示',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 40),
          
          // 淡入淡出动画
          const Center(
            child: Text(
              '淡入淡出动画',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: FadeAnimationWidget(
              child: Container(
                width: 200,
                height: 100,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Hello Animation',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          
          // 大小变化动画
          const Center(
            child: Text(
              '大小变化动画',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: SizeAnimationWidget(
              child: Container(
                color: Colors.green,
                child: const Center(
                  child: Text(
                    'Size',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          
          // 颜色变化动画
          const Center(
            child: Text(
              '颜色变化动画',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: ColorAnimationWidget(
              child: Container(
                width: 200,
                height: 100,
                child: const Center(
                  child: Text(
                    'Color',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          
          // 旋转动画
          const Center(
            child: Text(
              '旋转动画',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: RotationAnimationWidget(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.orange,
                child: const Center(
                  child: Text(
                    'Rotate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}