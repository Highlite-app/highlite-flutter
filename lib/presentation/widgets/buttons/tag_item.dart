import 'package:flutter/material.dart';

import '../../../core/resources/asset_constants.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';
import 'rippler.dart';

enum TagStatus {
  normal,
  neutral,
  success,
  successLight,
  error,
  info;
}

enum TagSize {
  tiny,
  small,
  medium;
}

class Tag {
  final String title;
  final TagStatus status;
  final bool enabledPlus;
  final bool enabledDelete;
  final bool enabledSelect;
  final TagSize size;
  const Tag(
      {required this.title,
      this.status = TagStatus.normal,
      this.enabledPlus = false,
      this.enabledDelete = false,
      this.enabledSelect = false,
      this.size = TagSize.small});
}

class TagWrap {
  final List<Tag> wrappedTags;
  final Axis axis;
  const TagWrap({required this.wrappedTags, this.axis = Axis.horizontal});
}

class WrapTag extends StatelessWidget {
  final TagWrap group;
  final double spacing;
  final double runSpacing;
  final Function(Tag)? onTapTag;
  const WrapTag(
      {super.key,
      required this.group,
      this.onTapTag,
      this.spacing = 8.0,
      this.runSpacing = -4.0});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: spacing,
      runSpacing: runSpacing,
      direction: group.axis,
      children: group.wrappedTags
          .map(
            (tag) =>

                /*Chip(
              elevation: 0,
              visualDensity: VisualDensity.standard,
              backgroundColor: ColorConstant.primary100,
              label: Wrap(
                direction: Axis.horizontal,
                spacing: 8.0,
                children: [
                  Text(tag.title),
                ],
              ),
              labelStyle: BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p4,
                  color: ColorConstant.neutral900 ,
                  fontWeight: FontWeight.w600,
                  height: 1.1
              ),

            ),*/


                TagItem(
              tag: tag,
              onTap: (onTapTag != null) ? () => onTapTag!(tag) : null,
            ),
          )
          .toList(),
    );
  }
}

