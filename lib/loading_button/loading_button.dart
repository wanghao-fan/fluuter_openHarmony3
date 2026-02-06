import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final String text;
  final Function() onPressed;
  final double width;
  final double height;
  final Color color;
  final Color textColor;
  final double fontSize;
  final BorderRadius borderRadius;

  const LoadingButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 50.0,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
  }) : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _isLoading = false;

  Future<void> _handlePress() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onPressed();
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handlePress,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: widget.borderRadius,
          ),
        ),
        child: _isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(widget.textColor),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    '加载中...',
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: widget.fontSize,
                    ),
                  ),
                ],
              )
            : Text(
                widget.text,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                ),
              ),
      ),
    );
  }
}
