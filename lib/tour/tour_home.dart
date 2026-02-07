import 'package:flutter/material.dart';
import 'page_tour.dart';

class TourHome extends StatefulWidget {
  const TourHome({super.key});

  @override
  State<TourHome> createState() => _TourHomeState();
}

class _TourHomeState extends State<TourHome> {
  bool _showTour = true;
  String _message = '';

  void _handleTourComplete() {
    setState(() {
      _showTour = false;
      _message = '页面引导已完成';
    });

    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _message = '';
        });
      }
    });
  }

  void _restartTour() {
    setState(() {
      _showTour = true;
      _message = '页面引导已重启';
    });

    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _message = '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonWidth = screenSize.width * 0.8;
    final buttonHeight = 50.0;

    // 定义引导步骤
    final tourSteps = [
      TourStep(
        title: '欢迎使用',
        description: '这是一个页面引导示例，点击任意位置或按钮继续',
        offset: Offset((screenSize.width - buttonWidth) / 2, 100),
        size: Size(buttonWidth, buttonHeight),
      ),
      TourStep(
        title: '功能按钮',
        description: '点击这里可以执行相关操作',
        offset: Offset((screenSize.width - buttonWidth) / 2, 200),
        size: Size(buttonWidth, buttonHeight),
      ),
      TourStep(
        title: '设置按钮',
        description: '点击这里可以打开设置页面',
        offset: Offset((screenSize.width - buttonWidth) / 2, 300),
        size: Size(buttonWidth, buttonHeight),
      ),
      TourStep(
        title: '重启引导',
        description: '点击这里可以重新查看引导',
        offset: Offset((screenSize.width - buttonWidth) / 2, 400),
        size: Size(buttonWidth, buttonHeight),
      ),
    ];

    // 主页面内容
    final homeContent = Scaffold(
      appBar: AppBar(
        title: Text('页面引导示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 消息提示
            if (_message.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[300]!),
                ),
                child: Text(
                  _message,
                  style: TextStyle(color: Colors.blue[700]),
                ),
              ),
            
            SizedBox(height: 50),
            
            // 功能按钮
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _message = '功能按钮被点击';
                  });
                  Future.delayed(Duration(seconds: 2), () {
                    if (mounted) {
                      setState(() {
                        _message = '';
                      });
                    }
                  });
                },
                child: Text('功能按钮'),
              ),
            ),
            
            SizedBox(height: 20),
            
            // 设置按钮
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _message = '设置按钮被点击';
                  });
                  Future.delayed(Duration(seconds: 2), () {
                    if (mounted) {
                      setState(() {
                        _message = '';
                      });
                    }
                  });
                },
                child: Text('设置按钮'),
              ),
            ),
            
            SizedBox(height: 20),
            
            // 重启引导按钮
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: _restartTour,
                child: Text('重启引导'),
              ),
            ),
            
            SizedBox(height: 50),
            
            // 使用说明
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 20),
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
                  Text('1. 首次进入页面会自动显示引导'),
                  Text('2. 点击任意位置或按钮可以继续引导'),
                  Text('3. 点击"重启引导"按钮可以重新查看引导'),
                  Text('4. 引导完成后可以正常使用页面功能'),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // 根据是否显示引导返回不同的内容
    if (_showTour) {
      return PageTour(
        steps: tourSteps,
        primaryColor: Colors.blue,
        backgroundColor: Colors.black,
        onComplete: _handleTourComplete,
        child: homeContent,
      );
    } else {
      return homeContent;
    }
  }
}
