import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';
import 'action_field.dart';

class PrimaryFieldContainer extends StatelessWidget {
  final List<Widget> children;

  const PrimaryFieldContainer({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.primary50,
        border: Border.all(width: 1, color: ColorConstant.primary100),
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class PrimaryField extends StatelessWidget {
  final String? label;
  final String placeholderText;
  final FocusNode focus;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final List<TextInputFormatter>? formatter;
  final bool editable;
  final bool topBorder;
  final VoidCallback? onTap;
  final Widget? prefix;

  const PrimaryField({
    super.key,
    this.label,
    required this.placeholderText,
    required this.focus,
    required this.controller,
    this.textCapitalization = TextCapitalization.words,
    this.keyboardType,
    this.inputAction,
    this.formatter,
    this.editable = true,
    this.topBorder = false,
    this.onTap,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    final normalBorder = OutlineInputBorder(
      borderSide: const BorderSide(width: 0, color: ColorConstant.light2),
      borderRadius: BorderRadius.circular(8.0),
    );
    return Container(
      decoration: topBorder
          ? BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: ColorConstant.primary100,
                ),
              ),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 12.0, left: 12.0, right: 12.0, bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label != null)
              Text(
                label!,
                style: BaseTextStyle(
                  color: ColorConstant.neutral600,
                  fontSize: TypographyTheme.paragraph_p4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            TextFormField(
              focusNode: editable ? focus : AlwaysDisabledFocusNode(),
              controller: controller,
              initialValue: null,
              textInputAction: inputAction,
              keyboardType: keyboardType,
              textCapitalization: textCapitalization,
              textAlignVertical: TextAlignVertical.top,
              inputFormatters: formatter ?? [],
              onTap: onTap ?? () {},
              style: BaseTextStyle(
                fontSize: editable
                    ? TypographyTheme.paragraph_p1
                    : TypographyTheme.paragraph_p3,
                color: ColorConstant.neutral800,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: editable
                    ? null
                    : IconButton(
                        onPressed: () {},
                        icon: const SvgAsset(
                          asset: AssetConstant.chevronDownIcon,
                          color: ColorConstant.neutral800,
                          size: 24,
                        ),
                      ),
                prefixIcon: prefix != null ? prefix! : null,
                hintText: placeholderText,
                hintStyle: BaseTextStyle(
                  fontSize: editable
                      ? TypographyTheme.paragraph_p1
                      : TypographyTheme.paragraph_p3,
                  color: editable
                      ? ColorConstant.primary100
                      : ColorConstant.neutral800,
                ),
                labelStyle: BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p1,
                  color: ColorConstant.primary100,
                ),
                hintMaxLines: 1,
                filled: true,
                contentPadding: const EdgeInsets.only(top: 12.0),
                fillColor: ColorConstant.primary50,
                enabledBorder: normalBorder,
                border: normalBorder,
                focusedBorder: normalBorder,
                disabledBorder: normalBorder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
