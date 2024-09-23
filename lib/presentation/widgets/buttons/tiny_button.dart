import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/rippler.dart';

import '../svg/svg_asset.dart';
class TinyButton extends StatelessWidget {
  final Color color;
  final Color splashColor;
  final VoidCallback onTap;
  final String icon;
  final Color iconColor;
  final double iconPadding;
  final double size;
  const TinyButton({
    super.key,
    required this.color,
    required this.splashColor,
    required this.onTap,
    required this.icon,
    required this.iconColor,
    this.iconPadding = 4.0,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Rippler(
      backgroundColor: color,
      splashColor: splashColor,
      shape: const CircleBorder(),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(iconPadding),
        child: SvgAsset(
          width: size,
          height: size,
          asset: icon,
          color: iconColor,
        ),
      ),
    );
  }
}
