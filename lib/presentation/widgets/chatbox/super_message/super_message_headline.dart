import 'package:flutter/material.dart';
import '../../../../core/resources/asset_constants.dart';
import '../../../../core/resources/color_constants.dart';
import '../../../../core/resources/typography_theme.dart';
import '../../constants/text_style.dart';
import '../../svg/svg_asset.dart';

class SuperMessageHeadline extends StatelessWidget {
  final String message;
  const SuperMessageHeadline({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         SvgAsset(
          asset: AssetConstant.lightingIcon,
          height: 20,
          width: 15,
          color: ColorConstant.neutral500,
        ),
        const SizedBox(
          width: 8.0,
        ),
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
