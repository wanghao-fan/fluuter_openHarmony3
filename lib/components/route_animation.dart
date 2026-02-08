import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final RouteAnimationType type;

  CustomPageRoute({
    required this.child,
    required this.type,
  }) : super(
          transitionDuration: Duration(milliseconds: 500),
          reverseTransitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (type) {
              case RouteAnimationType.fade:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              case RouteAnimationType.slide:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              case RouteAnimationType.scale:
                return ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(animation),
                  child: child,
                );
              case RouteAnimationType.rotate:
                return RotationTransition(
                  turns: Tween<double>(
                    begin: 1.0,
                    end: 0.0,
                  ).animate(animation),
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              default:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
            }
          },
        );
}

enum RouteAnimationType {
  fade,
  slide,
  scale,
  rotate,
}

class RouteAnimationExample extends StatelessWidget {
  const RouteAnimationExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('页面路由切换动画'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '第一页',
              style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            _buildAnimationButton(context, '淡入淡出', RouteAnimationType.fade),
            SizedBox(height: 20),
            _buildAnimationButton(context, '滑动', RouteAnimationType.slide),
            SizedBox(height: 20),
            _buildAnimationButton(context, '缩放', RouteAnimationType.scale),
            SizedBox(height: 20),
            _buildAnimationButton(context, '旋转', RouteAnimationType.rotate),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimationButton(BuildContext context, String title, RouteAnimationType type) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          CustomPageRoute(
            child: SecondPage(animationType: type),
            type: type,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        textStyle: TextStyle(fontSize: 18),
      ),
      child: Text(title),
    );
  }
}

class SecondPage extends StatelessWidget {
  final RouteAnimationType animationType;

  const SecondPage({Key? key, required this.animationType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '第二页',
              style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '动画类型: ${_getAnimationTypeName()}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('返回第一页'),
            ),
          ],
        ),
      ),
    );
  }

  String _getAnimationTypeName() {
    switch (animationType) {
      case RouteAnimationType.fade:
        return '淡入淡出';
      case RouteAnimationType.slide:
        return '滑动';
      case RouteAnimationType.scale:
        return '缩放';
      case RouteAnimationType.rotate:
        return '旋转';
      default:
        return '未知';
    }
  }
}
