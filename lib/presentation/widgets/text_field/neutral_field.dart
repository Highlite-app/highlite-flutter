import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';

class NeutralField extends StatelessWidget {
  final String placeholderText;
  final FocusNode node;
  final TextEditingController controller;

  const NeutralField({
    super.key,
    required this.node,
    required this.placeholderText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final normalBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 0, color: ColorConstant.neutral50),
      borderRadius: BorderRadius.circular(8.0),
    );
    return Material(
      color: ColorConstant.transparent,
      child: TextFormField(
        focusNode: node,
        controller: controller,
        initialValue: null,
        textAlignVertical: TextAlignVertical.top,
        style: BaseTextStyle(
          fontSize: TypographyTheme.paragraph_p3,
          color: ColorConstant.neutral800,
          fontWeight: FontWeight.w500,
          height: 1.2,
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: placeholderText,
          hintStyle: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p3,
            color: ColorConstant.neutral500,
          ),
          labelStyle: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p1,
            color: ColorConstant.neutral500,
          ),
          hintMaxLines: 1,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          fillColor: ColorConstant.neutral50,
          enabledBorder: normalBorder,
          border: normalBorder,
          focusedBorder: normalBorder,
          disabledBorder: normalBorder,
        ),
      ),
    );
  }
}
