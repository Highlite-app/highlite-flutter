import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../svg/svg_asset.dart';

class FormFieldIcon extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;

  const FormFieldIcon({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: IconButton(
        splashColor: ColorConstant.neutral100,
        onPressed: onTap,
        alignment: Alignment.center,
        icon: SvgAsset(
          asset: icon,
          width: 24,
          height: 24,
          color: ColorConstant.neutral600,
        ),
      ),
    );
  }
}
