import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final Color? iconColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final bool isOutlined;
  final bool isLoading;

  const ActionButton({
    Key? key,
    required this.text,
    this.icon,
    this.onPressed,
    this.buttonColor,
    this.textColor,
    this.iconColor,
    this.width,
    this.height,
    this.borderRadius,
    this.isOutlined = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveButtonColor = isOutlined
        ? Colors.transparent
        : buttonColor ?? Theme.of(context).primaryColor;
    final effectiveTextColor = isOutlined
        ? buttonColor ?? Theme.of(context).primaryColor
        : textColor ?? Colors.white;
    final effectiveIconColor = iconColor ?? effectiveTextColor;

    return Container(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveButtonColor,
          foregroundColor: effectiveTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            side: isOutlined
                ? BorderSide(
                    color: buttonColor ?? Theme.of(context).primaryColor,
                    width: 2,
                  )
                : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        icon,
                        size: 18,
                        color: effectiveIconColor,
                      ),
                    ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? size;
  final String? tooltip;

  const CustomFloatingActionButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: size ?? 56,
          height: size ?? 56,
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(size ?? 56),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: iconColor ?? Colors.white,
            size: (size ?? 56) * 0.5,
          ),
        ),
      ),
    );
  }
}
