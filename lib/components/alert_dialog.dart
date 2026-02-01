import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final Function() onConfirm;
  final Function() onCancel;
  final bool showCancel;
  
  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = '确定',
    this.cancelText = '取消',
    required this.onConfirm,
    required this.onCancel,
    this.showCancel = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        if (showCancel)
          TextButton(
            onPressed: onCancel,
            child: Text(cancelText),
          ),
        TextButton(
          onPressed: onConfirm,
          child: Text(confirmText),
        ),
      ],
    );
  }
}

class AlertDialogManager {
  static Future<bool> showAlertDialog(
    BuildContext context,
    {
      required String title,
      required String content,
      String confirmText = '确定',
      String cancelText = '取消',
      bool showCancel = true,
    }
  ) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogWidget(
          title: title,
          content: content,
          confirmText: confirmText,
          cancelText: cancelText,
          onConfirm: () {
            Navigator.of(context).pop(true);
          },
          onCancel: () {
            Navigator.of(context).pop(false);
          },
          showCancel: showCancel,
        );
      },
    ) ?? false;
  }
}
