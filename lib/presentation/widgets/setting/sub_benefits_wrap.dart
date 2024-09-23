import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

class SubBenefitsWrap extends StatelessWidget {
  final List<String> benefits;
  const SubBenefitsWrap({super.key, required this.benefits});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: benefits.map((e) => SubBenefits(benefit: e)).toList(),
    );
  }
}

class SubBenefits extends StatelessWidget {
  final String benefit;
  const SubBenefits({
    super.key,
    required this.benefit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         SvgAsset(
          asset: AssetConstant.checkCircleIcon,
          color: ColorConstant.primary500,
          size: 18,
        ),
        const SizedBox(width: 8.0),
        Text(
          benefit,
          style:  BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p3,
              color: ColorConstant.neutral600,
              fontWeight: FontWeight.w500,
              height: 1.1),
        ),
      ],
    );
  }
}
