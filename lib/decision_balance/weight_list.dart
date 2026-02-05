import 'package:flutter/material.dart';
import 'decision_model.dart';

class WeightList extends StatelessWidget {
  final DecisionOption leftOption;
  final DecisionOption rightOption;
  final Function(String, String) onRemoveWeight;

  const WeightList({
    Key? key,
    required this.leftOption,
    required this.rightOption,
    required this.onRemoveWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Left option weights
        _buildOptionWeights(leftOption, 'left'),
        
        SizedBox(height: 16),
        
        // Right option weights
        _buildOptionWeights(rightOption, 'right'),
      ],
    );
  }

  Widget _buildOptionWeights(DecisionOption option, String optionSide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${option.title} 的考虑因素',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: optionSide == 'left' ? Colors.blue : Colors.red,
          ),
        ),
        SizedBox(height: 8),
        if (option.weights.isEmpty) 
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              '暂无考虑因素',
              style: TextStyle(color: Colors.grey[600]),
            ),
          )
        else
          Column(
            children: option.weights.map((weight) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 4),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              weight.description,
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '权重: ${weight.value.toStringAsFixed(1)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => onRemoveWeight(weight.id, optionSide),
                        icon: Icon(Icons.delete, color: Colors.red[400]),
                        iconSize: 18,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
