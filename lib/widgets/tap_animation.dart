import 'package:flutter/material.dart';

/// 点击动画效果组件
/// 提供多种点击时的动画效果
class TapAnimationWidget extends StatefulWidget {
  /// 子组件
  final Widget child;
  
  /// 动画类型
  final TapAnimationType animationType;
  
  /// 缩放比例（仅用于缩放动画）
  final double scale;
  
  /// 动画持续时间
  final Duration duration;
  
  /// 点击回调
  final VoidCallback? onTap;
  
  /// 背景颜色（仅用于波纹动画）
  final Color? rippleColor;
  
  const TapAnimationWidget({
    Key? key,
    required this.child,
    this.animationType = TapAnimationType.scale,
    this.scale = 0.95,
    this.duration = const Duration(milliseconds: 200),
    this.onTap,
    this.rippleColor,
  }) : super(key: key);

  @override
  _TapAnimationWidgetState createState() => _TapAnimationWidgetState();
}

/// 点击动画类型
enum TapAnimationType {
  /// 缩放动画
  scale,
  /// 颜色变化动画
  color,
  /// 波纹动画
  ripple,
  /// 旋转动画
  rotate,
}

class _TapAnimationWidgetState extends State<TapAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 1.0, end: widget.scale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isTapped = true;
    });
    if (widget.animationType == TapAnimationType.scale) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isTapped = false;
    });
    if (widget.animationType == TapAnimationType.scale) {
      _controller.reverse();
    }
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    setState(() {
      _isTapped = false;
    });
    if (widget.animationType == TapAnimationType.scale) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.animationType) {
      case TapAnimationType.scale:
        return GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          child: Transform.scale(
            scale: _animation.value,
            child: widget.child,
          ),
        );
      case TapAnimationType.color:
        return GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          child: Container(
            decoration: BoxDecoration(
              color: _isTapped ? Colors.white.withOpacity(0.9) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: widget.child,
          ),
        );
      case TapAnimationType.ripple:
        return InkWell(
          onTap: widget.onTap,
          splashColor: widget.rippleColor ?? Theme.of(context).primaryColor.withOpacity(0.9),
          highlightColor: Colors.transparent,
          child: widget.child,
        );
      case TapAnimationType.rotate:
        return GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          child: Transform.rotate(
            angle: _isTapped ? 0.1 : 0,
            child: widget.child,
          ),
        );
      default:
        return GestureDetector(
          onTap: widget.onTap,
          child: widget.child,
        );
    }
  }
}

/// 点击动画网格组件
/// 展示多种点击动画效果的网格布局
class TapAnimationGrid extends StatelessWidget {
  const TapAnimationGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildAnimationItem(
          context,
          title: '缩放动画',
          animationType: TapAnimationType.scale,
          color: Colors.blue,
        ),
        _buildAnimationItem(
          context,
          title: '颜色变化',
          animationType: TapAnimationType.color,
          color: Colors.green,
        ),
        _buildAnimationItem(
          context,
          title: '波纹效果',
          animationType: TapAnimationType.ripple,
          color: Colors.orange,
        ),
        _buildAnimationItem(
          context,
          title: '旋转动画',
          animationType: TapAnimationType.rotate,
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildAnimationItem(
    BuildContext context,
    {
      required String title,
      required TapAnimationType animationType,
      required Color color
    }
  ) {
    return TapAnimationWidget(
      animationType: animationType,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('点击了：$title')),
        );
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

/// 点击动画容器组件
/// 包含多种点击动画效果的展示
class TapAnimationContainer extends StatelessWidget {
  const TapAnimationContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            '点击动画效果',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '点击下方卡片查看不同的动画效果：',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        SizedBox(height: 16),
        TapAnimationGrid(),
        SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            '自定义点击动画',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TapAnimationWidget(
            animationType: TapAnimationType.scale,
            scale: 0.9,
            duration: Duration(milliseconds: 300),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('自定义缩放动画')),
              );
            },
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.pink],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '自定义缩放动画',
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
      ],
    );
  }
}