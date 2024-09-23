import 'package:flutter/material.dart';

class SizedOpacity extends StatelessWidget {
  final bool visible;
  final Widget child;
  final int duration;
  final double height;
  final double width;
  const SizedOpacity({
    super.key,
    required this.visible,
    required this.child,
    this.duration = 300,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: visible ? height : 0,
      width: visible ? width : 0,
      duration: Duration(milliseconds: duration),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: duration),
        opacity: visible ? 1 : 0,
        child: child,
      ),
    );
  }
}