class TagItem extends StatelessWidget {
  final Tag tag;
  final VoidCallback? onTap;
  const TagItem({
    super.key,
    required this.tag,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color background;
    Color textColor;
    switch (tag.status) {
      case TagStatus.normal:
        background = ColorConstant.shade00;
        textColor = ColorConstant.neutral900;
        break;
      case TagStatus.neutral:
        background = ColorConstant.neutral50;
        textColor = ColorConstant.neutral800;
        break;
      case TagStatus.success:
        background = ColorConstant.success100;
        textColor = ColorConstant.success800;
        break;
      case TagStatus.info:
        background = ColorConstant.primary100;
        textColor = ColorConstant.neutral900;
        break;
      case TagStatus.successLight:
        background = ColorConstant.success500;
        textColor = ColorConstant.shade00;
        break;
      case TagStatus.error:
        background = ColorConstant.destructive50;
        textColor = ColorConstant.destructive500;
        break;
    }
    if (tag.enabledPlus || tag.enabledDelete || tag.enabledSelect) {
      return _actionChip(background, textColor);
    }
    return _normalChip(background, textColor);

    // return Chip(
    //   elevation: 0,
    //   visualDensity: VisualDensity.standard,
    //   backgroundColor: ColorConstant.primary100,
    //   label: Wrap(
    //     direction: Axis.horizontal,
    //     spacing: 8.0,
    //     children: [
    //       Text(tag.title),
    //     ],
    //   ),
    //   labelStyle: BaseTextStyle(
    //       fontSize: TypographyTheme.paragraph_p4,
    //       color: ColorConstant.neutral900 ,
    //       fontWeight: FontWeight.w600,
    //       height: 1.1
    //   ),
    //
    // );
  }

  Widget _normalChip(Color background, Color textColor) {
    double fontSize = tag.size == TagSize.small
        ? TypographyTheme.paragraph_p4
        : TypographyTheme.paragraph_p3;
    if (tag.size == TagSize.tiny) {
      fontSize = TypographyTheme.paragraph_p5;
    }
    return IntrinsicHeight(
      child: Chip(
        elevation: 0,
        visualDensity: VisualDensity.standard,
        backgroundColor: background,
        label: Wrap(
          spacing: 8.0,
          direction: Axis.horizontal,
          children: [
            Text(
              tag.title,
              textAlign: TextAlign.center,
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p5 ,
                fontWeight: FontWeight.w600 ,
                letterSpacing: 0,
                color: textColor
              ),
      
            ),
            if (tag.enabledPlus)
              const Padding(
                padding: EdgeInsets.all(1.0),
                child: SvgAsset(
                  asset: AssetConstant.plusIcon,
                ),
              ),
            if (tag.enabledDelete)
              const Padding(
                padding: EdgeInsets.all(1.0),
                child: SvgAsset(
                  asset: AssetConstant.xIcon,
                ),
              ),
          ],
        ),
        clipBehavior: Clip.none,
        labelStyle: BaseTextStyle(
          fontSize: fontSize,
          color: textColor,
          fontWeight: FontWeight.w600,
          height: 1.1,
        ),
        labelPadding: EdgeInsets.symmetric(
            horizontal: tag.size == TagSize.tiny ? 4.0 : 4.0,
        //    vertical: tag.size == TagSize.tiny ? -5 : -3.0
          ),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          side: BorderSide(
            color: tag.status != TagStatus.normal
                ? background
                : ColorConstant.neutral300,
            width: tag.status == TagStatus.normal ? 0.5 : 0,
          ),
        ),
      ),
    );
  }

  Widget _actionChip(Color background, Color textColor) {
    double fontSize = tag.size == TagSize.small
        ? TypographyTheme.paragraph_p4
        : TypographyTheme.paragraph_p3;
    if (tag.size == TagSize.tiny) {
      fontSize = TypographyTheme.paragraph_p5;
    }
    double paddingHorizontal = 8.0, paddingVertical = 0.0;
    switch (tag.size) {
      case TagSize.tiny:
        paddingHorizontal = 4.0;
        paddingVertical = -5.0;
        break;
      case TagSize.small:
        paddingHorizontal = 4.0;
        paddingVertical = -5.0;
        break;
      case TagSize.medium:
        paddingHorizontal = 10.0;
        paddingVertical = 0.0;
        break;
    }

    return Rippler(
      backgroundColor: Colors.transparent,
      splashColor: ColorConstant.primary500,
      child: Theme(
        data: ThemeData(canvasColor: background),
        child: ActionChip(
          onPressed: onTap,
          elevation: 0,
          pressElevation: 0,
          backgroundColor: Colors.transparent,
          disabledColor: Colors.transparent,
          surfaceTintColor: background,
          label: Wrap(
            spacing: 4.0,
            direction: Axis.horizontal,
            children: [
              Text(
                tag.title,
                textAlign: TextAlign.center,
              ),
              if (tag.enabledPlus)
                const Padding(
                  padding: EdgeInsets.all(0.0),
                  child: SvgAsset(
                    asset: AssetConstant.plusIcon,
                  ),
                ),
              if (tag.enabledDelete)
                const Padding(
                  padding: EdgeInsets.all(0.0),
                  child: SvgAsset(
                    asset: AssetConstant.xIcon,
                  ),
                ),
            ],
          ),
          clipBehavior: Clip.none,
          labelStyle: BaseTextStyle(
            fontSize: fontSize,
            color: textColor,
            fontWeight: FontWeight.w600,
            height: 1.1,
          ),
          labelPadding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal,
            vertical: paddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            side: BorderSide(
              color: tag.status != TagStatus.normal
                  ? background
                  : ColorConstant.neutral300,
              width: tag.status == TagStatus.normal ? 0.5 : 0,
            ),
          ),
        ),
      ),
    );
  }
}
