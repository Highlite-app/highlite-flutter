import 'package:flutter/material.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';

enum ChipButtonStyle {
  normal,
  neutral;
}

class ChipButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final ChipButtonStyle style;
  const ChipButton({
    super.key,
    required this.title,
    required this.onTap,
    this.style = ChipButtonStyle.normal,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle;
    switch (style) {
      case ChipButtonStyle.normal:
        raisedButtonStyle = TextButton.styleFrom(
          foregroundColor: ColorConstant.neutral700,
          backgroundColor: ColorConstant.neutral50,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
        );
        break;
      case ChipButtonStyle.neutral:
        raisedButtonStyle = TextButton.styleFrom(
          foregroundColor: ColorConstant.neutral700,
          backgroundColor: ColorConstant.shade00,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape:  RoundedRectangleBorder(
            side: BorderSide(
              color: ColorConstant.neutral200,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
        );
        break;
    }

    Widget button = TextButton(
      style: raisedButtonStyle,
      onPressed: onTap,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style:  BaseTextStyle(
          fontSize: TypographyTheme.paragraph_p3,
          color: ColorConstant.neutral700,
          fontWeight: FontWeight.w600,
          height: 0.8,
        ),
      ),
    );
    return button;
  }
}
