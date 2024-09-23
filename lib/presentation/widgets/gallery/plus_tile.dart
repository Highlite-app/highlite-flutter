import 'package:flutter/material.dart';
import '../../../core/resources/asset_constants.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../buttons/dashed_tile.dart';
import '../constants/text_style.dart';
import '../svg/bordered_svg.dart';

class PlusTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const PlusTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return DashedTile(
      backgroundColor: ColorConstant.primary50,
      dashColor: ColorConstant.primary300,
      onTap: onTap,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             BorderedSvg(
              asset: AssetConstant.plusIcon,
              assetColor: ColorConstant.shade00,
              assetPadding: 8.0,
              size: 20,
              backgroundColor: ColorConstant.primary500,
              shape: BoxShape.circle,
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              title,
              style:  BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p4,
                color: ColorConstant.primary500,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
