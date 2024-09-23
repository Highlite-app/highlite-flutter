import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

class OnboardingDrawerTile extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const OnboardingDrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16.0, right: 16.0),
      visualDensity: const VisualDensity(horizontal: 2, vertical: -2),
      horizontalTitleGap: -2.0,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style:  BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p3,
              color: ColorConstant.neutral800,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
      ),
      leading: SvgAsset(asset: icon, color: ColorConstant.neutral800),
      onTap: () {
     //   TODO: NEED TO ADD LOGIC TO CLOSE THE DRAWER
        //scaffoldState.currentState!.closeDrawer();
        onTap();
      },
    );
  }
}
