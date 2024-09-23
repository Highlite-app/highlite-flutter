import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';

class TagChipButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool selected;

  const TagChipButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // Adjusted height to a more typical value for a chip
      child: ActionChip(
        elevation: 0,
        pressElevation: 0,
        onPressed: onTap ?? () {},
        backgroundColor: onTap == null
            ? ColorConstant.neutral50
            : (selected ? ColorConstant.primary500 : ColorConstant.shade00),
        disabledColor: ColorConstant.neutral50,
        label: Text(
          title,
          style: TextStyle(
            fontSize: TypographyTheme.paragraph_p3,
            color: onTap != null
                ? (selected ? ColorConstant.shade00 : ColorConstant.neutral900)
                : ColorConstant.neutral600,
            fontWeight: FontWeight.w600,
            height: 1.1,
          ),
        ),
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        clipBehavior: Clip.none,
        labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: -3),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          side: BorderSide(
            color: ColorConstant.neutral300,
            width: selected ? 0 : 1,
          ),
        ),
      ),
    );
  }
}
