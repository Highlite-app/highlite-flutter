import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../buttons/rippler.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

class PolicyNavigatedTile extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const PolicyNavigatedTile({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Rippler(
      onTap: onTap,
      splashColor: ColorConstant.neutral50,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          children: [
            const SizedBox(width: 5.0),
            Text(
              title,
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p3,
                color: ColorConstant.neutral900,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 8,
                    height: 12,
                    child: SvgAsset(asset: AssetConstant.arrowNextIcon),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}