import 'package:flutter/material.dart';

class TimelineItem {
  final String title;
  final String description;
  final DateTime date;
  final Color color;

  TimelineItem({
    required this.title,
    required this.description,
    required this.date,
    this.color = Colors.blue,
  });
}

class Timeline extends StatefulWidget {
  final List<TimelineItem> items;
  final Function(TimelineItem)? onTap;

  const Timeline({
    Key? key,
    required this.items,
    this.onTap,
  }) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final isSelected = _selectedIndex == index;

        return InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = isSelected ? null : index;
            });
            if (widget.onTap != null) {
              widget.onTap!(item);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline line and dot
                Container(
                  width: 40,
                  child: Stack(
                    children: [
                      // Vertical line
                      if (index < widget.items.length - 1)
                        Positioned(
                          top: 20,
                          bottom: 0,
                          left: 19,
                          child: Container(
                            width: 2,
                            color: Colors.grey[300],
                          ),
                        ),
                      // Dot
                      Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Container(
                            width: isSelected ? 24 : 20,
                            height: isSelected ? 24 : 20,
                            decoration: BoxDecoration(
                              color: isSelected ? item.color : Colors.white,
                              border: Border.all(
                                color: item.color,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: isSelected
                                ? Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? item.color.withOpacity(0.1) : Colors.white,
                      border: Border(
                        left: BorderSide(
                          color: item.color,
                          width: 3,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200]!,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: item.color,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          item.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${item.date.year}-${item.date.month.toString().padLeft(2, '0')}-${item.date.day.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TimelineExample extends StatelessWidget {
  final List<TimelineItem> _sampleItems = [
    TimelineItem(
      title: '项目启动',
      description: '开始规划项目需求和技术架构',
      date: DateTime(2024, 1, 1),
      color: Colors.blue,
    ),
    TimelineItem(
      title: '需求分析',
      description: '完成详细的需求文档和功能规格',
      date: DateTime(2024, 1, 15),
      color: Colors.green,
    ),
    TimelineItem(
      title: '开发阶段',
      description: '实现核心功能和UI界面',
      date: DateTime(2024, 2, 1),
      color: Colors.orange,
    ),
    TimelineItem(
      title: '测试阶段',
      description: '进行全面的功能测试和性能优化',
      date: DateTime(2024, 2, 15),
      color: Colors.purple,
    ),
    TimelineItem(
      title: '项目上线',
      description: '发布应用到生产环境',
      date: DateTime(2024, 3, 1),
      color: Colors.red,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Timeline(
          items: _sampleItems,
          onTap: (item) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('点击了: ${item.title}')),
            );
          },
        ),
      ),
    );
  }
}
