import 'package:flutter/material.dart';

/// 评分弹窗组件
class RatingDialog extends StatefulWidget {
  final String title;
  final String message;
  final String submitButtonText;
  final String cancelButtonText;
  final int maxRating;
  final double iconSize;
  final Color selectedColor;
  final Color unselectedColor;
  final Function(int)? onSubmit;
  final Function()? onCancel;
  final bool barrierDismissible;

  const RatingDialog({
    Key? key,
    this.title = '请评分',
    this.message = '请为我们的服务打分',
    this.submitButtonText = '提交',
    this.cancelButtonText = '取消',
    this.maxRating = 5,
    this.iconSize = 48.0,
    this.selectedColor = Colors.amber,
    this.unselectedColor = Colors.grey,
    this.onSubmit,
    this.onCancel,
    this.barrierDismissible = true,
  }) : super(key: key);

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 标题
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12.0),

            // 消息
            Text(
              widget.message,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),

            // 评分星星
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.maxRating, (index) {
                final ratingValue = index + 1;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _rating = ratingValue;
                    });
                  },
                  child: Icon(
                    ratingValue <= _rating ? Icons.star : Icons.star_border,
                    size: widget.iconSize,
                    color: ratingValue <= _rating
                        ? widget.selectedColor
                        : widget.unselectedColor,
                  ),
                );
              }),
            ),
            const SizedBox(height: 32.0),

            // 按钮
            Row(
              children: [
                // 取消按钮
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      if (widget.onCancel != null) {
                        widget.onCancel!();
                      }
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      widget.cancelButtonText,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),

                // 提交按钮
                Expanded(
                  child: ElevatedButton(
                    onPressed: _rating > 0
                        ? () {
                            if (widget.onSubmit != null) {
                              widget.onSubmit!(_rating);
                            }
                            Navigator.of(context).pop();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      widget.submitButtonText,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 评分展示组件（用于直接在页面上显示评分效果）
class RatingDisplay extends StatefulWidget {
  final String title;
  final String description;

  const RatingDisplay({
    Key? key,
    this.title = '评分弹窗展示',
    this.description = '点击下方按钮打开评分弹窗',
  }) : super(key: key);

  @override
  State<RatingDisplay> createState() => _RatingDisplayState();
}

class _RatingDisplayState extends State<RatingDisplay> {
  void _showRatingDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => RatingDialog(
        title: '为我们评分',
        message: '请为我们的服务体验打分',
        onSubmit: (rating) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('您的评分：$rating 星'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        onCancel: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('您取消了评分'),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
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
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            widget.description,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: _showRatingDialog,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text('打开评分弹窗'),
          ),
        ],
      ),
    );
  }
}