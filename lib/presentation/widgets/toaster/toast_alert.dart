import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:sizer/sizer.dart';

import '../../../core/resources/typography_theme.dart';
import '../box/shadowed_box.dart';
import '../buttons/rippler.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

enum ToastState {
  warning,
  success,
  normal,
  normalSquare,
  insufficientAlert,
  error;
}

class ToastAlert extends StatelessWidget {
  final String text;
  final String title;
  final String icon;
  final String link;
  final VoidCallback? linkAction;

  final ToastState state;
  final Duration animDuration;
  final bool visible;

  const ToastAlert({
    super.key,
    required this.icon,
    required this.title,
    required this.text,
    required this.state,
    required this.visible,
    required this.link,
    this.linkAction,
    this.animDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    Color textColor, backgroundColor;
    String asset;
    switch (state) {
      case ToastState.warning:
        textColor = ColorConstant.warning600;
        backgroundColor = ColorConstant.warning50;
        asset = AssetConstant.toasterWarningIcon;
        break;
      case ToastState.success:
        textColor = ColorConstant.success700;
        backgroundColor = ColorConstant.success50;
        asset = AssetConstant.toasterSuccessIcon;
        break;
      case ToastState.normal:
        textColor = ColorConstant.neutral800;
        backgroundColor = ColorConstant.shade00;
        asset = AssetConstant.toasterSuccessIcon;
        break;
      case ToastState.error:
        textColor = ColorConstant.destructive700;
        backgroundColor = ColorConstant.destructive50;
        asset = AssetConstant.toasterErrorIcon;
        break;
      case ToastState.normalSquare:
        textColor = ColorConstant.neutral800;
        backgroundColor = ColorConstant.shade00;
        asset = AssetConstant.toasterSuccessIcon;
        break;
      case ToastState.insufficientAlert:
        textColor = ColorConstant.neutral800;
        backgroundColor = ColorConstant.shade00;
        asset = AssetConstant.toasterSuccessIcon;
        break;
    }
    final Widget toast;
    switch (state) {
      case ToastState.normal:
        toast = NormalToast(
          visible: visible,
          animDuration: animDuration,
          backgroundColor: backgroundColor,
          text: text,
          icon: icon,
          textColor: textColor,
        );
        break;
      case ToastState.normalSquare:
        toast = NormalToast(
          visible: visible,
          animDuration: animDuration,
          backgroundColor: backgroundColor,
          text: text,
          icon: icon,
          textColor: textColor,
          borderRadius: 12.0,
        );
        break;
      case ToastState.insufficientAlert:
        toast = InsufficientToast(
          visible: visible,
          animDuration: animDuration,
          backgroundColor: backgroundColor,
          title: title,
          text: text,
          icon: icon,
          link: link,
          linkAction: linkAction,
          textColor: textColor,
          borderRadius: 8.0,
        );
        break;
      default:
        toast = IndicatorToast(
          visible: visible,
          animDuration: animDuration,
          backgroundColor: backgroundColor,
          asset: asset,
          text: text,
          textColor: textColor,
        );
    }
    return SafeArea(
      child: Wrap(
        children: [toast],
      ),
    );
  }
}

class NormalToast extends StatelessWidget {
  final bool visible;
  final Duration animDuration;
  final Color backgroundColor;
  final String text;
  final Color textColor;
  final String icon;
  final double borderRadius;
  final EdgeInsets padding;

  const NormalToast({
    super.key,
    required this.visible,
    required this.animDuration,
    required this.backgroundColor,
    required this.text,
    required this.textColor,
    required this.icon,
    this.borderRadius = 100,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 12.0,
      vertical: 8.0,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: visible ? Offset.zero : Offset(Offset.zero.dx, -1),
      duration: animDuration,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: animDuration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShadowedBox(
                backgroundColor: backgroundColor,
                borderRadius: borderRadius,
                child: Padding(
                  padding: padding,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 90.w),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        if (icon != "")
                          SvgAsset(
                            asset: icon,
                            color: ColorConstant.primary500,
                            size: 32,
                          ),
                        if (icon != "")
                          const SizedBox(
                            width: 4.0,
                          ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 80.w),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: icon != "" ? 1.0 : 0,
                                bottom: icon != "" ? 5.0 : 0),
                            child: Text(
                              text,
                              textAlign: icon != ""
                                  ? TextAlign.left
                                  : TextAlign.center,
                              style: BaseTextStyle(
                                fontSize: TypographyTheme.paragraph_p4,
                                color: textColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IndicatorToast extends StatelessWidget {
  const IndicatorToast({
    super.key,
    required this.visible,
    required this.animDuration,
    required this.backgroundColor,
    required this.asset,
    required this.text,
    required this.textColor,
  });

  final bool visible;
  final Duration animDuration;
  final Color backgroundColor;
  final String asset;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: animDuration,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
        child: ShadowedBox(
          backgroundColor: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: SvgAsset(
                    asset: asset,
                    size: 36,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Flexible(
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: BaseTextStyle(
                      fontSize: TypographyTheme.paragraph_p3,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InsufficientToast extends StatelessWidget {
  final bool visible;
  final Duration animDuration;
  final Color backgroundColor;
  final String icon;
  final String text;
  final String title;
  final String link;
  final VoidCallback? linkAction;
  final Color textColor;
  final double borderRadius;

  const InsufficientToast({
    super.key,
    required this.visible,
    required this.animDuration,
    required this.backgroundColor,
    required this.icon,
    required this.text,
    required this.link,
    this.linkAction,
    required this.title,
    required this.textColor,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: visible ? Offset.zero : Offset(Offset.zero.dx, -1),
      duration: animDuration,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: animDuration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShadowedBox(
                backgroundColor: backgroundColor,
                borderRadius: borderRadius,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 100.w),
                    child: Wrap(
                      spacing: 6.0,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      children: [
                        if (icon != "")
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgAsset(
                              asset: icon,
                              size: 24,
                            ),
                          ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints(minWidth: 75.w, maxWidth: 95.w),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: icon != "" ? 1.0 : 0,
                                bottom: icon != "" ? 5.0 : 0),
                            child: Wrap(
                              spacing: 4.0,
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  title,
                                  textAlign: icon != ""
                                      ? TextAlign.left
                                      : TextAlign.center,
                                  style: BaseTextStyle(
                                    fontSize: TypographyTheme.paragraph_p2,
                                    color: textColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  text,
                                  textAlign: icon != ""
                                      ? TextAlign.left
                                      : TextAlign.center,
                                  style: BaseTextStyle(
                                    fontSize: TypographyTheme.paragraph_p3,
                                    color: textColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Rippler(
                                  onTap: linkAction,
                                  child: Text(
                                    link,
                                    textAlign: icon != ""
                                        ? TextAlign.left
                                        : TextAlign.center,
                                    style: BaseTextStyle(
                                      fontSize: TypographyTheme.paragraph_p3,
                                      color: ColorConstant.primary500,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
