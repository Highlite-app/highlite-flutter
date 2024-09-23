import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/video_feed/video_item.dart';
import 'package:video_player/video_player.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import 'actions_container.dart';
import 'content_container.dart';
import 'feed_content.dart';

class SelfVideoFeedContents {

  final String title;
  final String name;
  final String description ;
  const SelfVideoFeedContents({
    required this.title,
    required this.name,
    required this.description,

  });
}

class SelfVideoFeedContentState {
  final bool isFollowing;
  final bool enabledFollowButton;
  final bool isSuperMessaged;
  final bool isBookmarked;
  final bool isLiked;
  final bool isDisliked;
  final bool isShared;
  final bool enabledActionButtons;
  const SelfVideoFeedContentState({
    required this.isFollowing,
    required this.enabledFollowButton,
    required this.enabledActionButtons,
    required this.isSuperMessaged,
    required this.isBookmarked,
    required this.isLiked,
    required this.isDisliked,
    required this.isShared,
  });
}

class SelfVideoFeed extends StatelessWidget {
  final VideoPlayerController controller;
  final ImageProvider imageProvider;
  final SelfVideoFeedContents contents;
  final SelfVideoFeedContentState state;

  const SelfVideoFeed({
    super.key,
    required this.controller,
    required this.imageProvider,
    required this.contents,
    required this.state,

  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VideoItem(
          controller: controller,
          thumbnail: imageProvider,
        ),
        FeedContentContainer(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Wrap(
                      spacing: 2.0,
                      runSpacing: 2.0,
                      direction: Axis.vertical,
                      children: [
                        Text(
                          contents.title,
                          style:  BaseTextStyle(
                            fontSize: TypographyTheme.heading_H6,
                            color: ColorConstant.shade00,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          contents.name,
                          style:  BaseTextStyle(
                            fontSize: TypographyTheme.heading_H6,
                            color: ColorConstant.shade00,
                            fontWeight: FontWeight.w700,
                          ),),
                          Text(
                            contents.description,
                            style:  BaseTextStyle(
                              fontSize: TypographyTheme.paragraph_p3,
                              color: ColorConstant.shade00,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                    FeedActionsContainer(
                      videoFeedType: VideoFeedType.selfView,
                      profile:'',
                      isFollowing: state.isFollowing,
                      enabledFollowButton: state.enabledFollowButton,
                      enabledActionButtons: state.enabledActionButtons,
                      onTapFollow: (){},
                      onTapProfile: (){},
                      isSuperMessaged: state.isSuperMessaged,
                      onSuperMessage: (){},
                      isBookmarked: state.isBookmarked,
                      onBookmark: (){},
                      isLiked: state.isLiked,
                      onLike: (){},
                      isDisliked: state.isDisliked,
                      onDislike: (){},
                      isShared: state.isShared,
                      onShare: (){},
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
