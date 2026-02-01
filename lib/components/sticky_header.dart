import 'package:flutter/material.dart';

class StickyHeader extends StatelessWidget {
  final String title;
  final int count;
  
  const StickyHeader({super.key, required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.deepPurple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            '$count项',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final int count;
  
  StickyHeaderDelegate({required this.title, required this.count});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return StickyHeader(title: title, count: count);
  }

  @override
  double get maxExtent => 56.0;

  @override
  double get minExtent => 56.0;

  @override
  bool shouldRebuild(covariant StickyHeaderDelegate oldDelegate) {
    return oldDelegate.title != title || oldDelegate.count != count;
  }
}
