import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../profile/profile_picture.dart';

class ProfileDrawerTop extends StatelessWidget {
  final String profileURL;
  final String fullName;
  const ProfileDrawerTop({
    super.key,
    required this.profileURL,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfilePicture(
            size: 80,
            url: profileURL,
            allowEdit: true,
            onEdit: () async {
              // ProfileEditor.profileEditor(
              //   context,
              //   authState.candidateUser!,
              //   authState,
              //   () {

              //   },
              // );
            },
          ),
          const SizedBox(height: 12),
          Text(
            fullName,
            style:  BaseTextStyle(
              color: ColorConstant.neutral900,
              fontSize: TypographyTheme.heading_H5_small,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
