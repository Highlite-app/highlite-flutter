import 'package:flutter/material.dart';

class OverlayingToastStack extends StatelessWidget {
  const OverlayingToastStack({
    super.key,
    required this.child,
    required this.toasts,
  });

  final Widget child;
  final List<Widget> toasts;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        ...toasts,
      ],
    );
  }
}
