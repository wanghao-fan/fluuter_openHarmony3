import 'package:flutter/material.dart';

class BaseStackLayout extends StatelessWidget {
  final List<Widget> children;
  final Alignment alignment;
  final StackFit fit;
  final Clip clipBehavior;

  const BaseStackLayout({
    Key? key,
    required this.children,
    this.alignment = Alignment.center,
    this.fit = StackFit.loose,
    this.clipBehavior = Clip.hardEdge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: alignment,
        fit: fit,
        clipBehavior: clipBehavior,
        children: children,
      ),
    );
  }
}

class PositionedStackLayout extends StatelessWidget {
  final Widget child;
  final List<Widget> positionedChildren;
  final double? width;
  final double? height;

  const PositionedStackLayout({
    Key? key,
    required this.child,
    required this.positionedChildren,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          child,
          ...positionedChildren,
        ],
      ),
    );
  }
}

class GradientStackLayout extends StatelessWidget {
  final Widget child;
  final List<Color> gradientColors;
  final Alignment begin;
  final Alignment end;
  final double? width;
  final double? height;

  const GradientStackLayout({
    Key? key,
    required this.child,
    required this.gradientColors,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: begin,
          end: end,
        ),
      ),
      child: child,
    );
  }
}

class CardStackLayout extends StatelessWidget {
  final Widget child;
  final Widget? badge;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final double elevation;
  final BorderRadiusGeometry? borderRadius;

  const CardStackLayout({
    Key? key,
    required this.child,
    this.badge,
    this.width,
    this.height,
    this.backgroundColor = Colors.white,
    this.elevation = 2,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Card(
        elevation: elevation,
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
            if (badge != null)
              Positioned(
                top: 0,
                right: 0,
                child: badge!,
              ),
          ],
        ),
      ),
    );
  }
}

class OverlayStackLayout extends StatelessWidget {
  final Widget background;
  final Widget foreground;
  final double opacity;
  final Alignment alignment;
  final double? width;
  final double? height;

  const OverlayStackLayout({
    Key? key,
    required this.background,
    required this.foreground,
    this.opacity = 0.7,
    this.alignment = Alignment.center,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        alignment: alignment,
        fit: StackFit.expand,
        children: [
          background,
          Container(
            color: Colors.black.withOpacity(opacity),
          ),
          foreground,
        ],
      ),
    );
  }
}
