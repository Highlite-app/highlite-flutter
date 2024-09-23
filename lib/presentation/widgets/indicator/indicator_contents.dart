import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:sizer/sizer.dart';

import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';
import '../utils/string.dart';

class IndicatorContents extends StatefulWidget {
  final String placeholder;
  final double progress;
  final int millis;
  final VoidCallback onClose;
  const IndicatorContents(
      {super.key,
      required this.placeholder,
      required this.progress,
      required this.millis,
      required this.onClose});

  @override
  State<IndicatorContents> createState() => _IndicatorContentsState();
}

class _IndicatorContentsState extends State<IndicatorContents> {
  @override
  Widget build(BuildContext context) {
    final width = 100.w;
    return Row(
      children: [
        uploadIcon(),
        uploadContents(width),
        if (widget.progress == 100)
          IconButton(
            splashColor: ColorConstant.neutral100,
            onPressed: widget.onClose,
            icon: xIcon(),
          ),
      ],
    );
  }

  Widget uploadIcon() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 22.0, right: 6.0),
      child: SvgAsset(
        asset: (widget.progress == 100) ? AssetConstant.checkCircleIcon : AssetConstant.uploadSelectedIcon,
        width: 32,
        height: 32,
      ),
    );
  }

  Widget xIcon() {
    return const SvgAsset(
      asset: AssetConstant.circleIcon,
      width: 32,
      height: 32,
    );
  }

  Padding uploadContents(double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.placeholder,
            style:  BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p3,
              color: ColorConstant.neutral800,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${(widget.progress).toInt()}%",
                style:  BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p5,
                  color: ColorConstant.neutral600,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 3),
              if (widget.progress < 100)
                 Text(
                  "•",
                  style: BaseTextStyle(
                    fontSize: TypographyTheme.paragraph_p5,
                    color: ColorConstant.neutral500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              const SizedBox(width: 3),
              if (widget.progress < 100)
                Text(
                  "${formatBytes(widget.millis, 1)} remaining",
                  style:  BaseTextStyle(
                    fontSize: TypographyTheme.paragraph_p5,
                    color: ColorConstant.neutral600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            width: width * 0.56,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: ColorConstant.shade00,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              tween: Tween<double>(
                begin: 0,
                end: widget.progress * 0.01,
              ),
              builder: (context, value, _) => LinearProgressIndicator(
                value: value,
                valueColor:
                     AlwaysStoppedAnimation<Color>(ColorConstant.primary500),
                backgroundColor: ColorConstant.shade00,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
