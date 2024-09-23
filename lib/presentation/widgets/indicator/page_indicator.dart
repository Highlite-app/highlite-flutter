import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

enum PageIndicatorSize {
  small,
  normal;
}

class PageIndicator extends StatelessWidget {
  final bool lightThemed;
  final bool isActive;
  final Color? activeColor;
  final Color? inactiveColor;
  final PageIndicatorSize size;
  const PageIndicator({
    super.key,
    required this.lightThemed,
    required this.isActive,
    this.activeColor,
    this.inactiveColor,
    this.size = PageIndicatorSize.normal,
  });

  @override
  Widget build(BuildContext context) {
    Color activeColor =
        (lightThemed ? ColorConstant.primary500 : ColorConstant.shade00);
    Color inactiveColor =
        (lightThemed ? ColorConstant.primary100 : ColorConstant.primary400);
    if (this.activeColor != null) {
      activeColor = this.activeColor!;
    }
    if (this.inactiveColor != null) {
      inactiveColor = this.inactiveColor!;
    }
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(right: 4.0),
        height: size == PageIndicatorSize.normal ? 12 : 6,
        width: size == PageIndicatorSize.normal ? 12 : 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? activeColor : inactiveColor,
        ),
      ),
    );
  }
}
