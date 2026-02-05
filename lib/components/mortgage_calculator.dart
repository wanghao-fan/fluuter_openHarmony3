import 'package:flutter/material.dart';

class MortgageCalculator extends StatefulWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;

  const MortgageCalculator({
    super.key,
    this.primaryColor = Colors.deepPurple,
    this.secondaryColor = Colors.deepPurpleAccent,
    this.borderColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.borderRadius = 8.0,
  });

  @override
  State<MortgageCalculator> createState() => _MortgageCalculatorState();
}

class _MortgageCalculatorState extends State<MortgageCalculator> {
  // 贷款金额
  final TextEditingController _loanAmountController = TextEditingController(text: '1000000');
  // 贷款期限（年）
  int _loanTerm = 30;
  // 贷款利率（年利率）
  final TextEditingController _interestRateController = TextEditingController(text: '4.9');
  // 还款方式：0-等额本息，1-等额本金
  int _repaymentType = 0;

  // 计算结果
  double _monthlyPayment = 0.0;
  double _totalPayment = 0.0;
  double _totalInterest = 0.0;
  bool _showResult = false;

  // 计算月供
  void _calculate() {
    final double loanAmount = double.tryParse(_loanAmountController.text) ?? 0;
    final double interestRate = double.tryParse(_interestRateController.text) ?? 0;
    final double monthlyRate = interestRate / 100 / 12;
    final int totalMonths = _loanTerm * 12;

    if (loanAmount <= 0 || interestRate <= 0) {
      setState(() {
        _showResult = false;
      });
      return;
    }

    double monthlyPayment = 0.0;
    double totalPayment = 0.0;

    if (_repaymentType == 0) {
      // 等额本息
      monthlyPayment = loanAmount * monthlyRate * pow(1 + monthlyRate, totalMonths) /
          (pow(1 + monthlyRate, totalMonths) - 1);
      totalPayment = monthlyPayment * totalMonths;
    } else {
      // 等额本金
      final double principalPayment = loanAmount / totalMonths;
      double totalInterest = 0.0;
      
      for (int i = 0; i < totalMonths; i++) {
        final double remainingPrincipal = loanAmount - principalPayment * i;
        final double interestPayment = remainingPrincipal * monthlyRate;
        totalInterest += interestPayment;
      }
      
      monthlyPayment = principalPayment + loanAmount * monthlyRate; // 首月月供
      totalPayment = loanAmount + totalInterest;
    }

    setState(() {
      _monthlyPayment = monthlyPayment;
      _totalPayment = totalPayment;
      _totalInterest = totalPayment - loanAmount;
      _showResult = true;
    });
  }

  // 计算幂
  double pow(double base, int exponent) {
    double result = 1.0;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border.all(color: widget.borderColor),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
          // 贷款金额
          _buildInputSection(
            label: '贷款金额',
            controller: _loanAmountController,
            hintText: '请输入贷款金额',
            suffix: '元',
          ),
          const SizedBox(height: 16.0),

          // 贷款期限
          _buildLoanTermSection(),
          const SizedBox(height: 16.0),

          // 贷款利率
          _buildInputSection(
            label: '贷款利率',
            controller: _interestRateController,
            hintText: '请输入年利率',
            suffix: '%',
          ),
          const SizedBox(height: 16.0),

          // 还款方式
          _buildRepaymentTypeSection(),
          const SizedBox(height: 24.0),

          // 计算按钮
          Center(
            child: ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
              ),
              child: const Text(
                '计算',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 24.0),

          // 计算结果
          if (_showResult)
            _buildResultSection(),
        ],
      ),
    ),
    );
  }

  // 构建输入区域
  Widget _buildInputSection({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required String suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: widget.textColor,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: widget.borderColor),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(suffix),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 构建贷款期限选择区域
  Widget _buildLoanTermSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '贷款期限',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: widget.textColor,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: widget.borderColor),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Slider(
                  value: _loanTerm.toDouble(),
                  min: 1,
                  max: 30,
                  divisions: 29,
                  label: '$_loanTerm 年',
                  onChanged: (value) {
                    setState(() {
                      _loanTerm = value.toInt();
                    });
                  },
                  activeColor: widget.primaryColor,
                  inactiveColor: widget.borderColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: widget.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                child: Text('$_loanTerm 年'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 构建还款方式选择区域
  Widget _buildRepaymentTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '还款方式',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: widget.textColor,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _repaymentType = 0;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _repaymentType == 0 ? widget.primaryColor : widget.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    color: _repaymentType == 0 
                        ? widget.primaryColor.withOpacity(0.1) 
                        : widget.backgroundColor,
                  ),
                  child: Center(
                    child: Text(
                      '等额本息',
                      style: TextStyle(
                        color: _repaymentType == 0 ? widget.primaryColor : widget.textColor,
                        fontWeight: _repaymentType == 0 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _repaymentType = 1;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _repaymentType == 1 ? widget.primaryColor : widget.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    color: _repaymentType == 1 
                        ? widget.primaryColor.withOpacity(0.1) 
                        : widget.backgroundColor,
                  ),
                  child: Center(
                    child: Text(
                      '等额本金',
                      style: TextStyle(
                        color: _repaymentType == 1 ? widget.primaryColor : widget.textColor,
                        fontWeight: _repaymentType == 1 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 构建结果区域
  Widget _buildResultSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: widget.secondaryColor),
        borderRadius: BorderRadius.circular(widget.borderRadius),
        color: widget.secondaryColor.withOpacity(0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '计算结果',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: widget.primaryColor,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildResultRow('月供', _monthlyPayment),
          _buildResultRow('总还款', _totalPayment),
          _buildResultRow('总利息', _totalInterest),
          if (_repaymentType == 1)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '* 等额本金首月月供为 ${_monthlyPayment.toStringAsFixed(2)} 元，每月递减',
                style: TextStyle(
                  fontSize: 12.0,
                  color: widget.textColor.withOpacity(0.7),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // 构建结果行
  Widget _buildResultRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.0, color: widget.textColor),
          ),
          Text(
            '${value.toStringAsFixed(2)} 元',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: widget.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
