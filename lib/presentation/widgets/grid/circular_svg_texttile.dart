import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../buttons/rippler.dart';
import '../constants/text_style.dart';
import '../svg/bordered_svg.dart';

class CircularSvgTextTile extends StatelessWidget {
  final String asset;
  final String title;
  final VoidCallback? onTap;
  final bool dark;
  const CircularSvgTextTile({
    super.key,
    required this.asset,
    required this.title,
    this.onTap,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Rippler(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BorderedSvg(
              asset: asset,
              assetColor: dark ? ColorConstant.shade00 : ColorConstant.neutral800,
              assetPadding: 24.0,
              size: 20.0,
              backgroundColor:
                  dark ? ColorConstant.neutral800 : ColorConstant.primary100,
              shape: BoxShape.circle,
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style:  BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p4,
                color: ColorConstant.neutral800,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
