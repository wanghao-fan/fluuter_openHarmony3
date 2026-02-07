import 'package:flutter/material.dart';

class AnchorScroll extends StatefulWidget {
  final List<AnchorItem> items;
  final ScrollController? scrollController;
  final double? itemHeight;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? textStyle;

  const AnchorScroll({
    super.key,
    required this.items,
    this.scrollController,
    this.itemHeight = 50.0,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.textStyle,
  });

  @override
  State<AnchorScroll> createState() => _AnchorScrollState();
}

class AnchorItem {
  final String title;
  final Widget child;

  const AnchorItem({
    required this.title,
    required this.child,
  });
}

class _AnchorScrollState extends State<AnchorScroll> {
  late ScrollController _scrollController;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final itemHeight = widget.itemHeight!;
    final newIndex = (offset / itemHeight).round();
    
    if (newIndex != _activeIndex && newIndex >= 0 && newIndex < widget.items.length) {
      setState(() {
        _activeIndex = newIndex;
      });
    }
  }

  void _scrollToIndex(int index) {
    setState(() {
      _activeIndex = index;
    });
    
    _scrollController.animateTo(
      index * widget.itemHeight!,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 左侧导航栏
        Container(
          width: 120,
          decoration: BoxDecoration(
            border: Border(right: BorderSide(color: Colors.grey[200]!)),
          ),
          child: ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _scrollToIndex(index),
                child: Container(
                  height: widget.itemHeight,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: _activeIndex == index ? Colors.blue[50] : null,
                    border: Border(
                      left: BorderSide(
                        color: _activeIndex == index ? widget.activeColor! : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Text(
                    widget.items[index].title,
                    style: TextStyle(
                      color: _activeIndex == index ? widget.activeColor : widget.inactiveColor,
                      fontWeight: _activeIndex == index ? FontWeight.bold : FontWeight.normal,
                    ).merge(widget.textStyle),
                  ),
                ),
              );
            },
          ),
        ),
        
        // 右侧内容区域
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return Container(
                height: widget.itemHeight,
                padding: EdgeInsets.all(20),
                child: widget.items[index].child,
              );
            },
          ),
        ),
      ],
    );
  }
}
