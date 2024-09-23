import '../../../../../../data/models/apis/dashboard/cadidate/upload/employment/candidate_employment.dart';
import '../../sub_section/edit_profile_details_section_container.dart';
import 'package:flutter/material.dart';
class EmploymentDetailsSection extends StatelessWidget {
  final List<CandidateEmployment> candidateEmployment;
  final bool isEditProfile ;
  const EmploymentDetailsSection({required this.candidateEmployment, super.key,  this.isEditProfile  =true});

  @override
  Widget build(BuildContext context) {

    return EditProfileDetailsSectionContainer<CandidateEmployment>(
      isEditProfile: isEditProfile,
      heading: 'Employment',
      profileDetails: candidateEmployment,
      itemBuilder: (context, index, employment) {
        return ProfileDetailsItem(
          isEditProfile: isEditProfile,
          index: index, // Pass the index to ProfileDetailsItem
          profileUrl: '', // Assuming CandidateEmployment has profileUrl
          title: employment.employmentTitle, // Assuming CandidateEmployment has title
          subtitle: employment.companyName, // Assuming CandidateEmployment has subtitle
          jobType: employment.employmentType, // Assuming CandidateEmployment has jobType
          startDate: employment.startDate, // Assuming CandidateEmployment has startDate
          endDate: employment.endDate, // Assuming CandidateEmployment has endDate
          onTapEditIcon: () {
            // Handle edit icon tap
          },
        );
      },
    );
  }
}
