import 'package:flutter/material.dart';
import 'anchor_scroll.dart';

class AnchorHome extends StatefulWidget {
  const AnchorHome({super.key});

  @override
  State<AnchorHome> createState() => _AnchorHomeState();
}

class _AnchorHomeState extends State<AnchorHome> {
  List<AnchorItem> _items = [];

  @override
  void initState() {
    super.initState();
    _initItems();
  }

  void _initItems() {
    _items = [
      AnchorItem(
        title: '首页',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '欢迎使用锚点链接平滑滚动',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('点击左侧导航栏可以平滑滚动到对应内容'),
          ],
        ),
      ),
      AnchorItem(
        title: '产品',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '产品介绍',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('我们提供优质的产品和服务'),
          ],
        ),
      ),
      AnchorItem(
        title: '服务',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '服务支持',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('专业的服务团队为您提供支持'),
          ],
        ),
      ),
      AnchorItem(
        title: '关于',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '关于我们',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('了解我们的公司和团队'),
          ],
        ),
      ),
      AnchorItem(
        title: '联系',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '联系我们',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('通过多种方式联系我们'),
          ],
        ),
      ),
      AnchorItem(
        title: '常见问题',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '常见问题',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('查看常见问题的解答'),
          ],
        ),
      ),
      AnchorItem(
        title: '隐私政策',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '隐私政策',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('了解我们的隐私保护政策'),
          ],
        ),
      ),
      AnchorItem(
        title: '使用条款',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '使用条款',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('了解我们的服务使用条款'),
          ],
        ),
      ),
    ];
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('锚点链接平滑滚动'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // 锚点滚动组件
          Expanded(
            child: AnchorScroll(
              items: _items,
              itemHeight: 200.0,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
            ),
          ),
          
          // 使用说明
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '使用说明：',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text('1. 点击左侧导航栏可以平滑滚动到对应内容'),
                Text('2. 滚动右侧内容时，左侧导航栏会自动高亮当前位置'),
                Text('3. 可以根据实际需求修改导航栏和内容样式'),
                Text('4. 支持自定义每个锚点的标题和内容'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
