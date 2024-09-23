import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/video_feed/video_item.dart';
import 'package:video_player/video_player.dart';
import 'actions_container.dart';
import 'content_container.dart';
import 'feed_content.dart';

class VideoFeedContents {
  final bool hiringTag;
  final String profile;
  final String title;
  final String name;
  final String location;
  final String salary;
  final String jobFlexibility;
  final List<String> skills;
  const VideoFeedContents({
    this.hiringTag = false,
    required this.title,
    required this.profile,
    required this.name,
    required this.location,
    required this.salary,
    required this.jobFlexibility,
    required this.skills,
  });
}

class VideoFeedContentState {
  final bool isFollowing;
  final bool enabledFollowButton;
  final bool isSuperMessaged;
  final bool isBookmarked;
  final bool isLiked;
  final bool isDisliked;
  final bool isShared;
  final bool enabledActionButtons;
  const VideoFeedContentState({
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

class VideoFeedItem extends StatelessWidget {
  final VideoPlayerController controller;
  final ImageProvider imageProvider;
  final VideoFeedContents contents;
  final VideoFeedContentState state;
  final VoidCallback onTapProfile;
  final VoidCallback onFollowTap;
  final VoidCallback onSuperMessageTap;
  final VoidCallback onBookmarkTap;
  final VoidCallback onLike;
  final VoidCallback onDislike;
  final VoidCallback onShare;
  const VideoFeedItem({
    super.key,
    required this.controller,
    required this.imageProvider,
    required this.contents,
    required this.state,
    required this.onTapProfile,
    required this.onFollowTap,
    required this.onSuperMessageTap,
    required this.onBookmarkTap,
    required this.onLike,
    required this.onDislike,
    required this.onShare,
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
                    FeedContent(
                      hiringTag: contents.hiringTag,
                      title: contents.title,
                      name: contents.name,
                      location: contents.location,
                      salary: contents.salary,
                      jobFlexibility: contents.jobFlexibility,
                      skills: contents.skills,
                    ),
                    const Spacer(),
                    FeedActionsContainer(
                      profile: contents.profile,
                      isFollowing: state.isFollowing,
                      enabledFollowButton: state.enabledFollowButton,
                      enabledActionButtons: state.enabledActionButtons,
                      onTapFollow: onFollowTap,
                      onTapProfile: onTapProfile,
                      isSuperMessaged: state.isSuperMessaged,
                      onSuperMessage: onSuperMessageTap,
                      isBookmarked: state.isBookmarked,
                      onBookmark: onBookmarkTap,
                      isLiked: state.isLiked,
                      onLike: onLike,
                      isDisliked: state.isDisliked,
                      onDislike: onDislike,
                      isShared: state.isShared,
                      onShare: onShare,
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
