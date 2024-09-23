import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

enum CurveStyle { all, leftOnly, rightOnly }

enum PrimaryButtonStyle { normal, bordered, tertiary, borderedTransparent ,  }

enum PrimaryButtonSize { normal, small, medium, custom  }

enum PrimaryButtonState {
  normal,
  inverted,
  invertedBordered,
  destructive;
}

class ColorState {
  final Color textColor;
  final Color disabledTextColor;
  final Color enabledColor;
  final Color disabledColor;
  final Color borderColor;
  const ColorState({
    required this.textColor,
    required this.disabledTextColor,
    required this.enabledColor,
    required this.disabledColor,
    required this.borderColor,
  });
  factory ColorState.normal() =>  ColorState(
    textColor: ColorConstant.shade00,
    disabledTextColor: ColorConstant.shade00,
    enabledColor: ColorConstant.primary500,
    disabledColor: ColorConstant.primary400,
    borderColor: ColorConstant.primary500,
  );
  factory ColorState.inverted() =>  ColorState(
    textColor: ColorConstant.primary500,
    disabledTextColor: ColorConstant.primary500,
    enabledColor: ColorConstant.primary50,
    disabledColor: ColorConstant.primary50,
    borderColor: ColorConstant.primary100,
  );
  factory ColorState.invertedBordered() =>  ColorState(
    textColor: ColorConstant.primary500,
    disabledTextColor: ColorConstant.primary50,
    enabledColor: ColorConstant.primary50,
    disabledColor: ColorConstant.primary50,
    borderColor: ColorConstant.primary100,
  );
  factory ColorState.destructive() =>  ColorState(
    textColor: ColorConstant.shade00,
    disabledTextColor: ColorConstant.shade00,
    enabledColor: ColorConstant.destructive500,
    disabledColor: ColorConstant.neutral500,
    borderColor: ColorConstant.destructive500,
  );
}

