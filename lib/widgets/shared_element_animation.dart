import 'package:flutter/material.dart';

class SharedElementAnimationWidget extends StatefulWidget {
  const SharedElementAnimationWidget({Key? key}) : super(key: key);

  @override
  _SharedElementAnimationWidgetState createState() => _SharedElementAnimationWidgetState();
}

class _SharedElementAnimationWidgetState extends State<SharedElementAnimationWidget> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            '共享元素动画',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 40),
          _isExpanded ? _buildExpandedView() : _buildThumbnailView(),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _toggleExpanded,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(_isExpanded ? '收起' : '展开'),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnailView() {
    return GestureDetector(
      onTap: _toggleExpanded,
      child: Hero(
        tag: 'hero-tag',
        child: Container(
          width: 120,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              '卡片',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedView() {
    return GestureDetector(
      onTap: _toggleExpanded,
      child: Hero(
        tag: 'hero-tag',
        child: Container(
          width: 300,
          height: 450,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '详细内容',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '这是一个共享元素动画的示例。当点击卡片时，它会从缩略图大小平滑过渡到全屏大小，展示详细内容。',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '共享元素动画（Hero动画）是一种在不同视图之间创建流畅过渡的方式，让用户感觉界面更加连贯和专业。',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SharedElementAnimationGrid extends StatefulWidget {
  const SharedElementAnimationGrid({Key? key}) : super(key: key);

  @override
  _SharedElementAnimationGridState createState() => _SharedElementAnimationGridState();
}

class _SharedElementAnimationGridState extends State<SharedElementAnimationGrid> {
  int? _selectedIndex;

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = _selectedIndex == index ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            '网格共享元素动画',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 40),
          if (_selectedIndex == null)
            _buildGridView()
          else
            _buildExpandedItem(_selectedIndex!),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _selectItem(index),
          child: Hero(
            tag: 'grid-item-$index',
            child: Container(
              decoration: BoxDecoration(
                color: Colors.primaries[index % Colors.primaries.length],
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Item ${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildExpandedItem(int index) {
    return GestureDetector(
      onTap: () => _selectItem(index),
      child: Hero(
        tag: 'grid-item-$index',
        child: Container(
          width: 300,
          height: 450,
          decoration: BoxDecoration(
            color: Colors.primaries[index % Colors.primaries.length],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Item ${index + 1} 详情',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '这是一个网格共享元素动画的示例。当点击网格中的项时，它会平滑过渡到全屏大小，展示详细内容。',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '点击任意位置可返回网格视图。',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SharedElementAnimationContainer extends StatelessWidget {
  const SharedElementAnimationContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20),
        Center(
          child: Text(
            '单个共享元素动画',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: SharedElementAnimationWidget(),
        ),
        SizedBox(height: 60),
        Center(
          child: Text(
            '网格共享元素动画',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: SharedElementAnimationGrid(),
        ),
        SizedBox(height: 60),
      ],
    );
  }
}