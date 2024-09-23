import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'rippler.dart';

class DashedTile extends StatelessWidget {
  final Color backgroundColor;
  final Color dashColor;

  final Widget child;
  final VoidCallback? onTap;
  const DashedTile(
      {super.key,
      required this.backgroundColor,
      required this.dashColor,
      required this.child,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Rippler(
      onTap: onTap,
      backgroundColor: backgroundColor,
      child: DottedBorder(
        dashPattern: const [7, 7],
        color: dashColor,
        strokeWidth: 2,
        radius: const Radius.circular(2.87),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(2.87),
          ),
          child: child,
        ),
      ),
    );
  }
}
