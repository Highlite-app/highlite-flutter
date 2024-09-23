import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/sections/company/sections/profile_section.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/string.dart';

import '../sections/company_info_header.dart';

class CompanyInfoPage extends StatelessWidget {
  final String username;

  final String companyName;

  final String companyLogo;

  final String about;

  final String location;

  final String website;

  final String ourServices;

  final List<String> industry;

  final List<String> language;

  final List<String> benefits;

  const CompanyInfoPage(
      {super.key,
      required this.username,
      required this.companyName,
      required this.companyLogo,
      required this.about,
      required this.location,
      required this.website,
      required this.ourServices,
      required this.industry,
      required this.language,
      required this.benefits});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.neutral50,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          username,
          style: BaseTextStyle(
            color: ColorConstant.shade100,
            fontSize: TypographyTheme.paragraph_p4,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              PublicProfileInfoHeader(
                profilePicture: companyLogo,
                heading: companyName,
                lastUpdated: 'Profile last updated - 08 May, 2024',
              ),
              const SizedBox(height: 16.0),
              if (!about.isNullOrEmpty) ...[
                ProfileSection(title: TranslationKeys.about, content: about),
                const SizedBox(height: 16.0),
              ],
              if (!location.isNullOrEmpty) ...[
                ProfileSection(
                    title: TranslationKeys.location, content: location),
                const SizedBox(height: 16.0),
              ],
              if (!website.isNullOrEmpty) ...[
                ProfileSection(
                    title: TranslationKeys.website,
                    isLink: true,
                    content: website),
                const SizedBox(height: 16.0),
              ],
              if (!ourServices.isNullOrEmpty) ...[
                ProfileSection(
                    title: TranslationKeys.ourServices, content: ourServices),
                const SizedBox(height: 16.0),
              ],
              if (!industry.isNullOrEmpty) ...[
                ProfileSection(
                    title: TranslationKeys.industry,
                    contentStyle: ContentStyle.chip,
                    items: industry),
                const SizedBox(height: 16.0),
              ],
              if(!benefits.isNullOrEmpty)...[
                ProfileBenefits(
                  benefits: benefits,
                ),
              ]

            ],
          ),
        ),
      ),
    );
  }
}

class ProfileBenefits extends StatelessWidget {
  final List<String> benefits;

  const ProfileBenefits({super.key, required this.benefits});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Benefits',
          style: BaseTextStyle(
              fontSize: TypographyTheme.heading_H5_small,
              fontWeight: FontWeight.w500,
              color: ColorConstant.shade100),
        ),
        Wrap(
            children: benefits.map((benefit) {
          return BenefitCard(label: benefit, icon: Icons.home);
        }).toList()),
      ],
    );
  }
}

class BenefitCard extends StatelessWidget {
  final String label;
  final IconData icon;

  BenefitCard({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstant.shade00,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: ColorConstant.primary500,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: BaseTextStyle(
                  color: ColorConstant.neutral800,
                  fontSize: TypographyTheme.paragraph_p5,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
