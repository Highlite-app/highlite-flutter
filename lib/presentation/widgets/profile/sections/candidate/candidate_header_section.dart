import 'package:flutter/material.dart';

import '../../../../pages/navigation/profile/default/profile_header_section.dart';

class CandidateProfileHeaderSection extends StatelessWidget {
  final String profilePhoto;
  final String firstName;
  final String lastName;
  final String title;
  final String city;
  final String country;
  const CandidateProfileHeaderSection({
    super.key,
    required this.profilePhoto,
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.city,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileHeaderSection(
      profilePhoto: profilePhoto,
      heading: "$firstName $lastName",
      title: title,
      caption: "$city, $country",
    );
  }
}
