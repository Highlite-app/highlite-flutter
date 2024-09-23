import 'package:flutter/material.dart';
import '../../../core/resources/color_constants.dart';
import 'rippler.dart';
import '../../../core/resources/spacing_theme.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';

class SelectionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool capitalize;
  final bool rowView;
  final String? icon;
  final bool isFlagIcon;
  const SelectionButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.capitalize,
    required this.rowView,
    this.icon,
    this.isFlagIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Rippler(
      backgroundColor: ColorConstant.neutral50,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 0.5, color: ColorConstant.neutral100),
        ),
        child: Row(
          mainAxisAlignment:
              rowView ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            if (icon != null) paddedIcon(),
            paddedText(),
          ],
        ),
      ),
    );
  }

  Padding paddedIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: Spacing.spacing_big),
      child: SizedBox(
          width: 24.0,
          height: 24.0,
          child: isFlagIcon
              ? Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                    image: DecorationImage(
                      image: NetworkImage(headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                      }, "https://flagsapi.com/$icon/flat/64.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                )
              : SvgAsset(
                  asset: icon!,
                  width: 24,
                  height: 24,
                )),
    );
  }

  Padding paddedText() {
    return Padding(
      padding: rowView
          ? const EdgeInsets.symmetric(
              vertical: Spacing.spacing_sm, horizontal: Spacing.spacing_md)
          : const EdgeInsets.symmetric(vertical: 25.0),
      child: Text(
        capitalize
            ? text.toUpperCase()
            : (text.length > 36)
                ? "${text.substring(0, 36)}..."
                : text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style:  BaseTextStyle(
          fontSize: TypographyTheme.paragraph_p2,
          color: ColorConstant.neutral800,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
