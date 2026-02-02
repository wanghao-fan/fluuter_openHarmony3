import 'package:flutter/material.dart';

/// 页面转场动画类型枚举
enum TransitionType {
  fade,       // 淡入淡出
  slide,      // 滑动
  scale,      // 缩放
  rotate,     // 旋转
  slideUp,    // 向上滑动
  slideDown,  // 向下滑动
  slideLeft,  // 向左滑动
  slideRight, // 向右滑动
}

/// 页面转场动画组件
class TransitionAnimation extends StatefulWidget {
  final TransitionType transitionType;
  final Widget child;
  final Duration duration;
  final Curve curve;

  const TransitionAnimation({
    Key? key,
    required this.transitionType,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  @override
  State<TransitionAnimation> createState() => _TransitionAnimationState();
}

class _TransitionAnimationState extends State<TransitionAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // 根据转场类型初始化动画
    switch (widget.transitionType) {
      case TransitionType.fade:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
      case TransitionType.slide:
      case TransitionType.slideUp:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
      case TransitionType.slideDown:
        _animation = Tween<double>(begin: -1.0, end: 0.0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
      case TransitionType.slideLeft:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
      case TransitionType.slideRight:
        _animation = Tween<double>(begin: -1.0, end: 0.0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
      case TransitionType.scale:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
      case TransitionType.rotate:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
        break;
    }

    // 启动动画
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        switch (widget.transitionType) {
          case TransitionType.fade:
            return Opacity(
              opacity: _animation.value,
              child: child,
            );
          case TransitionType.slide:
          case TransitionType.slideUp:
            return Transform.translate(
              offset: Offset(0, _animation.value * 100),
              child: Opacity(
                opacity: _animation.value,
                child: child,
              ),
            );
          case TransitionType.slideDown:
            return Transform.translate(
              offset: Offset(0, _animation.value * 100),
              child: Opacity(
                opacity: _animation.value,
                child: child,
              ),
            );
          case TransitionType.slideLeft:
            return Transform.translate(
              offset: Offset(_animation.value * 100, 0),
              child: Opacity(
                opacity: _animation.value,
                child: child,
              ),
            );
          case TransitionType.slideRight:
            return Transform.translate(
              offset: Offset(_animation.value * 100, 0),
              child: Opacity(
                opacity: _animation.value,
                child: child,
              ),
            );
          case TransitionType.scale:
            return Transform.scale(
              scale: _animation.value,
              child: Opacity(
                opacity: _animation.value,
                child: child,
              ),
            );
          case TransitionType.rotate:
            return Transform.rotate(
              angle: _animation.value * 3.14159265358979323846,
              child: Opacity(
                opacity: _animation.value,
                child: child,
              ),
            );
          default:
            return child!;
        }
      },
      child: widget.child,
    );
  }
}

/// 转场动画展示组件（用于直接在首页显示转场动画效果）
class TransitionAnimationDisplay extends StatefulWidget {
  final TransitionType transitionType;
  final String title;
  final String description;

  const TransitionAnimationDisplay({
    Key? key,
    required this.transitionType,
    this.title = '转场动画示例',
    this.description = '展示页面转场动画效果',
  }) : super(key: key);

  @override
  State<TransitionAnimationDisplay> createState() => _TransitionAnimationDisplayState();
}

class _TransitionAnimationDisplayState extends State<TransitionAnimationDisplay> {
  bool _isAnimating = false;

  /// 重新播放动画
  void _replayAnimation() {
    setState(() {
      _isAnimating = false;
    });
    // 重置动画状态
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _isAnimating = true;
      });
    });
  }

  /// 获取转场动画类型名称
  String _getTransitionTypeName() {
    switch (widget.transitionType) {
      case TransitionType.fade:
        return '淡入淡出';
      case TransitionType.slide:
        return '滑动';
      case TransitionType.scale:
        return '缩放';
      case TransitionType.rotate:
        return '旋转';
      case TransitionType.slideUp:
        return '向上滑动';
      case TransitionType.slideDown:
        return '向下滑动';
      case TransitionType.slideLeft:
        return '向左滑动';
      case TransitionType.slideRight:
        return '向右滑动';
      default:
        return '未知';
    }
  }

  @override
  void initState() {
    super.initState();
    _isAnimating = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 标题
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),

          // 描述
          Text(
            widget.description,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),

          // 动画展示区域
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1.0,
              ),
            ),
            child: _isAnimating
                ? TransitionAnimation(
                    transitionType: widget.transitionType,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.animation,
                              size: 48,
                              color: Colors.blue,
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              _getTransitionTypeName(),
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '转场动画效果',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.blue.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
          ),
          const SizedBox(height: 20.0),

          // 重播按钮
          ElevatedButton(
            onPressed: _replayAnimation,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text('重播${_getTransitionTypeName()}动画'),
          ),
        ],
      ),
    );
  }
}