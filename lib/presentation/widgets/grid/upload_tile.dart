import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../buttons/dashed_tile.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

class SizedUploadTile extends StatelessWidget {
  final double height;
  final String label;
  final VoidCallback onTap;
  final String icon;
  const SizedUploadTile({
    super.key,
    required this.height,
    required this.label,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: UploadTile(
        icon: icon,
        label: label,
        onTap: onTap,
      ),
    );
  }
}

class UploadTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final String icon;
  const UploadTile({
    super.key,
    required this.onTap,
    required this.label,
    required this.icon,
  });

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
            SvgAsset(
              asset: icon,
              height: 20,
              width: 20,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              label,
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
