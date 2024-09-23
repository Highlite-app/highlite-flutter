import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../buttons/chip_button.dart';
import '../constants/text_style.dart';

class ActionField extends StatelessWidget {
  final String submitText;
  final String placeholderText;
  final String value;
  final VoidCallback onTap;

  const ActionField({
    super.key,
    required this.submitText,
    required this.placeholderText,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final normalBorder = OutlineInputBorder(
      borderSide: const BorderSide(width: 0, color: ColorConstant.light2),
      borderRadius: BorderRadius.circular(8.0),
    );
    return TextFormField(
      initialValue: value,
      focusNode: AlwaysDisabledFocusNode(),
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.left,
      textCapitalization: TextCapitalization.words,
      maxLines: 1,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      style: BaseTextStyle(
        fontSize: TypographyTheme.paragraph_p3,
        color: ColorConstant.neutral700,
      ),
      decoration: InputDecoration(
        suffix: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: ChipButton(
            onTap: onTap,
            title: submitText,
            style: ChipButtonStyle.neutral,
          ),
        ),
        hintText: placeholderText,
        hintStyle: BaseTextStyle(
          fontSize: TypographyTheme.paragraph_p3,
          color: ColorConstant.neutral500,
        ),
        labelStyle: BaseTextStyle(
          fontSize: TypographyTheme.paragraph_p3,
          color: ColorConstant.neutral500,
        ),
        hintMaxLines: 1,
        filled: true,
        fillColor: ColorConstant.neutral50,
        contentPadding: const EdgeInsets.only(
          top: 0.0,
          left: 16.0,
        ),
        enabledBorder: normalBorder,
        border: normalBorder,
        focusedBorder: normalBorder,
        disabledBorder: normalBorder,
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
