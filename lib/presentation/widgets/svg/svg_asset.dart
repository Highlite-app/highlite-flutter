import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgAsset extends StatelessWidget {
  final String asset;
  final double? width;
  final double? height;
  final double? size;
  final Color? color;
  const SvgAsset(
      {super.key,
      required this.asset,
      this.width,
      this.height,
      this.size,
      this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size ?? width,
      height: size ?? height,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}
