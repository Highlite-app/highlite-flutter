import 'package:flutter/material.dart';
import '../../../core/resources/color_constants.dart';
import 'primary_button.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

enum CapsuleButtonType {
  primary,
  neutral,
  bordered,
  destructive;
}

enum CapsuleButtonSize {
  small,
  normal,
  large,
  xlarge;
}

class CapsuleButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool bordered;
  final bool autoGrow;
  final CapsuleButtonType type;
  final CapsuleButtonSize size;
  final bool isHorizontal;
  final bool autoExpand;
  final ExpandButtonType expandType;
  final String? iconAsset;
  const CapsuleButton({
    super.key,
    required this.title,
    this.bordered = false,
    required this.onTap,
    this.autoGrow = true,
    this.type = CapsuleButtonType.primary,
    this.size = CapsuleButtonSize.normal,
    this.isHorizontal = false,
    this.autoExpand = false,
    this.expandType = ExpandButtonType.horizontal,
    this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding =
        const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    double? width = 100;
    double? fontSize = TypographyTheme.paragraph_p4;
    switch (size) {
      case CapsuleButtonSize.xlarge:
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
        width = null;
        fontSize = TypographyTheme.paragraph_p3;
        break;
      case CapsuleButtonSize.normal:
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        width = 100;
        fontSize = TypographyTheme.paragraph_p4;
        break;
      case CapsuleButtonSize.small:
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
        width = 80;
        fontSize = TypographyTheme.paragraph_p3;
        break;
      case CapsuleButtonSize.large:
        padding = const EdgeInsets.symmetric(horizontal: 30.5, vertical: 15);
        width = null;
        fontSize = TypographyTheme.paragraph_p3;
        break;
    }
    Color fontColor = ColorConstant.shade00;
    Color buttonColor = ColorConstant.primary500;
    Color disabledColor = ColorConstant.primary400;
    switch (type) {
      case CapsuleButtonType.primary:
        fontColor = ColorConstant.shade00;
        buttonColor = ColorConstant.primary500;
        disabledColor = ColorConstant.primary400;
        break;
      case CapsuleButtonType.neutral:
        fontColor = ColorConstant.neutral900;
        buttonColor = ColorConstant.neutral100;
        disabledColor = ColorConstant.neutral50;
        break;
      case CapsuleButtonType.bordered:
        fontColor = ColorConstant.shade00;
        buttonColor = ColorConstant.primary500;
        disabledColor = ColorConstant.primary400;
        break;
      case CapsuleButtonType.destructive:
        fontColor = ColorConstant.shade00;
        buttonColor = ColorConstant.destructive500;
        disabledColor = ColorConstant.destructive400;
        break;
    }

    final ButtonStyle raisedButtonStyle = TextButton.styleFrom(
      foregroundColor: bordered ? ColorConstant.neutral900 : fontColor,
      backgroundColor: onTap != null
          ? (bordered ? ColorConstant.shade00 : buttonColor)
          : (bordered ? ColorConstant.shade00 : disabledColor),
      padding: padding,
      shape:  RoundedRectangleBorder(
        side: BorderSide(
          color: ColorConstant.neutral300,
          width: 0.5,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
      ),
    );

    Widget text = Text(
      title,
      textAlign: TextAlign.center,
      style: BaseTextStyle(
        fontSize: fontSize,
        color: bordered
            ? (onTap != null
                ? ColorConstant.neutral900
                : ColorConstant.neutral900.withOpacity(0.2))
            : fontColor,
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
    );
    if (iconAsset != null) {
      text = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgAsset(
            asset: iconAsset!,
            color: bordered
                ? (onTap != null
                    ? ColorConstant.neutral900
                    : ColorConstant.neutral900.withOpacity(0.2))
                : fontColor,
            size: 20,
          ),
          const SizedBox(
            width: 8.0,
          ),
          text,
        ],
      );
    }
    Widget button = TextButton(
      style: raisedButtonStyle,
      onPressed: onTap,
      child: width != null
          ? SizedBox(
              width: width,
              child: text,
            )
          : text,
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
    if (isHorizontal) {
      return autoGrow
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [button],
              ),
            )
          : button;
    } else {
      return autoGrow
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [button],
              ),
            )
          : button;
    }
  }
}
