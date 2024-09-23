import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';

class DefaultButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool plain;
  final bool autoGrow;
  final bool hasErrors;
  const DefaultButton({
    super.key,
    required this.title,
    this.plain = true,
    required this.onTap,
    this.autoGrow = false,
    this.hasErrors = false,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = TextButton.styleFrom(
      foregroundColor: plain ? ColorConstant.neutral900 : ColorConstant.shade00,
      backgroundColor: onTap != null
          ? (plain ? ColorConstant.transparent : ColorConstant.primary500)
          : (plain ? ColorConstant.transparent : ColorConstant.primary400),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
    );
    Widget button = TextButton(
      style: raisedButtonStyle,
      onPressed: onTap,
      child: Text(
        title,
        style: BaseTextStyle(
          fontSize: TypographyTheme.paragraph_p3,
          color: plain ? ColorConstant.neutral900 : ColorConstant.shade00,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
    return autoGrow
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [button],
            ),
          )
        : button;
  }
}
