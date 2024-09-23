import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/rippler.dart';

import '../svg/svg_asset.dart';

class SvgButton extends StatelessWidget {
  final String asset;
  final Color? color;
  final double? size;
  final VoidCallback onTap;
  final double padding;
  final bool isSimpleIcon;
  const SvgButton(
      {super.key,
      required this.asset,
      required this.onTap,
      this.color,
      this.size,
      this.padding = 0,
      this.isSimpleIcon = false});

  @override
  Widget build(BuildContext context) {
    if (isSimpleIcon) {
      return Rippler(
        onTap: onTap,
        child: SvgAsset(
          asset: asset,
          color: color ?? ColorConstant.neutral800,
          size: size,
        ),
      );
    }
    return IconButton(
      alignment: Alignment.center,
      padding: EdgeInsets.all(padding),
      iconSize: size,
      icon: SvgAsset(
        asset: asset,
        color: color ?? ColorConstant.neutral800,
        size: size,
      ),
      onPressed: onTap,
    );
  }
}
