import 'package:flutter/material.dart';

/// 抽屉导航组件
class DrawerNavigation extends StatelessWidget {
  /// 抽屉标题
  final String title;

  /// 用户头像
  final String avatarPath;

  /// 用户名
  final String userName;

  /// 用户邮箱
  final String userEmail;

  /// 菜单项列表
  final List<DrawerMenuItem> menuItems;

  /// 底部菜单项列表
  final List<DrawerMenuItem>? bottomMenuItems;

  /// 抽屉宽度占屏幕宽度的比例
  final double drawerWidthRatio;

  const DrawerNavigation({
    Key? key,
    this.title = '抽屉导航',
    this.avatarPath = 'https://randomuser.me/api/portraits/men/32.jpg',
    this.userName = '张三',
    this.userEmail = 'zhangsan@example.com',
    required this.menuItems,
    this.bottomMenuItems,
    this.drawerWidthRatio = 0.75,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth * drawerWidthRatio;

    return Drawer(
      width: drawerWidth,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // 抽屉头部
          _buildDrawerHeader(),

          // 菜单项
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return _buildMenuItem(item);
              },
            ),
          ),

          // 底部菜单项
          if (bottomMenuItems != null && bottomMenuItems!.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: Column(
                children: bottomMenuItems!
                    .map((item) => _buildMenuItem(item))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }

  /// 构建抽屉头部
  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.blueAccent],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // 用户信息
          Row(
            children: [
              // 头像
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(avatarPath),
                backgroundColor: Colors.white,
              ),
              const SizedBox(width: 16),

              // 用户名和邮箱
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userEmail,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建菜单项
  Widget _buildMenuItem(DrawerMenuItem item) {
    return ListTile(
      leading: Icon(item.icon, color: item.iconColor),
      title: Text(
        item.title,
        style: TextStyle(
          fontSize: 16,
          color: item.textColor,
        ),
      ),
      trailing: item.trailing,
      onTap: item.onTap,
      selected: item.isSelected,
      selectedTileColor: item.selectedTileColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }
}

/// 抽屉菜单项
class DrawerMenuItem {
  /// 菜单项标题
  final String title;

  /// 菜单项图标
  final IconData icon;

  /// 图标颜色
  final Color iconColor;

  /// 文本颜色
  final Color textColor;

  /// 点击回调
  final VoidCallback? onTap;

  /// 尾部组件
  final Widget? trailing;

  /// 是否选中
  final bool isSelected;

  /// 选中时的背景颜色
  final Color selectedTileColor;

  DrawerMenuItem({
    required this.title,
    required this.icon,
    this.iconColor = Colors.grey,
    this.textColor = Colors.black,
    this.onTap,
    this.trailing,
    this.isSelected = false,
    this.selectedTileColor =
        const Color(0x1A2196F3), // Colors.blue.withOpacity(0.1) 的十六进制表示
  });
}

/// 抽屉导航展示组件
class DrawerNavigationDisplay extends StatefulWidget {
  const DrawerNavigationDisplay({Key? key}) : super(key: key);

  @override
  State<DrawerNavigationDisplay> createState() =>
      _DrawerNavigationDisplayState();
}

class _DrawerNavigationDisplayState extends State<DrawerNavigationDisplay> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 菜单项
    final menuItems = [
      DrawerMenuItem(
        title: '首页',
        icon: Icons.home,
        iconColor: _selectedIndex == 0 ? Colors.blue : Colors.grey,
        isSelected: _selectedIndex == 0,
        onTap: () => _selectItem(0),
      ),
      DrawerMenuItem(
        title: '个人资料',
        icon: Icons.person,
        iconColor: _selectedIndex == 1 ? Colors.blue : Colors.grey,
        isSelected: _selectedIndex == 1,
        onTap: () => _selectItem(1),
      ),
      DrawerMenuItem(
        title: '设置',
        icon: Icons.settings,
        iconColor: _selectedIndex == 2 ? Colors.blue : Colors.grey,
        isSelected: _selectedIndex == 2,
        onTap: () => _selectItem(2),
      ),
      DrawerMenuItem(
        title: '关于我们',
        icon: Icons.info,
        iconColor: _selectedIndex == 3 ? Colors.blue : Colors.grey,
        isSelected: _selectedIndex == 3,
        onTap: () => _selectItem(3),
      ),
    ];

    // 底部菜单项
    final bottomMenuItems = [
      DrawerMenuItem(
        title: '退出登录',
        icon: Icons.logout,
        iconColor: Colors.red,
        textColor: Colors.red,
        onTap: () => _showLogoutDialog(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('抽屉导航示例'),
        // 移除打开抽屉的按钮
      ),
      drawer: DrawerNavigation(
        title: 'Flutter for OpenHarmony',
        menuItems: menuItems,
        bottomMenuItems: bottomMenuItems,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 移除打开抽屉的提示文本
            const SizedBox(height: 20),
            Text(
              '当前选中: ${_getSelectedItemName()}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            // 移除打开抽屉的按钮
          ],
        ),
      ),
    );
  }

  /// 选择菜单项
  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  /// 获取当前选中的菜单项名称
  String _getSelectedItemName() {
    switch (_selectedIndex) {
      case 0:
        return '首页';
      case 1:
        return '个人资料';
      case 2:
        return '设置';
      case 3:
        return '关于我们';
      default:
        return '首页';
    }
  }

  /// 显示退出登录对话框
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('退出登录'),
          content: const Text('确定要退出登录吗？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                // 这里可以添加退出登录的逻辑
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('已退出登录'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }
}
