import 'package:flutter/material.dart';

class PageTour extends StatefulWidget {
  final List<TourStep> steps;
  final Widget child;
  final Color? primaryColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Function(int)? onStepChanged;
  final Function()? onComplete;

  const PageTour({
    super.key,
    required this.steps,
    required this.child,
    this.primaryColor = Colors.blue,
    this.backgroundColor = Colors.black,
    this.textStyle,
    this.onStepChanged,
    this.onComplete,
  });

  @override
  State<PageTour> createState() => _PageTourState();
}

class TourStep {
  final String title;
  final String description;
  final Offset offset;
  final Size size;
  final Alignment alignment;

  const TourStep({
    required this.title,
    required this.description,
    required this.offset,
    required this.size,
    this.alignment = Alignment.topCenter,
  });
}

class _PageTourState extends State<PageTour> {
  int _currentStep = 0;
  bool _isTourActive = true;

  @override
  Widget build(BuildContext context) {
    if (!_isTourActive) {
      return widget.child;
    }

    final currentStep = widget.steps[_currentStep];
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        widget.child,
        GestureDetector(
          onTap: () => _nextStep(),
          child: Container(
            color: widget.backgroundColor!.withAlpha(153), // 0.6 opacity
            width: screenSize.width,
            height: screenSize.height,
            child: Stack(
              children: [
                // 高亮区域
                Positioned(
                  left: currentStep.offset.dx,
                  top: currentStep.offset.dy,
                  child: Container(
                    width: currentStep.size.width,
                    height: currentStep.size.height,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: widget.primaryColor!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                
                // 引导内容
                Positioned(
                  left: _calculateLeftPosition(currentStep, screenSize),
                  top: _calculateTopPosition(currentStep, screenSize),
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(51), // 0.2 opacity
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentStep.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: widget.primaryColor,
                          ).merge(widget.textStyle),
                        ),
                        SizedBox(height: 8),
                        Text(
                          currentStep.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ).merge(widget.textStyle),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (_currentStep > 0)
                              TextButton(
                                onPressed: () => _previousStep(),
                                child: Text('上一步'),
                              ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                if (_currentStep == widget.steps.length - 1) {
                                  _completeTour();
                                } else {
                                  _nextStep();
                                }
                              },
                              child: Text(
                                _currentStep == widget.steps.length - 1 ? '完成' : '下一步',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            widget.steps.length,
                            (index) => Container(
                              width: 8,
                              height: 8,
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index == _currentStep 
                                    ? widget.primaryColor 
                                    : Colors.grey[300],
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
        ),
      ],
    );
  }

  double _calculateLeftPosition(TourStep step, Size screenSize) {
    double left = step.offset.dx;
    
    // 确保引导内容不超出屏幕
    if (left + 250 > screenSize.width) {
      left = screenSize.width - 250 - 20;
    }
    
    return left;
  }

  double _calculateTopPosition(TourStep step, Size screenSize) {
    double top = step.offset.dy + step.size.height + 16;
    
    // 确保引导内容不超出屏幕
    if (top + 200 > screenSize.height) {
      top = step.offset.dy - 200 - 16;
      if (top < 0) {
        top = 20;
      }
    }
    
    return top;
  }

  void _nextStep() {
    if (_currentStep < widget.steps.length - 1) {
      setState(() {
        _currentStep++;
      });
      if (widget.onStepChanged != null) {
        widget.onStepChanged!(_currentStep);
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      if (widget.onStepChanged != null) {
        widget.onStepChanged!(_currentStep);
      }
    }
  }

  void _completeTour() {
    setState(() {
      _isTourActive = false;
    });
    if (widget.onComplete != null) {
      widget.onComplete!();
    }
  }
}
