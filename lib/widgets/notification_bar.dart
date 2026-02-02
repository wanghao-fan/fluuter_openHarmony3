import 'package:flutter/material.dart';

/// 通知类型枚举
enum NotificationType {
  info,    // 信息通知
  success, // 成功通知
  warning, // 警告通知
  error,   // 错误通知
}

/// 通知栏组件
class NotificationBar extends StatefulWidget {
  final String message;
  final NotificationType type;
  final Duration duration;
  final bool autoDismiss;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onDismiss;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double elevation;
  final BorderRadius borderRadius;

  const NotificationBar({
    Key? key,
    required this.message,
    this.type = NotificationType.info,
    this.duration = const Duration(seconds: 3),
    this.autoDismiss = true,
    this.leading,
    this.trailing,
    this.onDismiss,
    this.backgroundColor,
    this.textStyle,
    this.elevation = 4.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
  }) : super(key: key);

  @override
  State<NotificationBar> createState() => _NotificationBarState();
}

class _NotificationBarState extends State<NotificationBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    
    // 初始化动画控制器
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // 初始化滑动动画
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // 启动进入动画
    _controller.forward();

    // 如果设置为自动消失，则启动定时器
    if (widget.autoDismiss) {
      Future.delayed(widget.duration, () {
        if (mounted) {
          _dismiss();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 关闭通知
  void _dismiss() {
    _controller.reverse().then((_) {
      setState(() {
        _isVisible = false;
      });
      if (widget.onDismiss != null) {
        widget.onDismiss!();
      }
    });
  }

  // 根据通知类型获取颜色
  Color _getTypeColor() {
    switch (widget.type) {
      case NotificationType.success:
        return Colors.green;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.error:
        return Colors.red;
      case NotificationType.info:
      default:
        return Colors.blue;
    }
  }

  // 根据通知类型获取图标
  Widget _getTypeIcon() {
    switch (widget.type) {
      case NotificationType.success:
        return const Icon(Icons.check_circle, color: Colors.white);
      case NotificationType.warning:
        return const Icon(Icons.warning, color: Colors.white);
      case NotificationType.error:
        return const Icon(Icons.error, color: Colors.white);
      case NotificationType.info:
      default:
        return const Icon(Icons.info, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return const SizedBox.shrink();
    }

    final bgColor = widget.backgroundColor ?? _getTypeColor();
    final leadingWidget = widget.leading ?? _getTypeIcon();
    final trailingWidget = widget.trailing ??
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: _dismiss,
        );

    return SlideTransition(
      position: _slideAnimation,
      child: Material(
        elevation: widget.elevation,
        borderRadius: widget.borderRadius,
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: widget.borderRadius,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: leadingWidget,
              ),
              Expanded(
                child: Text(
                  widget.message,
                  style: widget.textStyle ??
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                ),
              ),
              trailingWidget,
            ],
          ),
        ),
      ),
    );
  }
}

/// 通知栏管理器
class NotificationManager {
  static OverlayEntry? _currentEntry;

  /// 显示通知
  static void show(
    BuildContext context,
    String message,
    NotificationType type,
  ) {
    // 先移除当前显示的通知
    dismiss();

    // 创建新的通知条目
    _currentEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 40, // 距离顶部的距离
        left: 16,
        right: 16,
        child: NotificationBar(
          message: message,
          type: type,
          onDismiss: () {
            _currentEntry = null;
          },
        ),
      ),
    );

    // 插入到Overlay中
    Overlay.of(context)?.insert(_currentEntry!);
  }

  /// 显示信息通知
  static void info(BuildContext context, String message) {
    show(context, message, NotificationType.info);
  }

  /// 显示成功通知
  static void success(BuildContext context, String message) {
    show(context, message, NotificationType.success);
  }

  /// 显示警告通知
  static void warning(BuildContext context, String message) {
    show(context, message, NotificationType.warning);
  }

  /// 显示错误通知
  static void error(BuildContext context, String message) {
    show(context, message, NotificationType.error);
  }

  /// 关闭当前通知
  static void dismiss() {
    if (_currentEntry != null) {
      _currentEntry?.remove();
      _currentEntry = null;
    }
  }
}