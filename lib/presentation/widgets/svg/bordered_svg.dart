import 'package:flutter/material.dart';

import '../buttons/rippler.dart';
import 'svg_asset.dart';

class RippledBorderedSvg extends StatelessWidget {
  final String asset;
  final Color assetColor;
  final double assetPadding;
  final double size;
  final Color backgroundColor;
  final BoxShape shape;
  final Border? border;
  final VoidCallback? onTap;
  const RippledBorderedSvg({
    super.key,
    required this.asset,
    required this.assetColor,
    required this.assetPadding,
    required this.size,
    required this.backgroundColor,
    required this.shape,
    this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Rippler(
      onTap: onTap,
      child: Container(
        decoration:
            BoxDecoration(color: backgroundColor, shape: shape, border: border),
        child: Padding(
          padding: EdgeInsets.all(assetPadding),
          child: SvgAsset(
            asset: asset,
            color: assetColor,
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}

class BorderedSvg extends StatelessWidget {
  final String asset;
  final Color assetColor;
  final double assetPadding;
  final double size;
  final Color backgroundColor;
  final BoxShape shape;
  final Border? border;
  const BorderedSvg({
    super.key,
    required this.asset,
    required this.assetColor,
    required this.assetPadding,
    required this.size,
    required this.backgroundColor,
    required this.shape,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: shape,
        border: border,
      ),
      child: Padding(
        padding: EdgeInsets.all(assetPadding),
        child: SvgAsset(
          asset: asset,
          color: assetColor,
          width: size,
          height: size,
        ),
      ),
    );
  }
}
