import 'package:flutter/material.dart';

import '../../../../core/resources/color_constants.dart';
import '../../../../core/resources/typography_theme.dart';
import '../../constants/text_style.dart';

class MatchHeadline extends StatelessWidget {
  final String message;
  const MatchHeadline({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          message,
          style:  BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p3,
            color: ColorConstant.neutral500,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
