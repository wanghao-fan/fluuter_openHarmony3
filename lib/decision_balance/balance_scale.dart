import 'package:flutter/material.dart';
import 'decision_model.dart';

class BalanceScale extends StatelessWidget {
  final DecisionOption leftOption;
  final DecisionOption rightOption;
  final double width;
  final double height;

  const BalanceScale({
    Key? key,
    required this.leftOption,
    required this.rightOption,
    this.width = 300,
    this.height = 200,
  }) : super(key: key);

  double get _tiltAngle {
    final totalWeight = leftOption.totalWeight + rightOption.totalWeight;
    if (totalWeight == 0) return 0;
    
    final difference = leftOption.totalWeight - rightOption.totalWeight;
    final normalizedDifference = difference / totalWeight;
    
    // Limit the angle to +/- 30 degrees (in radians)
    return normalizedDifference * 0.5236; // 30 degrees in radians
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Balance base
          Positioned(
            bottom: 0,
            child: Container(
              width: 20,
              height: height * 0.3,
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          
          // Balance beam
          Transform.rotate(
            angle: _tiltAngle,
            child: Container(
              width: width * 0.8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          
          // Left pan
          Positioned(
            left: width * 0.1,
            top: height * 0.4,
            child: Transform.translate(
              offset: Offset(0, _tiltAngle * 50),
              child: _buildPan(leftOption),
            ),
          ),
          
          // Right pan
          Positioned(
            right: width * 0.1,
            top: height * 0.4,
            child: Transform.translate(
              offset: Offset(0, -_tiltAngle * 50),
              child: _buildPan(rightOption),
            ),
          ),
          
          // Option titles
          Positioned(
            left: width * 0.1,
            bottom: height * 0.35,
            child: Container(
              width: width * 0.35,
              child: Text(
                leftOption.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          
          Positioned(
            right: width * 0.1,
            bottom: height * 0.35,
            child: Container(
              width: width * 0.35,
              child: Text(
                rightOption.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          
          // Weight values
          Positioned(
            left: width * 0.1,
            top: height * 0.7,
            child: Container(
              width: width * 0.35,
              child: Text(
                '${leftOption.totalWeight.toStringAsFixed(1)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          
          Positioned(
            right: width * 0.1,
            top: height * 0.7,
            child: Container(
              width: width * 0.35,
              child: Text(
                '${rightOption.totalWeight.toStringAsFixed(1)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPan(DecisionOption option) {
    return Container(
      width: width * 0.35,
      height: height * 0.2,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          option.weights.length.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
