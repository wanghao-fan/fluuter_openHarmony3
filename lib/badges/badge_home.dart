import 'package:flutter/material.dart' hide Badge;
import './badge.dart';

class BadgeHome extends StatefulWidget {
  const BadgeHome({Key? key}) : super(key: key);

  @override
  _BadgeHomeState createState() => _BadgeHomeState();
}

class _BadgeHomeState extends State<BadgeHome> {
  int _messageCount = 5;
  int _notificationCount = 12;
  int _cartCount = 3;
  int _profileCount = 8;

  void _incrementCount(String type) {
    setState(() {
      switch (type) {
        case 'message':
          _messageCount++;
          break;
        case 'notification':
          _notificationCount++;
          break;
        case 'cart':
          _cartCount++;
          break;
        case 'profile':
          _profileCount++;
          break;
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('已增加$type徽章数量'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _clearCount(String type) {
    setState(() {
      switch (type) {
        case 'message':
          _messageCount = 0;
          break;
        case 'notification':
          _notificationCount = 0;
          break;
        case 'cart':
          _cartCount = 0;
          break;
        case 'profile':
          _profileCount = 0;
          break;
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('已清除$type徽章数量'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _badgeTapped(String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('点击了$type徽章'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('徽章角标示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // 通知图标徽章
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CustomBadge(
                child: IconButton(
                  icon: Icon(Icons.notifications, size: 24),
                  onPressed: () => _badgeTapped('通知'),
                ),
                count: _notificationCount,
                badgeColor: Colors.blue,
                onTap: () => _badgeTapped('通知'),
              ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '徽章角标演示',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            
            // 头像徽章
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  Text(
                    '头像徽章',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // 圆形头像徽章
                      Column(
                        children: [
                          CustomBadge(
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                'https://randomuser.me/api/portraits/men/32.jpg',
                              ),
                            ),
                            count: _profileCount,
                            badgeSize: 22,
                            onTap: () => _badgeTapped('头像'),
                          ),
                          SizedBox(height: 8),
                          Text('个人中心'),
                        ],
                      ),
                      
                      // 方形头像徽章
                      Column(
                        children: [
                          CustomBadge(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.person, size: 32, color: Colors.grey[600]),
                            ),
                            count: 1,
                            badgeSize: 18,
                            badgeColor: Colors.green,
                            onTap: () => _badgeTapped('方形头像'),
                          ),
                          SizedBox(height: 8),
                          Text('新消息'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // 图标徽章
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  Text(
                    '图标徽章',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // 消息图标徽章
                      Column(
                        children: [
                          CustomBadge(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(Icons.message, size: 28, color: Colors.blue),
                            ),
                            count: _messageCount,
                            badgeSize: 20,
                            onTap: () => _badgeTapped('消息'),
                          ),
                          SizedBox(height: 8),
                          Text('消息'),
                        ],
                      ),
                      
                      // 购物车图标徽章
                      Column(
                        children: [
                          CustomBadge(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.orange[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(Icons.shopping_cart, size: 28, color: Colors.orange),
                            ),
                            count: _cartCount,
                            badgeSize: 20,
                            badgeColor: Colors.orange,
                            onTap: () => _badgeTapped('购物车'),
                          ),
                          SizedBox(height: 8),
                          Text('购物车'),
                        ],
                      ),
                      
                      // 邮箱图标徽章
                      Column(
                        children: [
                          CustomBadge(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.red[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(Icons.email, size: 28, color: Colors.red),
                            ),
                            count: 99,
                            badgeSize: 20,
                            badgeColor: Colors.red,
                            onTap: () => _badgeTapped('邮箱'),
                          ),
                          SizedBox(height: 8),
                          Text('邮箱'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // 控制按钮
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  Text(
                    '徽章控制',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ElevatedButton(
                        onPressed: () => _incrementCount('message'),
                        child: Text('增加消息数'),
                      ),
                      ElevatedButton(
                        onPressed: () => _incrementCount('notification'),
                        child: Text('增加通知数'),
                      ),
                      ElevatedButton(
                        onPressed: () => _incrementCount('cart'),
                        child: Text('增加购物车数'),
                      ),
                      ElevatedButton(
                        onPressed: () => _incrementCount('profile'),
                        child: Text('增加个人中心数'),
                      ),
                      ElevatedButton(
                        onPressed: () => _clearCount('message'),
                        child: Text('清除消息数'),
                      ),
                      ElevatedButton(
                        onPressed: () => _clearCount('notification'),
                        child: Text('清除通知数'),
                      ),
                      ElevatedButton(
                        onPressed: () => _clearCount('cart'),
                        child: Text('清除购物车数'),
                      ),
                      ElevatedButton(
                        onPressed: () => _clearCount('profile'),
                        child: Text('清除个人中心数'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // 使用说明
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
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
                  Text('1. 点击徽章可查看点击效果'),
                  Text('2. 使用控制按钮增加或清除徽章数量'),
                  Text('3. 徽章数量超过99时会显示为"99+"'),
                  Text('4. 不同颜色的徽章演示不同风格'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
