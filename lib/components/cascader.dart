import 'package:flutter/material.dart';

class CascaderOption {
  final String value;
  final String label;
  final List<CascaderOption>? children;

  const CascaderOption({
    required this.value,
    required this.label,
    this.children,
  });
}

class Cascader extends StatefulWidget {
  final List<CascaderOption> options;
  final Function(List<String>) onChanged;
  final String placeholder;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color dropdownBackgroundColor;
  final Color textColor;
  final Color selectedTextColor;
  final Color selectedBackgroundColor;
  final double borderRadius;

  const Cascader({
    super.key,
    required this.options,
    required this.onChanged,
    this.placeholder = '请选择',
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.deepPurple,
    this.dropdownBackgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.selectedTextColor = Colors.white,
    this.selectedBackgroundColor = Colors.deepPurple,
    this.borderRadius = 4.0,
  });

  @override
  State<Cascader> createState() => _CascaderState();
}

class _CascaderState extends State<Cascader> {
  bool _isExpanded = false;
  List<String> _selectedValues = [];
  List<List<CascaderOption>> _optionsChain = [];

  @override
  void initState() {
    super.initState();
    _optionsChain = [widget.options];
  }

  void _toggleDropdown() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _selectOption(CascaderOption option, int level) {
    setState(() {
      // 更新选中值
      if (_selectedValues.length > level) {
        _selectedValues = _selectedValues.sublist(0, level);
      }
      _selectedValues.add(option.value);

      // 更新选项链
      if (_optionsChain.length > level + 1) {
        _optionsChain = _optionsChain.sublist(0, level + 1);
      }
      if (option.children != null && option.children!.isNotEmpty) {
        _optionsChain.add(option.children!);
      }

      // 如果是最后一级，关闭下拉框并触发回调
      if (option.children == null || option.children!.isEmpty) {
        _isExpanded = false;
        widget.onChanged(_selectedValues);
      }
    });
  }

  List<String> _getSelectedLabels() {
    final labels = <String>[];
    var currentOptions = widget.options;

    for (final value in _selectedValues) {
      final option = currentOptions.firstWhere(
        (option) => option.value == value,
        orElse: () => const CascaderOption(value: '', label: ''),
      );
      labels.add(option.label);
      if (option.children != null) {
        currentOptions = option.children!;
      }
    }

    return labels;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: _isExpanded ? widget.focusedBorderColor : widget.borderColor,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedValues.isNotEmpty
                      ? _getSelectedLabels().join(' / ')
                      : widget.placeholder,
                  style: TextStyle(
                    color: _selectedValues.isNotEmpty
                        ? widget.textColor
                        : widget.borderColor,
                  ),
                ),
                Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: widget.borderColor,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Container(
            margin: const EdgeInsets.only(top: 4.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: widget.dropdownBackgroundColor,
              border: Border.all(color: widget.borderColor),
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Row(
              children: _optionsChain.asMap().entries.map((entry) {
                final level = entry.key;
                final options = entry.value;
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: options.map((option) {
                      final isSelected = _selectedValues.length > level &&
                          _selectedValues[level] == option.value;
                      return GestureDetector(
                        onTap: () => _selectOption(option, level),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          margin: const EdgeInsets.symmetric(vertical: 2.0),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? widget.selectedBackgroundColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            option.label,
                            style: TextStyle(
                              color: isSelected
                                  ? widget.selectedTextColor
                                  : widget.textColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
