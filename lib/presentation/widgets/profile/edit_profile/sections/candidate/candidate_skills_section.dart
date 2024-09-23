import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_state.dart';

import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import '../../flows/candidate/edit_profile_by_candidate_skills.dart';
import '../../flows/candidate/edit_profile_by_candidate_tools.dart';
import '../../sub_section/edit_profile_list_section.dart';
import '../../sub_section/edit_profile_navigate_tile.dart';

class CandidateSkillsSection extends StatelessWidget {
  const CandidateSkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandidateEditorBloc, CandidateEditorState>(
      builder: (context, state) => EditProfileListSection(
        navigations: [
          NavigatedEditProfileForm<CandidateOnBoarding>(
            title: TranslationKeys.skills,
            data: state.candidateOnBoarding,
            form: EditProfileByCandidateSkills(
              state.candidateOnBoarding?.skills ?? [],
            ),
          ),
          NavigatedEditProfileForm<CandidateOnBoarding>(
            title: TranslationKeys.tools,
            data: state.candidateOnBoarding,
            form: EditProfileByCandidateTools(
              state.candidateOnBoarding?.tools ?? [],
            ),
          ),
        ],
      ),
    );
  }
}
