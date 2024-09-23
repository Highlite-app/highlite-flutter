import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/asset_constants.dart';
import '../../../core/resources/l10n/translation_key.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';
import '../text_field/field_icon.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final double borderRadius;
  final FocusNode focusNode;

  final Function(String)? onTextChanged ;

  const SearchField(
      {super.key,
      required this.controller,
      this.borderRadius = 8.0,
        this.onTextChanged ,
      required this.focusNode});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final normalBorder = OutlineInputBorder(
      borderSide: const BorderSide(width: 0, color: ColorConstant.light2),
      borderRadius: BorderRadius.circular(widget.borderRadius),
    );
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.top,
        textCapitalization: TextCapitalization.words,
        onChanged:widget.onTextChanged ,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(

          prefixIcon: IconButton(
            splashColor: ColorConstant.neutral100,
            onPressed: null,
            alignment: Alignment.centerLeft,
            icon: SvgAsset(
              asset: AssetConstant.searchIcon,
              width: 24,
              height: 24,
              color: ColorConstant.neutral600,
            ),
          ),
          suffixIcon: widget.controller.text.isEmpty
              ? Container(
                  width: 0,
                )
              : FormFieldIcon(
                  icon: AssetConstant.xIcon,
                  onTap: () {
                    setState(() {
                      widget.controller.text = "";
                      widget.onTextChanged!('') ;
                    });
                  },
                ),
          hintText: TranslationKeys.search,
          hintStyle: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p3,
            color: ColorConstant.neutral500,
          ),
          filled: true,
          fillColor: ColorConstant.neutral50,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 12.0,
          ),
          enabledBorder: normalBorder,
          border: normalBorder,
          focusedBorder: normalBorder,
        ),
      ),
    );
  }
}
