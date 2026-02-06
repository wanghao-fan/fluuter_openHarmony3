import 'package:flutter/material.dart';
import 'input_saver_model.dart';

class InputSaverWidget extends StatefulWidget {
  final InputFieldConfig config;
  final ValueChanged<String>? onChanged;
  final Function()? onSubmit;

  const InputSaverWidget({
    Key? key,
    required this.config,
    this.onChanged,
    this.onSubmit,
  }) : super(key: key);

  @override
  _InputSaverWidgetState createState() => _InputSaverWidgetState();
}

class _InputSaverWidgetState extends State<InputSaverWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _hasCachedContent = false;
  String? _cachedContent;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCachedContent();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 加载缓存的内容
  Future<void> _loadCachedContent() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final cachedContent = await InputSaver.loadInput(widget.config.key);
      setState(() {
        if (cachedContent != null && cachedContent.isNotEmpty) {
          _cachedContent = cachedContent;
          _hasCachedContent = true;
        }
        _isLoading = false;
      });
    } catch (e) {
      // 即使加载失败，也只设置 _isLoading 为 false，不清除缓存状态
      setState(() {
        _isLoading = false;
      });
    }
  }

  // 文本变化时自动保存
  void _onTextChanged() {
    final text = _controller.text;
    InputSaver.saveInput(widget.config.key, text);
    
    // 当用户输入时，更新缓存状态
    if (text.isNotEmpty) {
      setState(() {
        _cachedContent = text;
        _hasCachedContent = true;
      });
    }

    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

  // 恢复上次输入
  void _restoreLastInput() {
    if (_cachedContent != null) {
      setState(() {
        _controller.text = _cachedContent!;
        _hasCachedContent = false;
      });
    }
  }

  // 清除输入和缓存
  void _clearInput() {
    setState(() {
      _controller.clear();
      _hasCachedContent = false;
      _cachedContent = null;
    });
    InputSaver.clearInput(widget.config.key);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 输入框标题
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            widget.config.hintText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // 输入框容器
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // 输入框
              TextField(
                controller: _controller,
                maxLines: widget.config.maxLines,
                autofocus: widget.config.autofocus,
                decoration: InputDecoration(
                  hintText: widget.config.hintText,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
                onSubmitted: (_) {
                  if (widget.onSubmit != null) {
                    widget.onSubmit!();
                  }
                },
              ),

              // 操作按钮
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // 恢复按钮
                    if (_hasCachedContent)
                      TextButton.icon(
                        onPressed: _restoreLastInput,
                        icon: const Icon(
                          Icons.restore,
                          size: 16,
                          color: Colors.blue,
                        ),
                        label: const Text(
                          '恢复上次输入',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),

                    // 清除按钮
                    if (_controller.text.isNotEmpty)
                      TextButton.icon(
                        onPressed: _clearInput,
                        icon: const Icon(
                          Icons.clear,
                          size: 16,
                          color: Colors.grey,
                        ),
                        label: const Text(
                          '清除',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 状态提示
        if (_isLoading)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              '正在加载历史记录...',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
      ],
    );
  }
}
