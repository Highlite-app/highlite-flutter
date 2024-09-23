import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/project/candidate_project.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/string.dart';

import '../../../../../data/models/apis/dashboard/cadidate/upload/employment/candidate_employment.dart';
import '../sub_section/edit_profile_details_section_container.dart';
import 'package:flutter/material.dart';
class CandidateProjectSection extends StatelessWidget {
  final List<CandidateProject> candidateProject;
  final bool isEditProfile ;

  const CandidateProjectSection({required this.candidateProject, super.key,  this.isEditProfile  = false});

  @override
  Widget build(BuildContext context) {

    return EditProfileDetailsSectionContainer<CandidateProject>(
      isEditProfile: isEditProfile,
      heading: 'Project',
      profileDetails: candidateProject,
      itemBuilder: (context, index, project) {
        return ProfileDetailsItem(
          isEditProfile: isEditProfile,
          index: index, // Pass the index to ProfileDetailsItem
          profileUrl: '', // Assuming CandidateEmployment has profileUrl
          title: project.projectTitle, // Assuming CandidateEmployment has title
          subtitle: project.projectClient, // Assuming CandidateEmployment has subtitle
          startDate:  formatDateShowYear(DateTime.parse(project.projectStart)), // Assuming CandidateEmployment has startDate
          endDate:   formatDateShowYear(DateTime.parse(project.projectFinish)), // Assuming CandidateEmployment has endDate
          onTapEditIcon: () {
            // Handle edit icon tap
          },
        );
      },
    );
  }
}
