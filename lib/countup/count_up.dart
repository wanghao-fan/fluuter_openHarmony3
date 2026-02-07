import 'package:flutter/material.dart';

class CountUp extends StatefulWidget {
  final num from;
  final num to;
  final Duration duration;
  final int? decimalPlaces;
  final String? prefix;
  final String? suffix;
  final TextStyle? style;
  final Function()? onComplete;
  final Function(num)? onUpdate;

  const CountUp({
    super.key,
    required this.from,
    required this.to,
    required this.duration,
    this.decimalPlaces,
    this.prefix = '',
    this.suffix = '',
    this.style,
    this.onComplete,
    this.onUpdate,
  });

  @override
  State<CountUp> createState() => _CountUpState();
}

class _CountUpState extends State<CountUp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<num> _animation;
  num _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void didUpdateWidget(covariant CountUp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.to != widget.to || oldWidget.from != widget.from) {
      _initAnimation();
    }
  }

  void _initAnimation() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = _createAnimation();
    _animation.addListener(() {
      setState(() {
        _currentValue = _animation.value;
      });
      if (widget.onUpdate != null) {
        widget.onUpdate!(_currentValue);
      }
    });

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.onComplete != null) {
        widget.onComplete!();
      }
    });

    _controller.forward();
  }

  Animation<num> _createAnimation() {
    return Tween<num>(
      begin: widget.from,
      end: widget.to,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  void restart() {
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.decimalPlaces != null
        ? _currentValue.toStringAsFixed(widget.decimalPlaces!)
        : _currentValue.round().toString();

    return Text(
      '${widget.prefix}$value${widget.suffix}',
      style: widget.style,
    );
  }
}
