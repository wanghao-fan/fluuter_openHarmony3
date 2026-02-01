import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  final String title;
  final Widget content;
  final String confirmText;
  final String cancelText;
  final Function() onConfirm;
  final Function() onCancel;
  final bool showCancel;
  final double? height;
  
  const BottomSheetWidget({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = '确定',
    this.cancelText = '取消',
    required this.onConfirm,
    required this.onCancel,
    this.showCancel = true,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 300,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: [
          // 顶部指示器
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            width: 40.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          
          // 标题
          if (title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          
          // 内容
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: content,
            ),
          ),
          
          // 按钮
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (showCancel)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel,
                      child: Text(cancelText),
                    ),
                  ),
                if (showCancel)
                  const SizedBox(width: 12.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    child: Text(confirmText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetManager {
  static Future<bool> showBottomSheet(
    BuildContext context,
    {
      required String title,
      required Widget content,
      String confirmText = '确定',
      String cancelText = '取消',
      bool showCancel = true,
      double? height,
    }
  ) async {
    return await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BottomSheetWidget(
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
          height: height,
        );
      },
    ) ?? false;
  }

  static Future<String?> showSelectionBottomSheet(
    BuildContext context,
    {
      required String title,
      required List<String> options,
      String cancelText = '取消',
    }
  ) async {
    String? selectedOption;
    
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 350,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
          ),
          child: Column(
            children: [
              // 顶部指示器
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12.0),
                width: 40.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              
              // 标题
              if (title.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              
              // 选项列表
              Expanded(
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(options[index]),
                      onTap: () {
                        selectedOption = options[index];
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
              
              // 取消按钮
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(cancelText),
                ),
              ),
            ],
          ),
        );
      },
    );
    
    return selectedOption;
  }
}
