import 'package:flutter/material.dart';

class CustomBadge extends StatefulWidget {
  final Widget child;
  final int count;
  final bool showBadge;
  final Color badgeColor;
  final Color textColor;
  final double badgeSize;
  final double textSize;
  final Function()? onTap;

  const CustomBadge({
    Key? key,
    required this.child,
    this.count = 0,
    this.showBadge = true,
    this.badgeColor = Colors.red,
    this.textColor = Colors.white,
    this.badgeSize = 20.0,
    this.textSize = 12.0,
    this.onTap,
  }) : super(key: key);

  @override
  _CustomBadgeState createState() => _CustomBadgeState();
}

class _CustomBadgeState extends State<CustomBadge> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: widget.child,
        ),
        if (widget.showBadge && widget.count > 0)
          Positioned(
            top: -5,
            right: -5,
            child: Container(
              width: widget.badgeSize,
              height: widget.badgeSize,
              decoration: BoxDecoration(
                color: widget.badgeColor,
                borderRadius: BorderRadius.circular(widget.badgeSize / 2),
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  widget.count > 99 ? '99+' : '${widget.count}',
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: widget.textSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
