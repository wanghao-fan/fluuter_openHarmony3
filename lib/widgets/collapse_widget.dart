import 'package:flutter/material.dart';

class CollapseWidget extends StatefulWidget {
  final String title;
  final Widget content;
  final bool isExpanded;
  final ValueChanged<bool>? onExpansionChanged;
  final Color? headerColor;
  final Color? contentColor;
  final double? headerHeight;

  const CollapseWidget({
    Key? key,
    required this.title,
    required this.content,
    this.isExpanded = false,
    this.onExpansionChanged,
    this.headerColor,
    this.contentColor,
    this.headerHeight,
  }) : super(key: key);

  @override
  State<CollapseWidget> createState() => _CollapseWidgetState();
}

class _CollapseWidgetState extends State<CollapseWidget> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  void didUpdateWidget(covariant CollapseWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      setState(() {
        _isExpanded = widget.isExpanded;
      });
    }
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.contentColor ?? Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: _toggleExpanded,
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: widget.headerHeight ?? 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: const Radius.circular(8),
                  bottom: _isExpanded ? Radius.zero : const Radius.circular(8),
                ),
                color: widget.headerColor ?? Colors.deepPurple[50],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: _isExpanded ? 0.5 : 0,
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: Container(height: 0),
            secondChild: Container(
              padding: const EdgeInsets.all(16),
              child: widget.content,
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }
}

class CollapseGroup extends StatelessWidget {
  final List<CollapseWidget> children;
  final bool? accordion;

  const CollapseGroup({
    Key? key,
    required this.children,
    this.accordion = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children,
    );
  }
}