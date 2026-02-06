import 'package:flutter/material.dart';
import 'loading_button.dart';

class LoadingButtonHome extends StatefulWidget {
  const LoadingButtonHome({Key? key}) : super(key: key);

  @override
  _LoadingButtonHomeState createState() => _LoadingButtonHomeState();
}

class _LoadingButtonHomeState extends State<LoadingButtonHome> {
  String _status = '点击按钮开始加载';

  Future<void> _simulateLoading() async {
    setState(() {
      _status = '加载中...';
    });
    
    // 模拟网络请求或其他耗时操作
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      _status = '加载完成';
    });
    
    // 显示成功提示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('操作成功！'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('按钮加载状态示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '按钮加载状态演示',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            
            // 状态提示
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _status,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: 40),
            
            // 主要加载按钮
            LoadingButton(
              text: '点击加载',
              onPressed: _simulateLoading,
              width: double.infinity,
              height: 56,
              color: Colors.blue,
              textColor: Colors.white,
              fontSize: 18,
              borderRadius: BorderRadius.circular(12),
            ),
            SizedBox(height: 20),
            
            // 不同样式的加载按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: LoadingButton(
                    text: '红色按钮',
                    onPressed: _simulateLoading,
                    width: 150,
                    height: 48,
                    color: Colors.red,
                    textColor: Colors.white,
                    fontSize: 14,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: LoadingButton(
                    text: '绿色按钮',
                    onPressed: _simulateLoading,
                    width: 150,
                    height: 48,
                    color: Colors.green,
                    textColor: Colors.white,
                    fontSize: 14,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            
            // 按钮使用说明
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
                  Text('1. 点击按钮后，按钮会显示加载状态'),
                  Text('2. 加载过程中，按钮会显示"加载中..."文字和旋转动画'),
                  Text('3. 加载完成后，按钮会恢复原始状态'),
                  Text('4. 不同颜色的按钮演示不同风格'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
