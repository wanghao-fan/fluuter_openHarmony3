import 'package:flutter/material.dart';

/// 上下文菜单项数据类
class ContextMenuItem {
  final String title;
  final IconData? icon;
  final VoidCallback onTap;
  final Color? textColor;

  const ContextMenuItem({
    required this.title,
    this.icon,
    required this.onTap,
    this.textColor,
  });
}

/// 上下文菜单组件
class ContextMenu extends StatelessWidget {
  final Widget child;
  final List<ContextMenuItem> items;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;

  const ContextMenu({
    Key? key,
    required this.child,
    required this.items,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTap: () {
        _showContextMenu(context);
      },
      onLongPress: () {
        _showContextMenu(context);
      },
      child: child,
    );
  }

  void _showContextMenu(BuildContext context) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            overlayEntry?.remove();
          },
          child: Container(
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned(
                  left: position.dx,
                  top: position.dy + size.height,
                  child: GestureDetector(
                    onTap: () {
                      // 阻止点击菜单时关闭菜单
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: backgroundColor ?? Theme.of(context).cardColor,
                          borderRadius: borderRadius ?? BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: elevation ?? 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: items.map((item) {
                            return InkWell(
                              onTap: () {
                                item.onTap();
                                overlayEntry?.remove();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                child: Row(
                                  children: [
                                    if (item.icon != null)
                                      Padding(
                                        padding: const EdgeInsets.only(right: 12),
                                        child: Icon(
                                          item.icon,
                                          size: 20,
                                          color: item.textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
                                        ),
                                      ),
                                    Text(
                                      item.title,
                                      style: TextStyle(
                                        color: item.textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry);
  }
}