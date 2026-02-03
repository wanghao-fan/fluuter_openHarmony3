import 'package:flutter/material.dart';

/// 加载动画类型
enum LoadingAnimationType {
  /// 环形加载动画
  circular,
  /// 脉冲加载动画
  pulse,
  /// 点跳动加载动画
  dots,
  /// 旋转加载动画
  rotating,
}

/// 加载动画组件
/// 提供多种类型的加载动画效果
class LoadingAnimationWidget extends StatefulWidget {
  /// 动画类型
  final LoadingAnimationType animationType;
  
  /// 加载动画大小
  final double size;
  
  /// 加载动画颜色
  final Color color;
  
  /// 动画持续时间
  final Duration duration;
  
  /// 是否显示加载文本
  final bool showText;
  
  /// 加载文本
  final String loadingText;
  
  const LoadingAnimationWidget({
    Key? key,
    this.animationType = LoadingAnimationType.circular,
    this.size = 40.0,
    this.color = Colors.blue,
    this.duration = const Duration(milliseconds: 1000),
    this.showText = false,
    this.loadingText = '加载中...',
  }) : super(key: key);

  @override
  _LoadingAnimationWidgetState createState() => _LoadingAnimationWidgetState();
}

class _LoadingAnimationWidgetState extends State<LoadingAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();

    switch (widget.animationType) {
      case LoadingAnimationType.circular:
      case LoadingAnimationType.rotating:
        _animation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: _controller, curve: Curves.linear),
        );
        break;
      case LoadingAnimationType.pulse:
        _animation = Tween<double>(begin: 0.5, end: 1).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        break;
      case LoadingAnimationType.dots:
        _animation = Tween<double>(begin: 0, end: 3).animate(
          CurvedAnimation(parent: _controller, curve: Curves.linear),
        );
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildAnimation(),
        if (widget.showText)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              widget.loadingText,
              style: TextStyle(
                color: widget.color,
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAnimation() {
    switch (widget.animationType) {
      case LoadingAnimationType.circular:
        return _buildCircularAnimation();
      case LoadingAnimationType.pulse:
        return _buildPulseAnimation();
      case LoadingAnimationType.dots:
        return _buildDotsAnimation();
      case LoadingAnimationType.rotating:
        return _buildRotatingAnimation();
      default:
        return _buildCircularAnimation();
    }
  }

  /// 构建环形加载动画
  Widget _buildCircularAnimation() {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(widget.color),
        strokeWidth: widget.size * 0.1,
      ),
    );
  }

  /// 构建脉冲加载动画
  Widget _buildPulseAnimation() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Opacity(
            opacity: _animation.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }

  /// 构建点跳动加载动画
  Widget _buildDotsAnimation() {
    return SizedBox(
      width: widget.size * 2,
      height: widget.size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final position = _animation.value;
              double scale = 0.5;
              if ((position >= index && position < index + 1) ||
                  (position < index - 2)) {
                scale = 0.5 + (position % 1) * 0.5;
              } else if (position >= index + 1 && position < index + 2) {
                scale = 1 - (position % 1) * 0.5;
              }
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: widget.size * 0.3,
                  height: widget.size * 0.3,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  /// 构建旋转加载动画
  Widget _buildRotatingAnimation() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value * 2 * 3.14159265359,
          child: Container(
            width: widget.size,
            height: widget.size,
            child: CustomPaint(
              painter: _RotatingLoadingPainter(
                color: widget.color,
                strokeWidth: widget.size * 0.1,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 旋转加载动画 painter
class _RotatingLoadingPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _RotatingLoadingPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;

    // 绘制一个不完整的圆环
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      3.14159265359 * 1.5, // 270度
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// 加载动画网格组件
/// 展示多种加载动画效果的网格布局
class LoadingAnimationGrid extends StatelessWidget {
  const LoadingAnimationGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      padding: const EdgeInsets.all(20),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildLoadingItem(
          context,
          title: '环形加载',
          animationType: LoadingAnimationType.circular,
          color: Colors.blue,
        ),
        _buildLoadingItem(
          context,
          title: '脉冲加载',
          animationType: LoadingAnimationType.pulse,
          color: Colors.green,
        ),
        _buildLoadingItem(
          context,
          title: '点跳动加载',
          animationType: LoadingAnimationType.dots,
          color: Colors.orange,
        ),
        _buildLoadingItem(
          context,
          title: '旋转加载',
          animationType: LoadingAnimationType.rotating,
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildLoadingItem(
    BuildContext context,
    {
      required String title,
      required LoadingAnimationType animationType,
      required Color color
    }
  ) {
    return Column(
      children: [
        LoadingAnimationWidget(
          animationType: animationType,
          size: 60,
          color: color,
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}

/// 加载动画容器组件
/// 展示多种加载动画效果的容器
class LoadingAnimationContainer extends StatelessWidget {
  const LoadingAnimationContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            '加载动画效果',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '以下是几种常见的加载动画效果：',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        const SizedBox(height: 20),
        LoadingAnimationGrid(),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            '自定义加载动画',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LoadingAnimationWidget(
                animationType: LoadingAnimationType.circular,
                size: 40,
                color: Colors.red,
                duration: Duration(milliseconds: 800),
                showText: true,
                loadingText: '快速加载',
              ),
              LoadingAnimationWidget(
                animationType: LoadingAnimationType.pulse,
                size: 40,
                color: Colors.blue,
                duration: Duration(milliseconds: 1500),
                showText: true,
                loadingText: '慢速脉冲',
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }
}