import 'package:flutter/material.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void show(
    BuildContext context,
    {
      String message = '加载中...',
      Color backgroundColor = Colors.black54,
      Color indicatorColor = Colors.white,
      Color textColor = Colors.white,
      double fontSize = 14.0,
    }
  ) {
    // 如果已经有加载弹窗在显示，先移除
    if (_isVisible) {
      hide();
    }

    // 创建覆盖层条目
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: Container(
            color: backgroundColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // 添加覆盖层条目到当前上下文的覆盖层
    Overlay.of(context).insert(_overlayEntry!);
    _isVisible = true;
  }

  static void hide() {
    if (_isVisible && _overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isVisible = false;
    }
  }
}