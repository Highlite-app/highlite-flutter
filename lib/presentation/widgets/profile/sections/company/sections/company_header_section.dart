import 'package:flutter/material.dart';

import '../../../../../pages/navigation/profile/default/profile_header_section.dart';


class CompanyProfileHeaderSection extends StatelessWidget {
  final String profilePhoto;
  final String organization;
  final String industry;
  final String city;
  final String country;
  const CompanyProfileHeaderSection({
    super.key,
    required this.profilePhoto,
    required this.organization,
    required this.industry,
    required this.city,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileHeaderSection(
      profilePhoto: profilePhoto,
      heading: organization,
      title: industry,
      caption: "$city, $country",
    );
  }
}
