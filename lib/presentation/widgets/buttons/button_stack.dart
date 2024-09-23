import 'package:flutter/material.dart';

import '../layout/wrap_stack.dart';

class ButtonStack extends StatelessWidget {
  final List<Widget> widgets;
  final MainAxisAlignment alignment;
  final Axis direction;
  final EdgeInsets padding;
  final double spacing;
  const ButtonStack({
    super.key,
    required this.widgets,
    required this.alignment,
    required this.direction,
    this.padding = const EdgeInsets.only(top: 8.0, right: 6.0),
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: WrappedStack(
        widgets: widgets,
        alignment: alignment,
        direction: direction,
        spacing: spacing,
      ),
    );
  }
}
