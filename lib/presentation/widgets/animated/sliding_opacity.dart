import 'package:flutter/material.dart';

class SlidingOpacity extends StatelessWidget {
  final bool visible;
  final Widget child;
  final int duration;
  const SlidingOpacity(
      {super.key,
      required this.visible,
      required this.child,
      this.duration = 300});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: Duration(milliseconds: duration),
      child: AnimatedSlide(
        offset: visible ? Offset.zero : Offset(Offset.zero.dx, 1),
        duration: Duration(milliseconds: duration),
        child: child,
      ),
    );
  }
}
