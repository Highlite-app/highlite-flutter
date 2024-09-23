import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/education/candidate_education.dart';

import '../../../../../../data/models/apis/dashboard/cadidate/upload/employment/candidate_employment.dart';
import '../../../../utils/string.dart';
import '../../sub_section/edit_profile_details_section_container.dart';
import 'package:flutter/material.dart';
class EducationDetailsSection extends StatelessWidget {
  final List<CandidateEducation> candidateEducation;
  final bool isEditProfile ;

  const EducationDetailsSection({required this.candidateEducation, super.key,  this.isEditProfile = true});

  @override
  Widget build(BuildContext context) {

    return EditProfileDetailsSectionContainer<CandidateEducation>(
      isEditProfile: isEditProfile,
      heading: 'Education',
      profileDetails: candidateEducation,
      itemBuilder: (context, index, education) {
        return ProfileDetailsItem(
          isEditProfile: isEditProfile,
          index: index, // Pass the index to ProfileDetailsItem
          profileUrl: '', // Assuming CandidateEmployment has profileUrl
          title: education.school, // Assuming CandidateEmployment has title
          subtitle: education.specialization, // Assuming CandidateEmployment has subtitle// Assuming CandidateEmployment has jobType
          startDate: formatDateShowMonthYear(DateTime.parse(education.startDate)), // Assuming CandidateEmployment has startDate
          endDate: formatDateShowMonthYear(DateTime.parse(education.endDate)), // Assuming CandidateEmployment has endDate
          onTapEditIcon: () {
            // Handle edit icon tap
          },
        );
      },
    );
  }
}
