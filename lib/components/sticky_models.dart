class StickyHeaderGroup {
  final String title;
  final List<StickyItemData> items;
  
  StickyHeaderGroup({required this.title, required this.items});
}

class StickyItemData {
  final String title;
  final String subtitle;
  
  StickyItemData({required this.title, required this.subtitle});
}

class ItemInfo {
  final bool isHeader;
  final int groupIndex;
  final int itemIndex;
  
  ItemInfo({required this.isHeader, required this.groupIndex, required this.itemIndex});
}
