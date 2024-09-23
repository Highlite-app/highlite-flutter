import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:sizer/sizer.dart';
import '../../../core/resources/typography_theme.dart';
import '../../../data/models/feed/feed_item.dart';
import '../../../data/models/onboarding/onboarding_data.dart';
import '../buttons/tag_item.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';
import 'feed_content.dart';

class CandidateInfo extends StatelessWidget {
  final VoidCallback onInfo;
  final FeedItem feed;
  const CandidateInfo({super.key, required this.onInfo, required this.feed});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 75.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (feed.user.userType == UserType.company) const HiringTag(),
          if (feed.user.getTitle() != "")
            Text(
              feed.user.getTitle(),
              style:  BaseTextStyle(
                fontSize: TypographyTheme.heading_H4_small,
                color: ColorConstant.shade00,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(height: 2),
          Text(
            feed.user.getName(),
            style:  BaseTextStyle(
              fontSize: TypographyTheme.heading_H5_small,
              color: ColorConstant.shade00,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          VideoFeedIconText(
            icon: "location-01",
            // text: feed.user.getLocation() + " (${feed.user.workType})",
            text: feed.user.getLocation(),
            iconSize: 20,
            spacing: 10,
            fontSize: TypographyTheme.paragraph_p2,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 5),
          VideoFeedIconText(
              icon: AssetConstant.currencyDollarIcon,
              text: feed.user.getRate(),
              spacing: 15,
              fontSize: TypographyTheme.paragraph_p3),
          const SizedBox(height: 5),
          // VideoFeedIconText(
          //     icon: "eye-01",
          //     text: "${feed.seenTotal} views",
          //     fontSize: TypographyTheme.paragraph_p3),
          // const SizedBox(height: 5),
          VideoFeedIconText(
              icon: AssetConstant.briefCaseIcon,
              text: feed.user.workType,
              fontSize: TypographyTheme.paragraph_p3),
          const SizedBox(height: 5),
          CandidateTags(tags: feed.user.skills.take(3).toList())
        ],
      ),
    );
  }
}

class VideoFeedIconText extends StatelessWidget {
  final String icon;
  final String text;
  final double iconSize;
  final double spacing;
  final double fontSize;
  final FontWeight fontWeight;
  const VideoFeedIconText({
    super.key,
    required this.icon,
    required this.text,
    this.iconSize = 15,
    this.spacing = 10,
    required this.fontSize,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 75.w),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgAsset(asset: icon, color: ColorConstant.shade00, size: iconSize),
          SizedBox(width: spacing),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 65.w),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: BaseTextStyle(
                fontSize: fontSize,
                color: ColorConstant.neutral50,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CandidateTags extends StatelessWidget {
  final List<String> tags;
  const CandidateTags({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 75.w),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: -4.0,
        runSpacing: 1.0,
        direction: Axis.horizontal,
        children: [
          WrapTag(
            group: TagWrap(
              wrappedTags: tags
                  .map(
                    (display) => Tag(
                  title: display,
                  status: TagStatus.normal,
                  size: TagSize.small,
                ),
              )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
