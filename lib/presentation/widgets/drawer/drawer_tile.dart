import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/bordered_svg.dart';

class DarkDrawerTile extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  const DarkDrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16.0, right: 16.0),
      horizontalTitleGap: 16.0,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style:  BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p3,
            color: ColorConstant.neutral800,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      leading: BorderedSvg(
        asset: icon,
        assetColor: ColorConstant.shade00,
        assetPadding: 12,
        size: 24,
        backgroundColor: ColorConstant.neutral800,
        shape: BoxShape.circle,
      ),
      onTap: onTap,
    );
  }
}
