import 'package:flutter/material.dart';

/// 页面栈管理控制器
class PageStackManagerController {
  _PageStackManagerState? _state;
  
  /// 页面栈长度变化通知器
  final ValueNotifier<int> stackLengthNotifier = ValueNotifier<int>(0);

  /// 关联状态
  void attach(_PageStackManagerState state) {
    _state = state;
    // 初始化栈长度
    stackLengthNotifier.value = state.stackLength;
  }

  /// 解除关联
  void detach() {
    _state = null;
  }

  /// 添加页面到栈顶
  void pushPage(Widget page) {
    _state?.pushPage(page);
    // 更新栈长度通知
    stackLengthNotifier.value = _state?.stackLength ?? 0;
  }

  /// 从栈顶移除页面
  void popPage() {
    _state?.popPage();
    // 更新栈长度通知
    stackLengthNotifier.value = _state?.stackLength ?? 0;
  }

  /// 替换栈顶页面
  void replacePage(Widget page) {
    _state?.replacePage(page);
    // 更新栈长度通知
    stackLengthNotifier.value = _state?.stackLength ?? 0;
  }

  /// 清空页面栈并添加新页面
  void resetStack(Widget page) {
    _state?.resetStack(page);
    // 更新栈长度通知
    stackLengthNotifier.value = _state?.stackLength ?? 0;
  }

  /// 获取当前页面栈长度
  int get stackLength => _state?.stackLength ?? 0;
}

/// 页面栈管理组件
class PageStackManager extends StatefulWidget {
  final List<Widget> initialPages;
  final Duration transitionDuration;
  final PageStackManagerController? controller;

  const PageStackManager({
    super.key,
    this.initialPages = const [],
    this.transitionDuration = const Duration(milliseconds: 300),
    this.controller,
  });

  @override
  State<PageStackManager> createState() => _PageStackManagerState();
}

class _PageStackManagerState extends State<PageStackManager> {
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = List.from(widget.initialPages);
    // 关联控制器
    if (widget.controller != null) {
      widget.controller!.attach(this);
    }
  }

  @override
  void dispose() {
    // 解除控制器关联
    if (widget.controller != null) {
      widget.controller!.detach();
    }
    super.dispose();
  }

  /// 添加页面到栈顶
  void pushPage(Widget page) {
    setState(() {
      _pages.add(page);
    });
  }

  /// 从栈顶移除页面
  void popPage() {
    if (_pages.isNotEmpty) {
      setState(() {
        _pages.removeLast();
      });
    }
  }

  /// 替换栈顶页面
  void replacePage(Widget page) {
    if (_pages.isNotEmpty) {
      setState(() {
        _pages[_pages.length - 1] = page;
      });
    } else {
      pushPage(page);
    }
  }

  /// 清空页面栈并添加新页面
  void resetStack(Widget page) {
    setState(() {
      _pages = [page];
    });
  }

  /// 获取当前页面栈长度
  int get stackLength => _pages.length;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: _pages.asMap().entries.map((entry) {
        int index = entry.key;
        Widget page = entry.value;
        bool isCurrentPage = index == _pages.length - 1;

        return AnimatedPositioned(
          duration: widget.transitionDuration,
          curve: Curves.easeInOut,
          left: isCurrentPage ? 0 : -100,
          right: isCurrentPage ? 0 : 100,
          top: 0,
          bottom: 0,
          child: Opacity(
            opacity: isCurrentPage ? 1.0 : 0.5,
            child: page,
          ),
        );
      }).toList(),
    );
  }
}

/// 页面栈项组件
class PageStackItem extends StatelessWidget {
  final String title;
  final Color color;
  final Widget? content;

  const PageStackItem({
    super.key,
    required this.title,
    required this.color,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          if (content != null) content!,
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '页面内容区域',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}