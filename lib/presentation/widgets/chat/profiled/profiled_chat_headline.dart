import 'package:flutter/material.dart';
import '../../../../core/resources/color_constants.dart';
import '../../../../core/resources/typography_theme.dart';
import '../../../../data/models/onboarding/candidate_user_model.dart';
import '../../buttons/chip_button.dart';
import '../../constants/text_style.dart';
import '../../profile/profile_picture.dart';
import '../../chatbox/super_message/super_message_headline.dart';


class ProfiledChatHeadline extends StatelessWidget {
  final CandidateUser candidateUser;
  final bool isSuperMessage;
  final bool isSuperMessageFromMe;
  const ProfiledChatHeadline(
      {super.key,
      required this.candidateUser,
      required this.isSuperMessage,
      required this.isSuperMessageFromMe});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePicture(
          size: 80,
          url: candidateUser.profile,
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          candidateUser.username,
          style:  BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p3,
            color: ColorConstant.neutral700,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "${candidateUser.firstName} ${candidateUser.lastName}",
          style:  BaseTextStyle(
              fontSize: TypographyTheme.heading_H5_small,
              color: ColorConstant.neutral700,
              fontWeight: FontWeight.w600,
              height: 1.3),
        ),
        Text(
          candidateUser.title,
          style:  BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p3,
            color: ColorConstant.neutral800,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "${candidateUser.city}, ${candidateUser.country}",
          style:  BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p3,
            color: ColorConstant.neutral600,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16.0),
        ChipButton(
          title: "View profile",
          onTap: () {
            // ProfileWidget.showProfileFromCandidateUser(context.navigator,
            //     candidateUser, authState.candidateUser?.id ?? "");
          },
        ),
        const SizedBox(
          height: 8.0,
        ),
        if (isSuperMessage)
          SuperMessageHeadline(
            message: isSuperMessageFromMe
                ? "You sent a super message to {name}"
                : "You sent a super message to {name}",
          ),
        if (!isSuperMessage)
           Text(
            "You can now send each other messages.",
            style: BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p3,
              color: ColorConstant.neutral600,
              fontWeight: FontWeight.w400,
            ),
          ),
        const SizedBox(
          height: 32.0,
        ),
      ],
    );
  }
}
