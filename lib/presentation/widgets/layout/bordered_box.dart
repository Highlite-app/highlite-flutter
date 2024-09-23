import 'package:flutter/material.dart';

import '../../../core/resources/color_constants.dart';
import '../buttons/rippler.dart';

class BorderedBox extends StatelessWidget {
  final Widget child;
  final double width;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final VoidCallback? onTap;
  final double verticalPadding;
  final double horizontalPadding;
  final Axis direction;
  const BorderedBox({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.direction = Axis.horizontal,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = 12.0,
    this.borderWidth = 1.0,
    this.horizontalPadding = 12.0,
    this.verticalPadding = 12.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget boxChild = Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: child,
    );
    if (onTap != null) {
      boxChild = Rippler(
        onTap: onTap,
        child: boxChild,
      );
    }
    return Container(
      clipBehavior: Clip.hardEdge,
      constraints: BoxConstraints(minWidth: width, maxWidth: width),
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorConstant.transparent,
        border: Border.all(
            width: borderWidth, color: borderColor ?? ColorConstant.neutral100),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      child: boxChild,
    );
  }
}

class BorderedContainer extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double width;
  final double height;
  final Widget child;
  final EdgeInsets padding;
  const BorderedContainer({
    super.key,
    this.backgroundColor = ColorConstant.shade00,
    this.borderColor = ColorConstant.neutral100,
    this.borderWidth = 1,
    this.borderRadius = 12.0,
    this.width = 100,
    this.height = 100,
    this.padding = const EdgeInsets.all(16.0),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(width: borderWidth, color: borderColor),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}
