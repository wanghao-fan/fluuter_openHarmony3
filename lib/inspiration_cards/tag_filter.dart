import 'package:flutter/material.dart';
import 'inspiration_model.dart';

class TagFilter extends StatefulWidget {
  final Function(String?) onFilterChanged;
  final String? selectedTag;

  const TagFilter({
    Key? key,
    required this.onFilterChanged,
    this.selectedTag,
  }) : super(key: key);

  @override
  _TagFilterState createState() => _TagFilterState();
}

class _TagFilterState extends State<TagFilter> {
  late String? _selectedTag;

  @override
  void initState() {
    super.initState();
    _selectedTag = widget.selectedTag;
  }

  @override
  void didUpdateWidget(covariant TagFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedTag != oldWidget.selectedTag) {
      setState(() {
        _selectedTag = widget.selectedTag;
      });
    }
  }

  void _selectTag(String? tag) {
    setState(() {
      _selectedTag = tag;
    });
    widget.onFilterChanged(tag);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '标签筛选',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // All tags option
                Container(
                  constraints: BoxConstraints(minWidth: 60, minHeight: 40),
                  child: ChoiceChip(
                    label: Text('全部'),
                    selected: _selectedTag == null,
                    onSelected: (selected) => _selectTag(null),
                    selectedColor: Colors.blue,
                    labelStyle: TextStyle(
                      color: _selectedTag == null ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                ),
                SizedBox(width: 8),
                // Predefined tags
                ...predefinedTags.map((tag) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Container(
                      constraints: BoxConstraints(minWidth: 60, minHeight: 40),
                      child: ChoiceChip(
                        label: Text(tag),
                        selected: _selectedTag == tag,
                        onSelected: (selected) => _selectTag(tag),
                        selectedColor: Colors.blue,
                        labelStyle: TextStyle(
                          color: _selectedTag == tag ? Colors.white : Colors.black,
                          fontSize: 14,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
