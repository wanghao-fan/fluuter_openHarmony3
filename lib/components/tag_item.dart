import 'package:flutter/material.dart';

class TagItem extends StatelessWidget {
  final String tag;
  final VoidCallback onRemove;
  
  const TagItem({
    super.key,
    required this.tag,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple[100],
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.deepPurple[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: TextStyle(
              color: Colors.deepPurple[800],
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 6.0),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 16,
              color: Colors.deepPurple[600],
            ),
          ),
        ],
      ),
    );
  }
}
