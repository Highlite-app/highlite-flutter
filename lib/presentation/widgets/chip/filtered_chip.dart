import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';

class CustomFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const CustomFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      showCheckmark: false,
      label: Text(label , style:  BaseTextStyle(fontSize: TypographyTheme.paragraph_p4, fontWeight: FontWeight.w500 ,color: ColorConstant.neutral700 )),
      selected: isSelected,
      onSelected: (bool selected) {
        onSelected(selected);
      },
      backgroundColor: ColorConstant.neutral100,
      selectedColor: ColorConstant.neutral400,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(
          color: isSelected? Colors.transparent:ColorConstant.neutral300
        ),
      ),
    );
  }
}
