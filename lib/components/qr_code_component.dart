import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeComponent extends StatefulWidget {
  const QrCodeComponent({super.key});

  @override
  State<QrCodeComponent> createState() => _QrCodeComponentState();
}

class _QrCodeComponentState extends State<QrCodeComponent> {
  final TextEditingController _textController = TextEditingController(text: 'https://openharmonycrossplatform.csdn.net');
  String _qrData = 'https://openharmonycrossplatform.csdn.net';
  int _qrSize = 200;
  bool _isLoading = false;

  void _generateQrCode() {
    setState(() {
      _isLoading = true;
    });

    // 模拟生成二维码的过程
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _qrData = _textController.text;
        _isLoading = false;
      });
    });
  }

  void _changeQrSize(int size) {
    setState(() {
      _qrSize = size;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '二维码生成器',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),

              // 输入文本区域
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: '输入内容',
                  border: OutlineInputBorder(),
                  hintText: '请输入要生成二维码的内容',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 20),

              // 生成按钮
              ElevatedButton(
                onPressed: _generateQrCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: const Text(
                  '生成二维码',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 二维码显示区域
              _isLoading
                  ? const CircularProgressIndicator(color: Colors.deepPurple)
                  : GestureDetector(
                      onTap: () {
                        // 点击二维码的交互效果
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('二维码已生成'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepPurple, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: QrImageView(
                          data: _qrData,
                          version: QrVersions.auto,
                          size: _qrSize.toDouble(),
                          gapless: false,
                          errorStateBuilder: (cxt, err) {
                            return Container(
                              child: const Center(
                                child: Text(
                                  '生成二维码失败',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
              const SizedBox(height: 20),

              // 二维码大小调整
              Column(
                children: [
                  const Text(
                    '调整二维码大小：',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSizeOption(150),
                      _buildSizeOption(200),
                      _buildSizeOption(250),
                      _buildSizeOption(300),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 状态提示
              Text(
                _isLoading ? '生成中...' : '就绪',
                style: TextStyle(
                  fontSize: 16,
                  color: _isLoading ? Colors.blue : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 构建大小选项按钮
  Widget _buildSizeOption(int size) {
    return GestureDetector(
      onTap: () => _changeQrSize(size),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: _qrSize == size ? Colors.deepPurple : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '$size×$size',
          style: TextStyle(
            color: _qrSize == size ? Colors.white : Colors.black87,
            fontWeight: _qrSize == size ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
