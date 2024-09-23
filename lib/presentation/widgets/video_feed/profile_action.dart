import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';

import '../../../core/resources/color_constants.dart';
import '../buttons/rippler.dart';
import '../buttons/tiny_button.dart';
import '../profile/profile_picture.dart';

class ProfileAction extends StatelessWidget {
  final String profile;
  final bool isFollowing;
  final bool enabledFollowButton;
  final VoidCallback onTapFollow;
  final VoidCallback onTapProfile;

  const ProfileAction({
    super.key,
    required this.profile,
    required this.enabledFollowButton,
    this.isFollowing = false,
    required this.onTapFollow,
    required this.onTapProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
              border: Border.all(color: ColorConstant.primary500, width: 4),
              shape: BoxShape.circle),
          child: Rippler(
            backgroundColor: ColorConstant.shade00,
            clipBehavior: Clip.hardEdge,
            shape: const CircleBorder(),
            onTap: onTapProfile,
            child: ProfilePicture(
              url: profile,
              size: 48,
            ),
          ),
        ),
        if (enabledFollowButton)
          Positioned(
            bottom: -10,
            width: 22,
            height: 22,
            child: TinyButton(
              onTap: onTapFollow,
              splashColor: ColorConstant.neutral50,
              color: isFollowing
                  ? ColorConstant.shade00
                  : ColorConstant.primary500,
              icon: isFollowing ? AssetConstant.checkMarkIcon : AssetConstant.plusIcon,
              iconColor: isFollowing
                  ? ColorConstant.primary500
                  : ColorConstant.shade00,
              size: 7,
              iconPadding: 5,
            ),
          ),
      ],
    );
  }
}
