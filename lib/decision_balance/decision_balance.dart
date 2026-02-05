import 'package:flutter/material.dart';
import 'decision_model.dart';
import 'balance_scale.dart';
import 'add_weight_form.dart';
import 'weight_list.dart';

class DecisionBalance extends StatefulWidget {
  final String leftOptionTitle;
  final String rightOptionTitle;

  const DecisionBalance({
    Key? key,
    this.leftOptionTitle = '选项 A',
    this.rightOptionTitle = '选项 B',
  }) : super(key: key);

  @override
  _DecisionBalanceState createState() => _DecisionBalanceState();
}

class _DecisionBalanceState extends State<DecisionBalance> {
  late DecisionOption _leftOption;
  late DecisionOption _rightOption;

  @override
  void initState() {
    super.initState();
    _leftOption = DecisionOption(
      id: 'left',
      title: widget.leftOptionTitle,
    );
    _rightOption = DecisionOption(
      id: 'right',
      title: widget.rightOptionTitle,
    );
  }

  void _addWeight(String description, double value, String optionSide) {
    setState(() {
      final weight = Weight(
        id: DateTime.now().toString(),
        description: description,
        value: value,
      );

      if (optionSide == 'left') {
        _leftOption = _leftOption.addWeight(weight);
      } else {
        _rightOption = _rightOption.addWeight(weight);
      }
    });
  }

  void _removeWeight(String weightId, String optionSide) {
    setState(() {
      if (optionSide == 'left') {
        _leftOption = _leftOption.removeWeight(weightId);
      } else {
        _rightOption = _rightOption.removeWeight(weightId);
      }
    });
  }

  String get _decisionResult {
    final leftWeight = _leftOption.totalWeight;
    final rightWeight = _rightOption.totalWeight;

    if (leftWeight == 0 && rightWeight == 0) {
      return '请添加考虑因素';
    } else if (leftWeight > rightWeight) {
      return '${_leftOption.title} 更优';
    } else if (rightWeight > leftWeight) {
      return '${_rightOption.title} 更优';
    } else {
      return '两者相当';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Decision result
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _decisionResult,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
            ),

            // Balance scale
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 24),
              child: BalanceScale(
                leftOption: _leftOption,
                rightOption: _rightOption,
                width: 320,
                height: 220,
              ),
            ),

            // Add weight form
            AddWeightForm(onAddWeight: _addWeight),

            // Weight lists
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: WeightList(
                leftOption: _leftOption,
                rightOption: _rightOption,
                onRemoveWeight: _removeWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
