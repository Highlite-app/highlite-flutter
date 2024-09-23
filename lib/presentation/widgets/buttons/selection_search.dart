import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import '../../../core/resources/spacing_theme.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

class SelectionSearch extends StatefulWidget {
  final Function(String) onChange;
  final String? hinText ;

  const SelectionSearch({super.key,
    this.hinText ,
    required this.onChange});

  @override
  State<SelectionSearch> createState() => _SelectionSearchState();
}

class _SelectionSearchState extends State<SelectionSearch> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorConstant.neutral50,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 0.5, color: ColorConstant.neutral100),
        ),
        child: TextField(
          autofocus: true,
          keyboardType: TextInputType.text,
          onChanged: (value) => widget.onChange(value),
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hinText?? "Search countries or code",
            hintStyle:  BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p3,
                color: ColorConstant.neutral500,
                fontWeight: FontWeight.w600),
            prefixIcon:
                Align(alignment: Alignment.centerLeft, child: paddedIcon()),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 60,
              maxWidth: 60,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 12.0),
            enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: ColorConstant.neutral50),
            ),
            border:  OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: ColorConstant.neutral50),
            ),
            focusedBorder:  OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: ColorConstant.neutral50),
            ),
            filled: true,
            fillColor: ColorConstant.neutral50,
          ),
        ),
      ),
    );
  }

  Padding paddedIcon() {
    return  const Padding(
      padding: EdgeInsets.only(left: Spacing.spacing_big),
      child: SizedBox(
        width: 24.0,
        height: 24.0,
        child: SvgAsset(
          asset: AssetConstant.searchIcon,
          width: 24,
          height: 24,
          color: ColorConstant.neutral800,
        ),
      ),
    );
  }

  TextField paddedText() {
    return const TextField(
      keyboardType: TextInputType.text,
    );
  }
}
