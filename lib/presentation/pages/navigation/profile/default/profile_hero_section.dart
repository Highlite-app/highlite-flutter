import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/profile/default/profile_follower_section.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/profile/default/profile_hero_action_section.dart';

class ProfileHeroSection extends StatelessWidget {
  final bool isPreview;
  final VoidCallback onEdit;
  final String followers;
  final String following;
  final bool isFollowing;
  final VoidCallback? onFollow;
  final VoidCallback? onTapSuperMessage;
  const ProfileHeroSection(
      {super.key,
      required this.isPreview,
      required this.onEdit,
      required this.followers,
      required this.following,
      required this.isFollowing,
      this.onFollow,
      this.onTapSuperMessage});

  @override
  Widget build(BuildContext context) {
    if (isPreview) {
      return ProfileFollowerSection(
        followers: followers,
        following: following,
        isFollowing: isFollowing,
        onFollow: onFollow,
        onTapSuperMessage: onTapSuperMessage,
      );
    }
    return ProfileHeroAction(
      onTap: onEdit,
    );
  }
}
