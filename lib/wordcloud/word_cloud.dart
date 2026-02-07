import 'dart:math';
import 'package:flutter/material.dart';

class WordCloud extends StatefulWidget {
  final List<WordData> words;
  final double width;
  final double height;
  final Color baseColor;
  final ValueChanged<WordData>? onWordTap;

  const WordCloud({
    Key? key,
    required this.words,
    required this.width,
    required this.height,
    this.baseColor = Colors.blue,
    this.onWordTap,
  }) : super(key: key);

  @override
  _WordCloudState createState() => _WordCloudState();
}

class WordData {
  final String text;
  final double frequency;
  Offset position;
  bool isSelected;

  WordData({
    required this.text,
    required this.frequency,
    this.position = Offset.zero,
    this.isSelected = false,
  });
}

class _WordCloudState extends State<WordCloud> {
  late List<WordData> _words;
  WordData? _selectedWord;

  @override
  void initState() {
    super.initState();
    _initializeWords();
    _generateLayout();
  }

  void _initializeWords() {
    _words = widget.words.map((word) => WordData(
      text: word.text,
      frequency: word.frequency,
      position: Offset.zero,
      isSelected: false,
    )).toList();
  }

  void _generateLayout() {
    final center = Offset(widget.width / 2, widget.height / 2);
    final random = Random();

    for (int i = 0; i < _words.length; i++) {
      final word = _words[i];
      final angle = random.nextDouble() * 2 * pi;
      final distance = sqrt(i) * 30.0;
      final x = center.dx + cos(angle) * distance;
      final y = center.dy + sin(angle) * distance;

      word.position = Offset(
        max(0, min(widget.width - 100, x)),
        max(0, min(widget.height - 50, y)),
      );
    }

    setState(() {});
  }

  void _handleTap(Offset position) {
    for (final word in _words) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: word.text,
          style: TextStyle(
            fontSize: 12 + word.frequency * 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();

      final rect = Rect.fromCenter(
        center: word.position,
        width: textPainter.width + 20,
        height: textPainter.height + 10,
      );

      if (rect.contains(position)) {
        setState(() {
          if (_selectedWord != null) {
            _selectedWord!.isSelected = false;
          }
          word.isSelected = true;
          _selectedWord = word;
        });
        widget.onWordTap?.call(word);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: GestureDetector(
        onTapUp: (details) {
          _handleTap(details.localPosition);
        },
        child: CustomPaint(
          painter: _WordCloudPainter(
            words: _words,
            baseColor: widget.baseColor,
          ),
        ),
      ),
    );
  }
}

class _WordCloudPainter extends CustomPainter {
  final List<WordData> words;
  final Color baseColor;

  _WordCloudPainter({
    required this.words,
    required this.baseColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final word in words) {
      final fontSize = 12 + word.frequency * 18;
      final textPainter = TextPainter(
        text: TextSpan(
          text: word.text,
          style: TextStyle(
            color: word.isSelected ? Colors.white : _getWordColor(word),
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();

      // 绘制背景
      if (word.isSelected) {
        final paint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill;
        final rect = Rect.fromCenter(
          center: word.position,
          width: textPainter.width + 20,
          height: textPainter.height + 10,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(8)),
          paint,
        );
      }

      // 绘制文字
      textPainter.paint(
        canvas,
        Offset(
          word.position.dx - textPainter.width / 2,
          word.position.dy - textPainter.height / 2,
        ),
      );
    }
  }

  Color _getWordColor(WordData word) {
    final hue = (baseColor.value >> 16) & 0xFF;
    final saturation = ((baseColor.value >> 8) & 0xFF) / 255.0;
    final lightness = (baseColor.value & 0xFF) / 255.0;

    final adjustedLightness = lightness * (0.7 + word.frequency * 0.3);

    return HSLColor.fromAHSL(
      1.0,
      hue.toDouble(),
      saturation,
      adjustedLightness,
    ).toColor();
  }

  @override
  bool shouldRepaint(_WordCloudPainter oldDelegate) {
    return oldDelegate.words != words;
  }
}
