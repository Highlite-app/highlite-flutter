import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/video_feed/tags_section.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/video_feed/video_feed_icon_text.dart';
import 'package:sizer/sizer.dart';

import '../../../core/resources/typography_theme.dart';
import '../buttons/tag_item.dart';
import '../constants/text_style.dart';

class FeedContent extends StatelessWidget {
  final String title;
  final String name;
  final String location;
  final String salary;
  final String jobFlexibility;
  final List<String> skills;
  final bool hiringTag;
  const FeedContent({
    super.key,
    required this.title,
    required this.name,
    required this.location,
    required this.salary,
    required this.jobFlexibility,
    required this.skills,
    required this.hiringTag,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 65.w),
      child: Wrap(
        spacing: 2.0,
        runSpacing: 2.0,
        direction: Axis.vertical,
        children: [
          if (hiringTag) const HiringTag(),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 65.w),
            child: Text(
              title,
              overflow: TextOverflow.fade,
              style:  BaseTextStyle(
                fontSize: TypographyTheme.heading_H5,
                color: ColorConstant.shade00,
                letterSpacing: -1,
                fontWeight: FontWeight.w700,
                height: 1.0,
              ),
            ),
          ),
          Text(
            name,
            style:  BaseTextStyle(
              fontSize: TypographyTheme.heading_H6,
              color: ColorConstant.shade00,
              fontWeight: FontWeight.w700,
            ),
          ),
          VideoFeedIconText(
            icon: AssetConstant.locationIcon,
            text: location,
            iconSize: 20,
            spacing: 4,
            fontSize: TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w600,
            iconPadding: const EdgeInsets.symmetric(horizontal: 1.67),
          ),
          VideoFeedIconText(
            icon: AssetConstant.currencyDollarIcon,
            text: salary,
            spacing: 4,
            iconSize: 20,
            fontSize: TypographyTheme.paragraph_p2,
            fontWeight: FontWeight.w600,
          ),
          VideoFeedIconText(
            icon: AssetConstant.briefCaseIcon,
            text: jobFlexibility,
            iconSize: 20,
            spacing: 4,
            fontSize: TypographyTheme.paragraph_p2,
            fontWeight: FontWeight.w600,
          ),
          TagsSection(
            tags: skills,
          ),
        ],
      ),
    );
  }
}

class HiringTag extends StatelessWidget {
  const HiringTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 0,
          runSpacing: 0,
          direction: Axis.horizontal,
          children: [
            WrapTag(
              spacing: 0,
              runSpacing: 0,
              group: TagWrap(
                wrappedTags: [
                  Tag(
                    title: TranslationKeys.hiring.toUpperCase(),
                    status: TagStatus.successLight,
                    size: TagSize.small,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
