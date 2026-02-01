import 'package:flutter/material.dart';
import 'tag_item.dart';

class TagInput extends StatefulWidget {
  final List<String>? initialTags;
  final int? maxTags;
  final String hintText;
  final Function(List<String>)? onTagsChanged;
  
  const TagInput({
    super.key,
    this.initialTags,
    this.maxTags,
    this.hintText = '输入标签并按回车添加',
    this.onTagsChanged,
  });

  @override
  State<TagInput> createState() => _TagInputState();
}

class _TagInputState extends State<TagInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late List<String> _tags;

  @override
  void initState() {
    super.initState();
    _tags = widget.initialTags ?? [];
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addTag(String tag) {
    if (tag.isEmpty) return;
    if (widget.maxTags != null && _tags.length >= widget.maxTags!) return;
    if (_tags.contains(tag)) return;

    setState(() {
      _tags.add(tag);
      _controller.clear();
      _focusNode.requestFocus();
    });

    if (widget.onTagsChanged != null) {
      widget.onTagsChanged!(_tags);
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });

    if (widget.onTagsChanged != null) {
      widget.onTagsChanged!(_tags);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 已添加的标签
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _tags.map((tag) {
              return TagItem(
                tag: tag,
                onRemove: () => _removeTag(tag),
              );
            }).toList(),
          ),
          const SizedBox(height: 8.0),
          
          // 输入框
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: const OutlineInputBorder(),
              suffixIcon: _tags.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _tags.clear();
                          _controller.clear();
                          _focusNode.requestFocus();
                        });
                        if (widget.onTagsChanged != null) {
                          widget.onTagsChanged!(_tags);
                        }
                      },
                    )
                  : null,
            ),
            onSubmitted: _addTag,
          ),
          if (widget.maxTags != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '最多添加 ${widget.maxTags} 个标签',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
