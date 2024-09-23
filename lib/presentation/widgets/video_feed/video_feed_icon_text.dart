import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:sizer/sizer.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

class VideoFeedIconText extends StatelessWidget {
  final String icon;
  final String text;
  final double iconSize;
  final double spacing;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets iconPadding;
  const VideoFeedIconText({
    super.key,
    required this.icon,
    required this.text,
    this.iconSize = 15,
    this.spacing = 10,
    required this.fontSize,
    this.fontWeight = FontWeight.w500,
    this.iconPadding = const EdgeInsets.all(0.0),
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 75.w),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: iconPadding,
            child: SvgAsset(asset: icon, color: ColorConstant.shade00, size: iconSize),
          ),
          SizedBox(width: spacing),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 65.w),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: BaseTextStyle(
                fontSize: fontSize,
                color: ColorConstant.neutral50,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
