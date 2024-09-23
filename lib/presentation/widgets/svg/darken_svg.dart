import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/svg/padded_svg.dart';

import '../../../core/resources/color_constants.dart';
import 'bordered_svg.dart';

class DarkenSvg extends StatelessWidget {
  final String asset;
  final double assetPadding;
  final double size;
  final bool bordered;
  const DarkenSvg({
    super.key,
    required this.asset,
    required this.assetPadding,
    required this.size,
    this.bordered = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!bordered) {
      return PaddedSvg(
        padding: EdgeInsets.all(assetPadding),
        asset: asset,
        size: size,
        color: ColorConstant.neutral800,
      );
    }
    return BorderedSvg(
      asset: asset,
      assetColor: ColorConstant.shade00,
      assetPadding: assetPadding,
      size: size,
      backgroundColor: ColorConstant.neutral800,
      shape: BoxShape.circle,
    );
  }
}

class PaddedDarkenSvg extends StatelessWidget {
  final EdgeInsets padding;
  final String asset;
  final double assetPadding;
  final double size;
  final bool bordered;
  const PaddedDarkenSvg({
    super.key,
    required this.asset,
    required this.assetPadding,
    required this.size,
    this.bordered = false,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: DarkenSvg(
        asset: asset,
        assetPadding: assetPadding,
        size: size,
        bordered: bordered,
      ),
    );
  }
}
