import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeGenerator extends StatefulWidget {
  final String? initialData;
  final double? width;
  final double? height;
  final Color? qrColor;
  final Color? backgroundColor;
  final String title;

  const QrCodeGenerator({
    Key? key,
    this.initialData,
    this.width,
    this.height,
    this.qrColor,
    this.backgroundColor,
    required this.title,
  }) : super(key: key);

  @override
  State<QrCodeGenerator> createState() => _QrCodeGeneratorState();
}

class _QrCodeGeneratorState extends State<QrCodeGenerator> {
  late TextEditingController _controller;
  late String _qrData;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _qrData = widget.initialData ?? 'https://www.example.com';
    _controller = TextEditingController(text: _qrData);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateQrCode() {
    setState(() {
      _qrData = _controller.text;
      _isEditing = false;
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _qrData));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('已复制到剪贴板')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16.0),
          if (_isEditing)
            Column(
              children: [
                TextField(
                  controller: _controller,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: '输入文本或链接',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: _updateQrCode,
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
              ],
            )
          else
            GestureDetector(
              onTap: () {
                setState(() {
                  _isEditing = true;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[50],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _qrData,
                        style: const TextStyle(color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const Icon(Icons.edit, color: Colors.blue),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 24.0),
          Center(
            child: GestureDetector(
              onTap: _copyToClipboard,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: QrImageView(
                  data: _qrData,
                  version: QrVersions.auto,
                  size: widget.width ?? 200.0,
                  gapless: false,
                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: Colors.black87,
                  ),
                  dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: widget.qrColor ?? Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: Text(
              '点击二维码复制内容',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}