import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';


enum ChipStatus {
  active,
  inactive,
  pending,
  neutral;
}

enum ChipSize {
  normal,
  large;
}

class StatusChip extends StatelessWidget {
  final String icon;
  final String text;
  final ChipStatus status;
  final ChipSize size;

  const StatusChip({
    super.key,
    required this.icon,
    required this.text,
    required this.status,
    this.size = ChipSize.normal,
  });

  @override
  Widget build(BuildContext context) {
    Color background, textColor, borderColor, iconColor;
    switch (status) {
      case ChipStatus.active:
        background = ColorConstant.success100;
        textColor = ColorConstant.success600;
        borderColor = ColorConstant.success300;
        iconColor = ColorConstant.success500;
        break;
      case ChipStatus.inactive:
        background = ColorConstant.warning100;
        textColor = ColorConstant.warning600;
        borderColor = ColorConstant.warning300;
        iconColor = ColorConstant.warning500;
        break;
      case ChipStatus.neutral:
        background = ColorConstant.neutral50;
        textColor = ColorConstant.neutral800;
        borderColor = ColorConstant.neutral200;
        iconColor = ColorConstant.neutral800;
        break;
      case ChipStatus.pending:
        background = ColorConstant.destructive100;
        textColor = ColorConstant.destructive600;
        borderColor = ColorConstant.destructive200;
        iconColor = ColorConstant.destructive800;
        break;
    }
    return Theme(
      data: ThemeData(canvasColor: background),
      child: Chip(
        elevation: 0,
        backgroundColor: background,
        label: Wrap(
          spacing: 4.0,
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SvgAsset(
              asset: icon,
              size: size == ChipSize.normal ? 15 : 20,
              color: iconColor,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        clipBehavior: Clip.none,
        labelPadding: EdgeInsets.symmetric(
          horizontal: size == ChipSize.normal ? 12.0 : 10.0,
          vertical: 0.5,
        ),
        labelStyle: BaseTextStyle(
          fontSize: TypographyTheme.paragraph_p3,
          color: textColor,
          fontWeight: FontWeight.w600,
          height: 1.1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          side: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
      ),
    );
  }
}
