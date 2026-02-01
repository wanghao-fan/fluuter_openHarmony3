import 'package:flutter/material.dart';

class SingleLineTextInput extends StatefulWidget {
  final String labelText;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final bool obscureText;

  const SingleLineTextInput({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.onChanged,
    this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<SingleLineTextInput> createState() => _SingleLineTextInputState();
}

class _SingleLineTextInputState extends State<SingleLineTextInput> {
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
        obscureText: widget.obscureText,
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
