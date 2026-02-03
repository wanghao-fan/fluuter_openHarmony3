import 'package:flutter/material.dart';

/// 返回按钮拦截组件
class BackButtonInterceptor extends StatefulWidget {
  final Widget child;
  final bool canPop;
  final Function(bool)? onBackPressed;
  final String? alertTitle;
  final String? alertContent;
  final String? confirmText;
  final String? cancelText;

  const BackButtonInterceptor({
    super.key,
    required this.child,
    this.canPop = true,
    this.onBackPressed,
    this.alertTitle = '确认返回',
    this.alertContent = '确定要返回吗？',
    this.confirmText = '确定',
    this.cancelText = '取消',
  });

  @override
  State<BackButtonInterceptor> createState() => _BackButtonInterceptorState();
}

class _BackButtonInterceptorState extends State<BackButtonInterceptor> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!widget.canPop) {
          // 显示确认对话框
          final bool? result = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(widget.alertTitle!),
                content: Text(widget.alertContent!),
                actions: <Widget>[
                  TextButton(
                    child: Text(widget.cancelText!),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: Text(widget.confirmText!),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            },
          );

          // 调用回调函数
          if (widget.onBackPressed != null) {
            widget.onBackPressed!(result ?? false);
          }

          return result ?? false;
        }
        // 允许返回
        if (widget.onBackPressed != null) {
          widget.onBackPressed!(true);
        }
        return true;
      },
      child: widget.child,
    );
  }
}