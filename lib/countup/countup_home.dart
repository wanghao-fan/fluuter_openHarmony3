import 'package:flutter/material.dart';
import 'count_up.dart';

class CountUpHome extends StatefulWidget {
  const CountUpHome({super.key});

  @override
  State<CountUpHome> createState() => _CountUpHomeState();
}

class _CountUpHomeState extends State<CountUpHome> {
  bool _isAnimating = false;
  String _message = '';

  void _restartAnimation() {
    setState(() {
      _isAnimating = true;
      _message = '数字滚动动画已重启';
    });

    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _message = '';
        });
      }
    });

    // 延迟后重置状态，允许动画重新触发
    Future.delayed(Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _isAnimating = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('数字滚动增长'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 标题部分
            Container(
              margin: const EdgeInsets.only(bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '数字滚动增长',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '支持点击交互效果',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

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

            // 数字滚动展示区
            Container(
              margin: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                children: [
                  // 计数器 1: 网站访问量
                  GestureDetector(
                    onTap: _restartAnimation,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 30.0),
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200]!,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            '网站访问量',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 16),
                          !_isAnimating
                              ? CountUp(
                                  from: 0,
                                  to: 123456,
                                  duration: Duration(seconds: 2),
                                  prefix: '',
                                  suffix: '',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                  onComplete: () {
                                    setState(() {
                                      _message = '访问量统计完成';
                                    });
                                    Future.delayed(Duration(seconds: 2), () {
                                      if (mounted) {
                                        setState(() {
                                          _message = '';
                                        });
                                      }
                                    });
                                  },
                                )
                              : SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text(
                                      '123456',
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),

                  // 计数器 2: 销售金额
                  GestureDetector(
                    onTap: _restartAnimation,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 30.0),
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200]!,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            '销售金额',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 16),
                          !_isAnimating
                              ? CountUp(
                                  from: 0,
                                  to: 98765.43,
                                  duration: Duration(seconds: 2),
                                  decimalPlaces: 2,
                                  prefix: '¥',
                                  suffix: '',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                )
                              : SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text(
                                      '¥98765.43',
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),

                  // 计数器 3: 用户数量
                  GestureDetector(
                    onTap: _restartAnimation,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 30.0),
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200]!,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            '用户数量',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 16),
                          !_isAnimating
                              ? CountUp(
                                  from: 0,
                                  to: 54321,
                                  duration: Duration(seconds: 2),
                                  prefix: '',
                                  suffix: ' 人',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                  ),
                                )
                              : SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Text(
                                      '54321 人',
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
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
                  Text('1. 点击任意数字卡片可以重启滚动动画'),
                  Text('2. 数字会从 0 平滑滚动到目标值'),
                  Text('3. 不同类型的数据使用不同颜色区分'),
                  Text('4. 可以根据实际需求修改目标值和样式'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
