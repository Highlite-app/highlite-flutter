import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/resources/color_constants.dart';
import '../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../core/resources/typography_theme.dart';
import '../../../../widgets/buttons/capsule_button.dart';
import '../../../../widgets/buttons/primary_button.dart';
import '../../../../widgets/constants/text_style.dart';
import '../../../../widgets/profile/profile_section.dart';

class ProfileFollowerSection extends StatelessWidget {
  final String followers;
  final String following;
  final bool isFollowing;
  final VoidCallback? onFollow;
  final VoidCallback? onTapSuperMessage;
  const ProfileFollowerSection({
    super.key,
    required this.followers,
    required this.following,
    required this.isFollowing,
    this.onFollow,
    this.onTapSuperMessage,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileSection(
      includePadding: false,
      widget: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 100.w),
          child: Column(
            children: [
              Row(
                children: [
                  FollowInfoText(
                      number: following,
                      type: TranslationKeys.followingTitle),
                  const SizedBox(width: 12.0),
                  FollowInfoText(
                      number: followers, type: TranslationKeys.followers),
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  CapsuleButton(
                    title: isFollowing
                        ? TranslationKeys.buttonFollowing
                        : TranslationKeys.buttonFollow,
                    bordered: !isFollowing,
                    onTap: onFollow,
                    autoGrow: true,
                    autoExpand: true,
                    expandType: ExpandButtonType.horizontal,
                    size: CapsuleButtonSize.xlarge,
                  ),
                  const SizedBox(width: 12.0),
                  CapsuleButton(
                    title: TranslationKeys.superMessage,
                    bordered: false,
                    onTap: onTapSuperMessage,
                    autoExpand: true,
                    expandType: ExpandButtonType.horizontal,
                    autoGrow: true,
                    size: CapsuleButtonSize.xlarge,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FollowInfoText extends StatelessWidget {
  final String number;
  final String type;
  const FollowInfoText({
    super.key,
    required this.number,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style:  BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p3,
              color: ColorConstant.neutral900,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            type,
            style:  BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p3,
              color: ColorConstant.neutral600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
