import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

class Rippler extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color? splashColor;
  final ShapeBorder? shape;
  final Clip clipBehavior;
  const Rippler({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor = Colors.transparent,
    this.splashColor,
    this.shape,
    this.clipBehavior = Clip.hardEdge,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: clipBehavior,
      color: backgroundColor,
      shape: shape,
      type: MaterialType.button,
      child: InkWell(
        splashColor: splashColor ?? ColorConstant.neutral50,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
