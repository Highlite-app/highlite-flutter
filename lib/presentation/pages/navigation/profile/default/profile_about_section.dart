import 'package:flutter/material.dart';
import '../../../../../core/resources/color_constants.dart';
import '../../../../../core/resources/typography_theme.dart';
import '../../../../widgets/constants/text_style.dart';
import '../../../../widgets/profile/profile_section.dart';

class ProfileAboutSection extends StatelessWidget {
  final String text;
  final String title;
  const ProfileAboutSection({
    super.key,
    required this.text,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileSection(
      includePadding: false,
      header: "About",
      widget: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 6.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style:  BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p3,
                  color: ColorConstant.neutral800,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),]
        ),
      ),
    );
  }
}
