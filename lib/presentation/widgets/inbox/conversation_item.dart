import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:sizer/sizer.dart';

import '../../../core/resources/asset_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../buttons/rippler.dart';
import '../constants/text_style.dart';
import '../profile/profile_picture.dart';
import '../slidable/slidable_item.dart';
import '../svg/svg_asset.dart';

enum ConversationState {
  read,
  sent,
  delivered;
}

class ConversationItem extends StatelessWidget {
  final String id;
  final String profile;
  final bool superUser;
  final bool seen;
  final bool favorite;
  final bool online;
  final String title;
  final String message;
  final String timestamp;
  final ConversationState state;
  final VoidCallback onTap;
  final Function(String) onSliderTap;
  final List<SlidableActionItem> actionItems;

  const ConversationItem({
    super.key,
    required this.onTap,
    required this.id,
    required this.profile,
    required this.superUser,
    required this.online,
    required this.favorite,
    required this.seen,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.state,
    required this.onSliderTap,
    required this.actionItems,
  });

  @override
  Widget build(BuildContext context) {
    final Widget item = Rippler(
      onTap: onTap,
      clipBehavior: Clip.none,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Row(
          children: [
            ConversationProfile(
              profile: profile,
              superUser: superUser,
              online: online,
            ),
            const SizedBox(width: 12.0),
            ConversationMessageContainer(
              title: title,
              seen: seen,
              favorite: favorite,
              message: message,
            ),
            const Spacer(),
            ConversationTimestamp(
              state: state,
              timestamp: timestamp,
              profile: profile,
            ),
          ],
        ),
      ),
    );
    if (actionItems.isEmpty) {
      return item;
    }
    return SlidableItem(
      id: id,
      actions: actionItems,
      onSelect: onSliderTap,
      child: item,
    );
  }
}

class ConversationProfile extends StatelessWidget {
  final String profile;
  final bool superUser;
  final bool online;

  const ConversationProfile({
    super.key,
    required this.profile,
    required this.superUser,
    required this.online,
  });

  @override
  Widget build(BuildContext context) {
    return ProfilePicture(
      size: 52,
      url: profile,
      emptySize: 52,
      isPremiumUser: superUser,
      padding: 10.0,
      tinySize: 20.0,
      tinyColor: online ? ColorConstant.success500 : ColorConstant.primary500,
      showOnlineIndicator: !superUser && online,
    );
  }
}

class ConversationTimestamp extends StatelessWidget {
  final ConversationState state;
  final String timestamp;
  final String profile;

  const ConversationTimestamp({
    super.key,
    required this.state,
    required this.timestamp,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    String icon = "";
    switch (state) {
      case ConversationState.read:
        icon = "read";
        break;
      case ConversationState.sent:
        icon = "conversation-sent";
        break;
      case ConversationState.delivered:
        icon = "conversation-delivered";
        break;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          timestamp,
          style: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p4,
            color: ColorConstant.neutral900,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8.0),
        icon == "read"
            ? ProfilePicture(
                size: 16,
                url: profile,
                emptySize: 16,
                padding: 2.0,
                tinySize: 20.0,
              )
            : SvgAsset(
                asset: icon,
                size: 16.0,
              ),
      ],
    );
  }
}

class ConversationMessageContainer extends StatelessWidget {
  final String title;
  final bool seen;
  final bool favorite;
  final String message;

  const ConversationMessageContainer({
    super.key,
    required this.title,
    required this.seen,
    required this.favorite,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 55.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p3,
                  color: ColorConstant.neutral900,
                  fontWeight: seen ? FontWeight.w400 : FontWeight.w600,
                ),
              ),
              const SizedBox(
                width: 6.0,
              ),
              if (favorite)
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgAsset(
                      asset: AssetConstant.startIcon,
                      size: 12.0,
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 3.0),
          Text(
            message,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p3,
              color: ColorConstant.neutral900,
              fontWeight: seen ? FontWeight.w400 : FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
