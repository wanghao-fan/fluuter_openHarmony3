import 'package:flutter/material.dart';

class ToastOverlay {
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void show(
    BuildContext context,
    String message,
    {
      Duration duration = const Duration(seconds: 2),
      ToastPosition position = ToastPosition.bottom,
      Color backgroundColor = Colors.black54,
      Color textColor = Colors.white,
      double fontSize = 14.0,
      double padding = 12.0,
      double radius = 8.0,
    }
  ) {
    // 如果已经有吐司在显示，先移除
    if (_isVisible) {
      hide();
    }

    // 创建覆盖层条目
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: position == ToastPosition.top
              ? MediaQuery.of(context).padding.top + 50
              : null,
          bottom: position == ToastPosition.bottom
              ? MediaQuery.of(context).padding.bottom + 50
              : null,
          left: 0,
          right: 0,
          child: IgnorePointer(
            child: Container(
              alignment: Alignment.center,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(padding),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    // 添加覆盖层条目到当前上下文的覆盖层
    Overlay.of(context).insert(_overlayEntry!);
    _isVisible = true;

    // 延时后移除覆盖层条目
    Future.delayed(duration, hide);
  }

  static void hide() {
    if (_isVisible && _overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isVisible = false;
    }
  }
}

enum ToastPosition {
  top,
  center,
  bottom,
}