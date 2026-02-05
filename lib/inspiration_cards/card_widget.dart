import 'package:flutter/material.dart';
import 'inspiration_model.dart';

class CardWidget extends StatefulWidget {
  final InspirationCard card;
  final Function(InspirationCard) onTap;
  final double scale;
  final double elevation;
  final int index;

  const CardWidget({
    Key? key,
    required this.card,
    required this.onTap,
    this.scale = 1.0,
    this.elevation = 2.0,
    required this.index,
  }) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse().whenComplete(() {
      widget.onTap(widget.card);
    });
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..scale(widget.scale * _scaleAnimation.value)
        ..rotateZ(_rotationAnimation.value * (widget.index % 2 == 0 ? 1 : -1)),
      alignment: Alignment.center,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: Card(
          elevation: widget.elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Content
                Text(
                  widget.card.content,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 12),
                
                // Tags
                if (widget.card.tags.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: widget.card.tags.map((tag) {
                      return Chip(
                        label: Text(
                          tag,
                          style: TextStyle(fontSize: 12),
                        ),
                        backgroundColor: Colors.blue[100],
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        labelPadding: EdgeInsets.symmetric(horizontal: 4),
                      );
                    }).toList(),
                  ),
                
                SizedBox(height: 8),
                
                // Timestamp
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    _formatDate(widget.card.createdAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return '刚刚';
        } else {
          return '${difference.inMinutes}分钟前';
        }
      } else {
        return '${difference.inHours}小时前';
      }
    } else if (difference.inDays == 1) {
      return '昨天';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
  }
}
