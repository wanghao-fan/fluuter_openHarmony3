import 'package:flutter/material.dart';

class TreeNode {
  final String title;
  final List<TreeNode>? children;
  bool isExpanded;

  TreeNode({
    required this.title,
    this.children,
    this.isExpanded = false,
  });
}

class TreeView extends StatefulWidget {
  final List<TreeNode> nodes;
  final Function(TreeNode)? onTap;

  const TreeView({
    Key? key,
    required this.nodes,
    this.onTap,
  }) : super(key: key);

  @override
  State<TreeView> createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.nodes.length,
      itemBuilder: (context, index) {
        return _buildTreeNode(widget.nodes[index], 0);
      },
    );
  }

  Widget _buildTreeNode(TreeNode node, int level) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              node.isExpanded = !node.isExpanded;
            });
            if (widget.onTap != null) {
              widget.onTap!(node);
            }
          },
          child: Container(
            padding: EdgeInsets.only(
              left: 20.0 * level,
              top: 12.0,
              bottom: 12.0,
              right: 16.0,
            ),
            child: Row(
              children: [
                if (node.children != null && node.children!.isNotEmpty) 
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      node.isExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 18.0,
                      color: Colors.blue,
                    ),
                  ),
                Expanded(
                  child: Text(
                    node.title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: level == 0 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (node.isExpanded && node.children != null) 
          for (var child in node.children!) 
            _buildTreeNode(child, level + 1),
      ],
    );
  }
}

class TreeViewExample extends StatelessWidget {
  final List<TreeNode> _sampleData = [
    TreeNode(
      title: '公司总部',
      children: [
        TreeNode(
          title: '技术部',
          children: [
            TreeNode(title: '前端开发'),
            TreeNode(title: '后端开发'),
            TreeNode(title: '测试团队'),
          ],
        ),
        TreeNode(
          title: '市场部',
          children: [
            TreeNode(title: '品牌推广'),
            TreeNode(title: '销售团队'),
          ],
        ),
        TreeNode(
          title: '人力资源部',
          children: [
            TreeNode(title: '招聘组'),
            TreeNode(title: '培训组'),
          ],
        ),
      ],
    ),
    TreeNode(
      title: '分公司',
      children: [
        TreeNode(title: '北京分公司'),
        TreeNode(title: '上海分公司'),
        TreeNode(title: '广州分公司'),
      ],
    ),
    TreeNode(
      title: '合作伙伴',
      children: [
        TreeNode(title: '供应商'),
        TreeNode(title: '客户'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TreeView(
          nodes: _sampleData,
          onTap: (node) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('点击了: ${node.title}')),
            );
          },
        ),
      ),
    );
  }
}
