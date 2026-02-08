import 'package:flutter/material.dart';

class NeonTextAnimation extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color primaryColor;
  final Color secondaryColor;
  final Duration animationDuration;

  const NeonTextAnimation({
    super.key,
    required this.text,
    this.fontSize = 36,
    this.primaryColor = Colors.cyan,
    this.secondaryColor = Colors.purple,
    this.animationDuration = const Duration(seconds: 2),
  });

  @override
  State<NeonTextAnimation> createState() => _NeonTextAnimationState();
}

class _NeonTextAnimationState extends State<NeonTextAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Color?> _colorAnimation;
  bool _isAnimating = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _colorAnimation = ColorTween(
      begin: widget.primaryColor,
      end: widget.secondaryColor,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  void _toggleAnimation() {
    setState(() {
      _isAnimating = !_isAnimating;
      if (_isAnimating) {
        if (_controller.status == AnimationStatus.dismissed) {
          _controller.forward();
        } else {
          _controller.forward();
        }
      } else {
        _controller.stop();
      }
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
      onTap: _toggleAnimation,
      child: AnimatedBuilder(
        animation: Listenable.merge([_opacityAnimation, _colorAnimation]),
        builder: (context, child) {
          final currentColor = _colorAnimation.value ?? widget.primaryColor;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: currentColor.withOpacity(_opacityAnimation.value),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                  Shadow(
                    color: currentColor.withOpacity(_opacityAnimation.value * 0.8),
                    blurRadius: 20,
                    offset: const Offset(0, 0),
                  ),
                  Shadow(
                    color: currentColor.withOpacity(_opacityAnimation.value * 0.6),
                    blurRadius: 30,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
