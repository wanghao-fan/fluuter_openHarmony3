import 'package:flutter/material.dart';

class Toolbar extends StatelessWidget {
  final String title;
  final List<ToolbarAction> actions;
  final Color? backgroundColor;
  final Color? titleColor;

  const Toolbar({
    Key? key,
    required this.title,
    required this.actions,
    this.backgroundColor,
    this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: backgroundColor ?? Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: titleColor ?? Colors.white,
            ),
          ),
          Row(
            children: actions
                .map((action) => Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: action,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class ToolbarAction extends StatelessWidget {
  final IconData icon;
  final String? tooltip;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? size;

  const ToolbarAction({
    Key? key,
    required this.icon,
    this.tooltip,
    this.onPressed,
    this.iconColor,
    this.backgroundColor,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: size ?? 40,
          height: size ?? 40,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: iconColor ?? Colors.white,
            size: (size ?? 40) * 0.6,
          ),
        ),
      ),
    );
  }
}
