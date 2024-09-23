import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/video_feed/profile_action.dart';
import 'package:sizer/sizer.dart';

import 'action_button.dart';

enum VideoFeedType { selfView , feedView}

class FeedActionsContainer extends StatelessWidget {
  final String profile;
  final bool isFollowing;
  final bool enabledFollowButton;
  final bool enabledActionButtons;
  final VoidCallback onTapFollow;
  final VoidCallback onTapProfile;
  final bool isSuperMessaged;
  final VoidCallback onSuperMessage;
  final bool isBookmarked;
  final VoidCallback onBookmark;
  final bool isLiked;
  final VoidCallback onLike;
  final bool isDisliked;
  final VideoFeedType videoFeedType ;
  final VoidCallback onDislike;
  final bool isShared;
  final VoidCallback onShare;
  const FeedActionsContainer({
    super.key,
    required this.profile,
    required this.isFollowing,
    required this.onTapFollow,
    required this.enabledFollowButton,
    required this.enabledActionButtons,
    required this.onTapProfile,
    this.videoFeedType = VideoFeedType.feedView,
    required this.isSuperMessaged,
    required this.onSuperMessage,
    required this.isLiked,
    required this.onLike,
    required this.isDisliked,
    required this.onDislike,
    required this.isBookmarked,
    required this.onBookmark,
    required this.isShared,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 14.w),
      child: Wrap(
        spacing: 20.0,
        runSpacing: 20.0,
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        children: [
         if(videoFeedType == VideoFeedType.feedView)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ProfileAction(
              profile: profile,
              enabledFollowButton: enabledFollowButton,
              isFollowing: isFollowing,
              onTapFollow: onTapFollow,
              onTapProfile: onTapProfile,
            ),
          ),
          if(videoFeedType == VideoFeedType.feedView)
          VideoActionButton(
            asset: AssetConstant.lightingIcon,
            selectedAsset: AssetConstant.lightingSelectedIcon,
            //text: "",
            isSelected: isSuperMessaged,
            onTap: onSuperMessage,
            padding: 0.0,
          ),
          VideoActionButton(
            asset: AssetConstant.bookmarkIconSelected,
            selectedAsset: AssetConstant.bookmarkIconSelectedV2,
            text: "5",
            padding: 3.5,
            isSelected: isBookmarked,
            onTap: onBookmark,
          ),
          VideoActionButton(
            asset: AssetConstant.likeIcon,
            selectedAsset: AssetConstant.likeSelectedIcon ,
            text: '10',
            padding: 0.0,
            isSelected: isLiked,
            onTap: enabledActionButtons ? onLike : null,
          ),
        //   VideoActionButton(
        //     asset: AssetConstant.dislikeIcon,
        //     selectedAsset: AssetConstant.dislikeSelectedIcon,
        // //    text: "",
        //     padding: 0.0,
        //     isSelected: isDisliked,
        //     onTap: enabledActionButtons ? onDislike : null,
        //   ),
          VideoActionButton(
            asset: AssetConstant.sharedIcon,
            selectedAsset: AssetConstant.sharedIcon,
            text: "3",
            isSelected: isShared,
            onTap: onShare,
          ),
        ],
      ),
    );
  }
}
