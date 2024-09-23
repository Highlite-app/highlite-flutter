import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../buttons/rippler.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

class OverlayActionButton extends StatelessWidget {
  final String asset;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  const OverlayActionButton(
      {super.key,
      required this.text,
      required this.asset,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          width: 80,
          height: 80,
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: ColorConstant.neutral100, width: 1),
          ),
          child: Rippler(
            onTap: onTap,
            backgroundColor:
                isSelected ? ColorConstant.primary500 : Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SvgAsset(
                asset: asset,
                width: 36,
                height: 36,
                color: isSelected ? ColorConstant.shade00 : ColorConstant.neutral800,
              ),
            ),
          ),
        ),
        Text(
          text,
          style:  BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p4,
            color: ColorConstant.primary900,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
