import 'package:flutter/material.dart';


import '../../../../../pages/navigation/profile/default/profile_about_section.dart';

class CompanyAboutSection extends StatelessWidget {
  final String aboutMe;
  const CompanyAboutSection({
    super.key,
    required this.aboutMe,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileAboutSection(
      title: "About",
      text: aboutMe,
    );
  }
}
