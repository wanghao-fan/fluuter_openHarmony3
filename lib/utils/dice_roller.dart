import 'package:flutter/material.dart';
import 'dart:math';

class DiceRoller extends StatefulWidget {
  final int sides; // 骰子面数
  final double size; // 骰子大小
  final Color diceColor; // 骰子颜色
  final Color dotColor; // 点数颜色
  final Color textColor; // 文本颜色

  const DiceRoller({
    Key? key,
    this.sides = 6,
    this.size = 150.0,
    this.diceColor = Colors.white,
    this.dotColor = Colors.black,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> with SingleTickerProviderStateMixin {
  late int _currentValue; // 当前骰子值
  late AnimationController _controller; // 动画控制器
  late Animation<double> _animation; // 旋转动画
  bool _isRolling = false; // 是否正在掷骰子

  @override
  void initState() {
    super.initState();
    _currentValue = Random().nextInt(widget.sides) + 1; // 初始化随机值
    
    // 初始化动画控制器
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    // 创建旋转动画
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 掷骰子方法
  void _rollDice() {
    if (_isRolling) return;
    
    setState(() {
      _isRolling = true;
    });

    // 启动动画
    _controller.forward().then((_) {
      // 动画结束后更新骰子值
      setState(() {
        _currentValue = Random().nextInt(widget.sides) + 1;
        _isRolling = false;
      });
      // 重置动画
      _controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 骰子标题
        Text(
          '${widget.sides}面骰子',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: widget.textColor,
          ),
        ),
        const SizedBox(height: 20),
        
        // 骰子动画区域
        GestureDetector(
          onTap: _rollDice,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..rotateX(_animation.value * 2 * pi)
                  ..rotateY(_animation.value * 2 * pi),
                alignment: Alignment.center,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: widget.diceColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _currentValue.toString(),
                      style: TextStyle(
                        fontSize: widget.size * 0.4,
                        fontWeight: FontWeight.bold,
                        color: widget.dotColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        
        const SizedBox(height: 15),
        
        // 当前点数显示
        Text(
          '当前点数: $_currentValue',
          style: TextStyle(
            fontSize: 16,
            color: widget.textColor,
          ),
        ),
        
        const SizedBox(height: 10),
        
        // 提示文本
        Text(
          '点击骰子开始掷',
          style: TextStyle(
            fontSize: 14,
            color: widget.textColor.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}