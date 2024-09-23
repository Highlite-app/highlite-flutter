import 'package:flutter/material.dart';

import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

class VideoActionButton extends StatelessWidget {
  final String asset;
  final String selectedAsset;
  final bool isSelected;
  final double padding;
  final VoidCallback? onTap;
  final String? text ;
  const VideoActionButton({
    super.key,
    required this.asset,
    required this.selectedAsset,
    required this.onTap,
    required this.isSelected,
    this.text ,
    this.padding = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: 32,
            height: 32,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: SvgAsset(
                asset: isSelected ? selectedAsset : asset,
                size: 32,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        if(text != null && text !=''  )
        Text(
          text ?? '',
          textAlign: TextAlign.center,
          softWrap: false,
          style:  BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p4,
              color: ColorConstant.shade00,
              fontWeight: FontWeight.w600,
              height: 1.2),
        ),
      ],
    );
  }
}
