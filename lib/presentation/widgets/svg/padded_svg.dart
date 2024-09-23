import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/svg/svg_asset.dart';

class PaddedSvg extends StatelessWidget {
  final String asset;
  final EdgeInsets padding;
  final double size;
  final Color color;
  const PaddedSvg({
    super.key,
    required this.size,
    required this.asset,
    required this.padding,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SvgAsset(
        asset: asset,
        width: size,
        height: size,
        color: color,
      ),
    );
  }
}
