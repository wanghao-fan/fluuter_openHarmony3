import 'package:flutter/material.dart';
import 'dart:math';

class MatrixDigitalRain extends StatefulWidget {
  final double fontSize;
  final Color textColor;
  final Color accentColor;
  final Duration animationDuration;

  const MatrixDigitalRain({
    super.key,
    this.fontSize = 16,
    this.textColor = Colors.green,
    this.accentColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 50),
  });

  @override
  State<MatrixDigitalRain> createState() => _MatrixDigitalRainState();
}

class _MatrixDigitalRainState extends State<MatrixDigitalRain> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<MatrixColumn> _columns;
  late int _numColumns;
  late int _numRows;
  bool _isAnimating = true;
  final Random _random = Random();
  final String _characters = '01アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _controller.addListener(() {
      setState(() {
        _updateRain();
      });
    });
    _controller.repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _calculateDimensions();
  }

  void _calculateDimensions() {
    final size = MediaQuery.of(context).size;
    _numColumns = (size.width / widget.fontSize).floor();
    _numRows = (size.height / widget.fontSize).floor();
    _initializeColumns();
  }

  void _initializeColumns() {
    _columns = List.generate(_numColumns, (colIndex) {
      final column = MatrixColumn(
        index: colIndex,
        numRows: _numRows,
        fontSize: widget.fontSize,
        textColor: widget.textColor,
        accentColor: widget.accentColor,
        characters: _characters,
        random: _random,
      );
      column.reset();
      return column;
    });
  }

  void _updateRain() {
    for (final column in _columns) {
      column.update();
    }
  }

  void _toggleAnimation() {
    setState(() {
      _isAnimating = !_isAnimating;
      if (_isAnimating) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    });
  }

  void _resetAnimation() {
    setState(() {
      _initializeColumns();
      if (!_isAnimating) {
        _isAnimating = true;
        _controller.repeat();
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
      onDoubleTap: _resetAnimation,
      child: Container(
        color: Colors.black,
        child: CustomPaint(
          painter: _MatrixDigitalRainPainter(
            columns: _columns,
            fontSize: widget.fontSize,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class MatrixColumn {
  final int index;
  final int numRows;
  final double fontSize;
  final Color textColor;
  final Color accentColor;
  final String characters;
  final Random random;

  late int position;
  late int length;
  late double opacity;
  late List<String> _chars;
  late List<double> _charOpacities;

  MatrixColumn({
    required this.index,
    required this.numRows,
    required this.fontSize,
    required this.textColor,
    required this.accentColor,
    required this.characters,
    required this.random,
  }) {
    reset();
  }

  void reset() {
    position = -random.nextInt(numRows * 2);
    length = random.nextInt(10) + 5;
    opacity = 1.0;
    _chars = List.generate(numRows, (_) => _getRandomChar());
    _charOpacities = List.generate(numRows, (_) => random.nextDouble());
  }

  void update() {
    position++;
    if (position > numRows + length) {
      reset();
    }
    for (int i = 0; i < numRows; i++) {
      if (random.nextDouble() < 0.1) {
        _chars[i] = _getRandomChar();
      }
      if (random.nextDouble() < 0.05) {
        _charOpacities[i] = random.nextDouble();
      }
    }
  }

  String _getRandomChar() {
    return characters[random.nextInt(characters.length)];
  }

  void paint(Canvas canvas, Paint paint, TextPainter textPainter) {
    for (int i = 0; i < numRows; i++) {
      final char = _chars[i];
      final isInRain = i >= position && i < position + length;
      final isHead = i == position;

      if (isInRain) {
        if (isHead) {
          paint.color = accentColor.withOpacity(opacity);
        } else {
          paint.color = textColor.withOpacity(_charOpacities[i] * opacity);
        }

        textPainter.text = TextSpan(
          text: char,
          style: TextStyle(
            fontSize: fontSize,
            color: paint.color,
            fontWeight: isHead ? FontWeight.bold : FontWeight.normal,
          ),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(index * fontSize, i * fontSize),
        );
      } else if (i < position) {
        paint.color = textColor.withOpacity(_charOpacities[i] * 0.3);
        textPainter.text = TextSpan(
          text: char,
          style: TextStyle(
            fontSize: fontSize,
            color: paint.color,
          ),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(index * fontSize, i * fontSize),
        );
      }
    }
  }
}

class _MatrixDigitalRainPainter extends CustomPainter {
  final List<MatrixColumn> columns;
  final double fontSize;

  _MatrixDigitalRainPainter({
    required this.columns,
    required this.fontSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (final column in columns) {
      column.paint(canvas, paint, textPainter);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
