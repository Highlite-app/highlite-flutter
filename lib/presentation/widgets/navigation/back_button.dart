import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../buttons/svg_button.dart';

class BackNavigationButton extends StatelessWidget {
  final NavigatorState navigator;
  final double? size;
  final double padding;
  final VoidCallback? onPop;
  final Color color;
  const BackNavigationButton({
    super.key,
    required this.navigator,
    this.size,
    this.padding = 0,
    this.onPop,
    this.color = ColorConstant.neutral800,
  });

  @override
  Widget build(BuildContext context) {
    if (!navigator.canPop()) {
      return Container();
    }
    return SvgButton(
      asset: AssetConstant.narrowLeftArrowIcon,
      size: size,
      padding: padding,
      color: color,
      onTap: () {
        navigator.pop();
        if (onPop != null) onPop!();
      },
    );
  }
}
