import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';

class PagedChip extends StatelessWidget {
  final int selectedIndex;
  final int length;
  const PagedChip({
    super.key,
    required this.selectedIndex,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(canvasColor: ColorConstant.neutral900.withOpacity(0.7)),
      child: Chip(
        elevation: 0,
        backgroundColor: ColorConstant.neutral900.withOpacity(0.7),
        label: Wrap(
          spacing: 4.0,
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "${selectedIndex + 1}/$length",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        clipBehavior: Clip.none,
        labelPadding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 0.5,
        ),
        labelStyle:  BaseTextStyle(
          fontSize: TypographyTheme.paragraph_p3,
          color: ColorConstant.shade00,
          fontWeight: FontWeight.w600,
          height: 1.1,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
      ),
    );
  }
}
