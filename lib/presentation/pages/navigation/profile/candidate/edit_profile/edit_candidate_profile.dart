import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/education/candidate_education.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_state.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/profile/candidate/edit_profile/profile_editor_page.dart';
import '../../../../../../data/models/apis/dashboard/cadidate/upload/employment/candidate_employment.dart';
import '../../../../../../data/models/apis/dashboard/cadidate/upload/project/candidate_project.dart';
import '../../../../../widgets/profile/edit_profile/sections/candidate_career_section.dart';
import '../../../../../widgets/profile/edit_profile/sections/candidate_education_section.dart';
import '../../../../../widgets/profile/edit_profile/sections/candidate_employment_section.dart';
import '../../../../../widgets/profile/edit_profile/sections/candidate_personal_section.dart';
import '../../../../../widgets/profile/edit_profile/sections/candidate_project_section.dart';
import '../../../../../widgets/profile/edit_profile/sections/candidate_skills_section.dart';

class EditCandidateProfile extends StatelessWidget {
  const EditCandidateProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandidateEditorBloc , CandidateEditorState>(
      builder: (context, state) {
        final candidate = state.candidateOnBoarding;
        return ProfileEditorPage(
          children: [
            CandidatePersonalSection(
              fullName: "${candidate.firstName} ${candidate.lastName}",
              username: candidate.username ?? "Username Api Issue",
              jobTitle: candidate.position ?? "Title Api Issue",
              location: "${candidate.city}, ${candidate.country}",
              aboutMe: candidate.about ?? "About Api iIssue",
            ),
            CandidateCareerSection(
              hourlyRate:  candidate.salary ?? "Salary not found" ,
              jobDuration: candidate.jobDuration ?? "Job Duration Api Issue",
              jobFlexibility: candidate.workType ?? "Job Flexibility Api Issue",
              communication:  "Communication Api Issue",
            ),
            const CandidateSkillsSection(),
            EmploymentDetailsSection(candidateEmployment: CandidateEmployment.createDummyEmploymentList()) ,

            EducationDetailsSection(candidateEducation: CandidateEducation.dummyCandidateEducationList,),
            CandidateProjectSection(candidateProject: CandidateProject.dummyProjects(),)
          ],
        );
      },
    );
  }
}
