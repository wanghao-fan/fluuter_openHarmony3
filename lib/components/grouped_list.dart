import 'package:flutter/material.dart';
import 'group_header.dart';
import 'group_item.dart';

class GroupedList extends StatelessWidget {
  final List<GroupData> groups;
  
  const GroupedList({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _calculateTotalItems(),
      itemBuilder: (context, index) {
        final itemInfo = _getItemInfo(index);
        
        if (itemInfo.isHeader) {
          return GroupHeader(
            title: groups[itemInfo.groupIndex].title,
            count: groups[itemInfo.groupIndex].items.length,
          );
        } else {
          final group = groups[itemInfo.groupIndex];
          final item = group.items[itemInfo.itemIndex];
          return GroupItem(
            title: item.title,
            subtitle: item.subtitle,
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

class GroupData {
  final String title;
  final List<GroupItemData> items;
  
  GroupData({required this.title, required this.items});
}

class GroupItemData {
  final String title;
  final String subtitle;
  
  GroupItemData({required this.title, required this.subtitle});
}

class ItemInfo {
  final bool isHeader;
  final int groupIndex;
  final int itemIndex;
  
  ItemInfo({required this.isHeader, required this.groupIndex, required this.itemIndex});
}
