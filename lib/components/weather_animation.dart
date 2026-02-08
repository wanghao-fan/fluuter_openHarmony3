import 'package:flutter/material.dart';
import 'dart:math';

enum WeatherType {
  sunny,
  rainy,
  snowy,
}

class WeatherAnimation extends StatefulWidget {
  final WeatherType weatherType;
  final double size;
  final Function()? onTap;

  const WeatherAnimation({
    Key? key,
    required this.weatherType,
    this.size = 300,
    this.onTap,
  }) : super(key: key);

  @override
  State<WeatherAnimation> createState() => _WeatherAnimationState();
}

class _WeatherAnimationState extends State<WeatherAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _initParticles();
  }

  void _initParticles() {
    _particles = [];
    int count = widget.weatherType == WeatherType.rainy ? 100 : 50;
    
    for (int i = 0; i < count; i++) {
      _particles.add(Particle(
        x: _random.nextDouble() * widget.size,
        y: _random.nextDouble() * widget.size,
        size: widget.weatherType == WeatherType.rainy 
            ? _random.nextDouble() * 2 + 1
            : _random.nextDouble() * 3 + 2,
        speed: widget.weatherType == WeatherType.rainy 
            ? _random.nextDouble() * 3 + 2
            : _random.nextDouble() * 1 + 0.5,
        opacity: _random.nextDouble() * 0.7 + 0.3,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WeatherAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.weatherType != widget.weatherType || oldWidget.size != widget.size) {
      _initParticles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          _updateParticles();
          return CustomPaint(
            size: Size(widget.size, widget.size),
            painter: WeatherPainter(
              weatherType: widget.weatherType,
              particles: _particles,
            ),
          );
        },
      ),
    );
  }

  void _updateParticles() {
    for (var particle in _particles) {
      if (widget.weatherType == WeatherType.rainy) {
        // 雨滴：快速下落
        particle.y += particle.speed * 5;
        if (particle.y > widget.size) {
          particle.y = 0;
          particle.x = _random.nextDouble() * widget.size;
        }
      } else if (widget.weatherType == WeatherType.snowy) {
        // 雪花：缓慢飘落，带点左右摆动
        particle.y += particle.speed;
        particle.x += sin(particle.y * 0.01) * 0.5;
        if (particle.y > widget.size) {
          particle.y = 0;
          particle.x = _random.nextDouble() * widget.size;
        }
      }
    }
  }
}

class Particle {
  double x;
  double y;
  double size;
  double speed;
  double opacity;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

class WeatherPainter extends CustomPainter {
  final WeatherType weatherType;
  final List<Particle> particles;

  WeatherPainter({
    required this.weatherType,
    required this.particles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制背景
    _drawBackground(canvas, size);

    // 绘制天气元素
    if (weatherType == WeatherType.rainy) {
      _drawRain(canvas);
    } else if (weatherType == WeatherType.snowy) {
      _drawSnow(canvas);
    } else if (weatherType == WeatherType.sunny) {
      _drawSun(canvas, size);
    }
  }

  void _drawBackground(Canvas canvas, Size size) {
    Color backgroundColor;
    switch (weatherType) {
      case WeatherType.sunny:
        backgroundColor = Colors.blue.shade300;
        break;
      case WeatherType.rainy:
        backgroundColor = Colors.grey.shade700;
        break;
      case WeatherType.snowy:
        backgroundColor = Colors.grey.shade200;
        break;
    }
    
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = backgroundColor,
    );
  }

  void _drawSun(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // 绘制太阳
    canvas.drawCircle(
      center,
      40,
      Paint()..color = Colors.yellow,
    );

    // 绘制太阳光芒
    for (int i = 0; i < 8; i++) {
      double angle = (i * pi / 4);
      double x = cos(angle) * 60;
      double y = sin(angle) * 60;
      
      canvas.drawLine(
        center,
        Offset(center.dx + x, center.dy + y),
        Paint()
          ..color = Colors.yellow
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  void _drawRain(Canvas canvas) {
    for (var particle in particles) {
      canvas.drawLine(
        Offset(particle.x, particle.y),
        Offset(particle.x, particle.y + particle.size * 5),
        Paint()
          ..color = Colors.blue.withOpacity(particle.opacity)
          ..strokeWidth = particle.size
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  void _drawSnow(Canvas canvas) {
    for (var particle in particles) {
      canvas.drawCircle(
        Offset(particle.x, particle.y),
        particle.size,
        Paint()
          ..color = Colors.white.withOpacity(particle.opacity)
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class WeatherAnimationExample extends StatefulWidget {
  const WeatherAnimationExample({Key? key}) : super(key: key);

  @override
  State<WeatherAnimationExample> createState() => _WeatherAnimationExampleState();
}

class _WeatherAnimationExampleState extends State<WeatherAnimationExample> {
  WeatherType _currentWeather = WeatherType.sunny;

  void _toggleWeather() {
    setState(() {
      switch (_currentWeather) {
        case WeatherType.sunny:
          _currentWeather = WeatherType.rainy;
          break;
        case WeatherType.rainy:
          _currentWeather = WeatherType.snowy;
          break;
        case WeatherType.snowy:
          _currentWeather = WeatherType.sunny;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('天气动画示例'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '天气动画示例',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),

            // 天气动画
            WeatherAnimation(
              weatherType: _currentWeather,
              size: 300,
              onTap: _toggleWeather,
            ),
            SizedBox(height: 30),

            // 天气信息
            Text(
              _getWeatherText(_currentWeather),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // 提示信息
            Text(
              '点击动画区域切换天气',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  String _getWeatherText(WeatherType weatherType) {
    switch (weatherType) {
      case WeatherType.sunny:
        return '晴天';
      case WeatherType.rainy:
        return '雨天';
      case WeatherType.snowy:
        return '雪天';
    }
  }
}
