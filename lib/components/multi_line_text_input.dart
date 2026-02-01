import 'package:flutter/material.dart';

class MultiLineTextInput extends StatefulWidget {
  final String labelText;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final int maxLines;

  const MultiLineTextInput({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.onChanged,
    this.controller,
    this.maxLines = 3,
  }) : super(key: key);

  @override
  State<MultiLineTextInput> createState() => _MultiLineTextInputState();
}

class _MultiLineTextInputState extends State<MultiLineTextInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _controller,
        onChanged: widget.onChanged,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
      ),
    );
  }
}
