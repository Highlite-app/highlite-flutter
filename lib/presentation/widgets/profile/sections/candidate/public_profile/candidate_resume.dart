import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/core/services/location_service.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/education/candidate_education.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/employment/candidate_employment.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/project/candidate_project.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/profile/sections/company/sections/profile_section.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/string.dart';

import '../../../edit_profile/sections/candidate/candidate_education_section.dart';
import '../../../edit_profile/sections/candidate/candidate_employment_section.dart';
import '../../../edit_profile/sections/candidate/candidate_project_section.dart';
import '../../company/sections/company_info_header.dart';

class CandidateResume extends StatelessWidget {
  final String username;

  final String candidateName;

  final String profilePicture;

  final List<String> skills;

  final List<String> tools;

  final List<String> languages;

  final List<CandidateEmployment>? candidateEmployment;

  final List<CandidateProject>? candidateProject;

  final List<CandidateEducation>? candidateEducation;

  final String salary;

  final String about;

  final String location;

  const CandidateResume({
    super.key,
    required this.username,
    required this.candidateName,
    required this.profilePicture,
    required this.about,
    required this.location,
    required this.skills,
    required this.tools,
    required this.languages,
    required this.salary,
    this.candidateEmployment,
    this.candidateProject,
    this.candidateEducation,
  });

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
                profilePicture: profilePicture,
                heading: candidateName,
                lastUpdated: 'Profile last updated - 08 May, 2024',
              ),
              const SizedBox(height: 16.0),
              if (!about.isNullOrEmpty) ...[
                ProfileSection(title: TranslationKeys.about, content: about),
                const SizedBox(height: 16.0),
              ],
              if (!location.isNullOrEmpty) ...[

                ProfileSection(
                  icon: AssetConstant.locationIcon,
                  iconColor: ColorConstant.primary500,
                  isLink: true,
                    contentStyle: ContentStyle.location,
                    title: TranslationKeys.location, content: location),
                const SizedBox(height: 16.0),
              ],
              if (!salary.isNullOrEmpty) ...[
                ProfileSection(
                    title: TranslationKeys.expectedSalary,
                    contentStyle: ContentStyle.chip,
                    isSelected: true,
                    items: ['\$$salary']),
                const SizedBox(height: 16.0),
              ],
              if (!skills.isNullOrEmpty) ...[
                ProfileSection(
                    title: TranslationKeys.skills,
                    contentStyle: ContentStyle.chip,
                    items: skills),
                const SizedBox(height: 16.0),
              ],
              if (!tools.isNullOrEmpty) ...[
                ProfileSection(
                    title: TranslationKeys.tools,
                    contentStyle: ContentStyle.chip,
                    items: tools),
                const SizedBox(height: 16.0),
              ],
              if (!languages.isNullOrEmpty) ...[
                ProfileSection(
                    title: TranslationKeys.languages,
                    contentStyle: ContentStyle.chip,
                    items: languages),
                const SizedBox(height: 16.0),
              ],
              if (candidateEmployment != null &&
                  candidateEmployment!.isNotEmpty) ...[
                EmploymentDetailsSection(
                  candidateEmployment: candidateEmployment ?? [],
                  isEditProfile: false,
                ),
                const SizedBox(height: 16.0),
              ],
              if (candidateEmployment != null &&
                  candidateEmployment!.isNotEmpty) ...[
                EmploymentDetailsSection(
                  candidateEmployment: candidateEmployment ?? [],
                  isEditProfile: false,
                ),
                const SizedBox(height: 16.0),
              ],
              if (candidateEducation != null &&
                  candidateEducation!.isNotEmpty) ...[
                EducationDetailsSection(
                  candidateEducation: candidateEducation ?? [],
                  isEditProfile: false,
                ),
                const SizedBox(height: 16.0),
              ],
              if (candidateProject != null &&
                  candidateProject!.isNotEmpty) ...[
                CandidateProjectSection(
                 candidateProject : candidateProject ?? [],
                  isEditProfile: false,
                ),
                const SizedBox(height: 16.0),
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
