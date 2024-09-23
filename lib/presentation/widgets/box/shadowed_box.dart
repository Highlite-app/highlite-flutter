import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

class ShadowedBox extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double borderRadius;
  const ShadowedBox({
    super.key,
    required this.child,
    required this.backgroundColor,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        shadows: const [
          BoxShadow(
            color: ColorConstant.shadowColor,
            blurRadius: 10,
            offset: Offset(0, 8),
            spreadRadius: -6,
          ),
          BoxShadow(
            color: ColorConstant.shadowColor,
            blurRadius: 25,
            offset: Offset(0, 20),
            spreadRadius: -5,
          )
        ],
      ),
      child: child,
    );
  }
}
