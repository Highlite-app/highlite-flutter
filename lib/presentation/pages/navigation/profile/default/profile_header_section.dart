import 'package:flutter/material.dart';
import '../../../../../core/resources/color_constants.dart';
import '../../../../../core/resources/typography_theme.dart';
import '../../../../widgets/constants/text_style.dart';
import '../../../../widgets/profile/profile_picture.dart';
import '../../../../widgets/profile/profile_section.dart';

class ProfileHeaderSection extends StatelessWidget {
  final String profilePhoto;
  final String heading;
  final String title;
  final String caption;
  const ProfileHeaderSection({
    super.key,
    required this.profilePhoto,
    required this.heading,
    required this.title,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileSection(
      includePadding: false,
      widget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                ProfilePicture(
                  size: 80,
                  allowEdit: false,
                  url: profilePhoto,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        heading,
                        style:  BaseTextStyle(
                          fontSize: TypographyTheme.heading_H5_small,
                          color: ColorConstant.neutral900,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        title,
                        style:  BaseTextStyle(
                          fontSize: TypographyTheme.paragraph_p3,
                          color: ColorConstant.neutral800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        caption,
                        style:  BaseTextStyle(
                          fontSize: TypographyTheme.paragraph_p3,
                          color: ColorConstant.neutral600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