enum ExpandButtonType {
  vertical,
  horizontal;
}

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool autoGrow;
  final bool autoExpand;
  final CurveStyle curveStyle;
  final double borderRadius;
  final PrimaryButtonStyle buttonStyle;
  final PrimaryButtonSize size;
  final PrimaryButtonState state;
  final ExpandButtonType expandType;
  final Color? borderColor;
  final Color? textColor;
  final double borderWidth;
  final String? iconAsset;
  final double? iconSize;
  final Color? iconColor ;
  final double horizontalPadding;
  final double verticalButtonPadding;
  final double horizontalButtonPadding;
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onTap,
    this.autoGrow = true,
    this.autoExpand = false,
    this.curveStyle = CurveStyle.all,
    this.borderRadius = 10,
    this.buttonStyle = PrimaryButtonStyle.normal,
    this.size = PrimaryButtonSize.normal,
    this.state = PrimaryButtonState.normal,
    this.expandType = ExpandButtonType.vertical,
    this.borderColor,
    this.textColor,
    this.borderWidth = 0.2,
    this.iconAsset,
    this.iconSize = 30,
    this.iconColor ,
    this.horizontalPadding = 16,
    this.verticalButtonPadding = 19,
    this.horizontalButtonPadding = 36,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius radius;
    switch (curveStyle) {
      case CurveStyle.all:
        radius = BorderRadius.all(Radius.circular(borderRadius));
        break;
      case CurveStyle.leftOnly:
        radius = BorderRadius.horizontal(left: Radius.circular(borderRadius));
        break;
      case CurveStyle.rightOnly:
        radius = BorderRadius.horizontal(right: Radius.circular(borderRadius));
        break;
    }
    Color textColor = ColorConstant.shade00;
    ColorState colorState = ColorState.normal();
    switch (state) {
      case PrimaryButtonState.normal:
        colorState = ColorState.normal();
        break;
      case PrimaryButtonState.inverted:
        colorState = ColorState.inverted();
        break;
      case PrimaryButtonState.invertedBordered:
        colorState = ColorState.invertedBordered();
        break;
      case PrimaryButtonState.destructive:
        colorState = ColorState.destructive();
        break;

    }

    double paddingHorizontal = 8.0, paddingVertical = 0.0;
    switch (size) {
      case PrimaryButtonSize.normal:
        paddingHorizontal = 36;
        paddingVertical = 16;
        break;
      case PrimaryButtonSize.small:
        paddingHorizontal = 16;
        paddingVertical = 15;
        break;
      case PrimaryButtonSize.medium:
        paddingHorizontal = 16;
        paddingVertical = 10;
        break;
      case PrimaryButtonSize.custom:
        paddingHorizontal = horizontalButtonPadding;
        paddingVertical = verticalButtonPadding;
        break;
    }
    ButtonStyle raisedButtonStyle = TextButton.styleFrom(
      foregroundColor: onTap != null ? textColor : colorState.disabledTextColor,
      backgroundColor:
      onTap != null ? colorState.enabledColor : colorState.disabledColor,
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: radius,
      ),
    );
    if (buttonStyle == PrimaryButtonStyle.bordered) {
      textColor = this.textColor ?? colorState.enabledColor;
      raisedButtonStyle = TextButton.styleFrom(
        foregroundColor: colorState.enabledColor,
        backgroundColor:
        onTap != null ? ColorConstant.neutral50: ColorConstant.primary400,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(
            color: borderColor ?? colorState.enabledColor,
            width: borderWidth,
            style: BorderStyle.solid,
          ),
        ),
      );
    }
    if (buttonStyle == PrimaryButtonStyle.borderedTransparent) {
      textColor = this.textColor ?? colorState.enabledColor;
      raisedButtonStyle = TextButton.styleFrom(
        foregroundColor: colorState.enabledColor,
        backgroundColor:
        onTap != null ? ColorConstant.transparent : ColorConstant.primary400,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(
            color: borderColor ?? colorState.enabledColor,
            width: borderWidth,
            style: BorderStyle.solid,
          ),
        ),
      );
    }

    if (buttonStyle == PrimaryButtonStyle.tertiary) {
      textColor = this.textColor ?? colorState.enabledColor;
      raisedButtonStyle = TextButton.styleFrom(
        foregroundColor: colorState.enabledColor,
        backgroundColor:
        onTap != null ? ColorConstant.shade00 : ColorConstant.primary400,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(
            color: ColorConstant.neutral200,
            width: borderWidth,
            style: BorderStyle.solid,
          ),
        ),
      );
    }
    if (state == PrimaryButtonState.inverted) {
      textColor = colorState.textColor;
      raisedButtonStyle = TextButton.styleFrom(
        foregroundColor:
        onTap != null ? colorState.textColor : colorState.disabledTextColor,
        backgroundColor:
        onTap != null ? colorState.enabledColor : colorState.disabledColor,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(
            color: colorState.borderColor,
            width: borderWidth,
            style: BorderStyle.solid,
          ),
        ),
      );
    }

    if (state == PrimaryButtonState.invertedBordered) {
      textColor = colorState.textColor;
      raisedButtonStyle = TextButton.styleFrom(
        foregroundColor:
        onTap != null ? colorState.textColor : colorState.disabledTextColor,
        backgroundColor:
        onTap != null ? colorState.enabledColor : colorState.disabledColor,
        padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal, vertical: paddingVertical),
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(
            color: colorState.borderColor,
            width: borderWidth,
            style: BorderStyle.solid,
          ),
        ),
      );
    }
    Widget buttonText = Text(
      title,
      style: BaseTextStyle(
          fontSize: size == PrimaryButtonSize.normal
              ? TypographyTheme.paragraph_p3
              : TypographyTheme.paragraph_p2,
          color: textColor,
          height: 1.25),
    );
    Widget button = TextButton(
      style: raisedButtonStyle,
      onPressed: onTap,
      child: (iconAsset != null)
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgAsset(
            asset: iconAsset!,
            color: iconColor ??  ColorConstant.shade00,
            size: iconSize,

          ),
          const SizedBox(
            width: 8.0,
          ),
          buttonText,
        ],
      )
          : buttonText,
    );
    if (autoExpand) {
      if (expandType == ExpandButtonType.vertical) {
        return Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [button],
          ),
        );
      } else {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [button],
          ),
        );
      }
    }
    return autoGrow
        ? Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [button],
      ),
    )
        : button;
  }
}
