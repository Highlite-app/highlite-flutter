import 'package:flutter/material.dart';

class WrappedStack extends StatelessWidget {
  final List<Widget> widgets;
  final MainAxisAlignment alignment;
  final Axis direction;
  final double spacing;
  const WrappedStack({
    super.key,
    required this.widgets,
    required this.alignment,
    required this.direction,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return Row(
        mainAxisAlignment: alignment,
        children: [
          Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: widgets,
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: alignment,
        children: [
          Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: widgets,
          ),
        ],
      );
    }
  }
}
