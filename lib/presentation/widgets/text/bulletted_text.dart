import 'package:flutter/material.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';

class BullettedText extends StatelessWidget {
  final String bullet;
  final String text;
  const BullettedText({super.key, required this.text, this.bullet = "• "});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          bullet,
          style:  BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p4,
            color: ColorConstant.neutral600,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          text,
          style:  BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p4,
            color: ColorConstant.neutral600,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
