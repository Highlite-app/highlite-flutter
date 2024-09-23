import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../svg/svg_asset.dart';
class EmptyProfile extends StatelessWidget {
  final double size;
  final double? padding;
  final Color? backgroundColor;
  final bool shouldAllowEmptyProfile;
  const EmptyProfile({
    super.key,
    this.size = 24,
    this.padding,
    this.backgroundColor,
    this.shouldAllowEmptyProfile = true,
  });

  @override
  Widget build(BuildContext context) {
    double pad = size < 50 ? 5 : 30.0;
    if (padding != null) {
      pad = padding!;
    }
    if (!shouldAllowEmptyProfile) {
      pad = 0;
    }
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: ColorConstant.neutral100, width: !shouldAllowEmptyProfile ? 0 : 0.5),
          shape: BoxShape.circle,
          color: backgroundColor ?? ColorConstant.transparent),
      child: Padding(
        padding: EdgeInsets.all(pad),
        child: shouldAllowEmptyProfile
            ? SvgAsset(
                asset: AssetConstant.userIcon,
                size: size,
              )
            : Container(),
      ),
    );
  }
}
