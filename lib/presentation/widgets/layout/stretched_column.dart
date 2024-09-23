import 'package:flutter/material.dart';

class StretchedColumn extends StatelessWidget {
  final CrossAxisAlignment contentDirection;
  final Widget child;
  const StretchedColumn({
    super.key,
    required this.contentDirection,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          crossAxisAlignment: contentDirection,
          children: [child],
        ),
      ],
    );
  }
}
