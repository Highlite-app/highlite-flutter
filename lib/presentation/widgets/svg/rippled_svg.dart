import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/svg/svg_asset.dart';

import '../buttons/rippler.dart';

class RippledSvg extends StatelessWidget {
  final String asset;
  final Color? color;
  final double? size;
  final VoidCallback onTap;
  final double padding;
  final ShapeBorder shape;
  const RippledSvg(
      {super.key,
      required this.asset,
      required this.onTap,
      this.color,
      this.size,
      this.padding = 0,
      this.shape = const CircleBorder()});

  @override
  Widget build(BuildContext context) {
    return Rippler(
      onTap: onTap,
      shape: shape,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: SvgAsset(
          asset: asset,
          color: color ?? ColorConstant.neutral800,
          size: size,
        ),
      ),
    );
  }
}
