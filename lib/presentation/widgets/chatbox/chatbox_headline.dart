import 'package:flutter/material.dart';

import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../buttons/chip_button.dart';
import '../constants/text_style.dart';
import '../profile/profile_picture.dart';

class ChatboxHeadline extends StatelessWidget {
  final String profile;
  final String username;
  final String name;
  final String title;
  final String location;
  final VoidCallback onClickView;

  const ChatboxHeadline({
    super.key,
    required this.profile,
    required this.username,
    required this.name,
    required this.title,
    required this.location,
    required this.onClickView,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfilePicture(
              size: 80,
              url: profile,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              username,
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p3,
                color: ColorConstant.neutral700,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              name,
              style: BaseTextStyle(
                fontSize: TypographyTheme.heading_H5_small,
                color: ColorConstant.neutral700,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
            Text(
              title,
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p3,
                color: ColorConstant.neutral800,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              location,
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p3,
                color: ColorConstant.neutral600,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ChipButton(
              title: "View profile",
              onTap: onClickView,
            ),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ],
    );
  }
}
