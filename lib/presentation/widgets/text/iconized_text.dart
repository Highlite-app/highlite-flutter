import 'package:flutter/material.dart';

import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

class IconizedText extends StatelessWidget {
  final String icon;
  final Color iconColor;
  final double iconSize;
  final String text;
  final Color textColor;
  final double textSize;
  final FontWeight fontWeight;
  final double spacing;
  final EdgeInsets? padding;

  const IconizedText({
    super.key,
    required this.icon,
    required this.text,
    required this.iconColor,
    required this.iconSize,
    required this.textColor,
    required this.textSize,
    required this.fontWeight,
    this.spacing = 4.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = Row(
      children: [
        SvgAsset(
          asset: icon,
          size: iconSize,
          color: iconColor,
        ),
        SizedBox(
          width: spacing,
        ),
        Text(
          text,
          style: BaseTextStyle(
            color: textColor,
            fontSize: textSize,
            fontWeight: fontWeight,
          ),
        )
      ],
    );
    if (padding != null) {
      return Padding(
        padding: padding!,
        child: child,
      );
    }
    return child;
  }
}
