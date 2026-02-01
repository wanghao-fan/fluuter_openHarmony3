import 'package:flutter/material.dart';
import 'sticky_models.dart';

class StickyHeaderList extends StatelessWidget {
  final List<StickyHeaderGroup> groups;
  
  const StickyHeaderList({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _calculateTotalItems(),
      itemBuilder: (context, index) {
        final itemInfo = _getItemInfo(index);
        
        if (itemInfo.isHeader) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.deepPurple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  groups[itemInfo.groupIndex].title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${groups[itemInfo.groupIndex].items.length}项',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        } else {
          final group = groups[itemInfo.groupIndex];
          final item = group.items[itemInfo.itemIndex];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  int _calculateTotalItems() {
    int total = 0;
    for (var group in groups) {
      total += 1; // 分组头部
      total += group.items.length; // 分组项
    }
    return total;
  }

  ItemInfo _getItemInfo(int index) {
    int currentIndex = 0;
    
    for (int i = 0; i < groups.length; i++) {
      // 检查是否是分组头部
      if (currentIndex == index) {
        return ItemInfo(isHeader: true, groupIndex: i, itemIndex: -1);
      }
      currentIndex++;
      
      // 检查是否是分组项
      for (int j = 0; j < groups[i].items.length; j++) {
        if (currentIndex == index) {
          return ItemInfo(isHeader: false, groupIndex: i, itemIndex: j);
        }
        currentIndex++;
      }
    }
    
    throw IndexError(index, groups, "Index out of bounds");
  }
}
