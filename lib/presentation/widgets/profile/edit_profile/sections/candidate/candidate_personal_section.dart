import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_state.dart';

import '../../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import '../../flows/candidate/edit_profile_by_candidate_about.dart';
import '../../flows/candidate/edit_profile_by_candidate_location.dart';
import '../../flows/candidate/edit_profile_by_candidate_name.dart';
import '../../flows/candidate/edit_profile_by_candidate_title.dart';
import '../../flows/candidate/edit_profile_by_candidate_username.dart';
import '../../sub_section/edit_profile_list_section.dart';
import '../../sub_section/edit_profile_navigate_tile.dart';

class CandidatePersonalSection extends StatelessWidget {
  final String fullName;
  final String username;
  final String jobTitle;
  final String location;
  final String aboutMe;
  const CandidatePersonalSection({
    super.key,
    required this.fullName,
    required this.username,
    required this.jobTitle,
    required this.location,
    required this.aboutMe,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandidateEditorBloc , CandidateEditorState>(
      builder: (ctx, state) => EditProfileListSection(
        navigations: [
          NavigatedEditProfileForm<CandidateOnBoarding>(
            title: TranslationKeys.name,
            value: fullName,
            data: state.candidateOnBoarding ,
            form: EditProfileByCandidateName(
              TextEditingController(text: ""),
              TextEditingController(text: ""),
            ),
          ),
          NavigatedEditProfileForm<CandidateOnBoarding>(
            title: TranslationKeys.username,
            value: username,
            data: state.candidateOnBoarding,
            form: EditProfileByCandidateUsername(
              TextEditingController(text: ""),
            ),
          ),
          NavigatedEditProfileForm<CandidateOnBoarding>(
            title: TranslationKeys.jobTitle,
            value: jobTitle,
            data: state.candidateOnBoarding,
            form: EditProfileByCandidateTitle(
              TextEditingController(text: ""),
            ),
          ),
          NavigatedEditProfileForm<CandidateOnBoarding>(
            title: TranslationKeys.location,
            value: location,
            data: state.candidateOnBoarding,
            form: EditProfileByCandidateLocation(
              TextEditingController(text: ""),
              TextEditingController(text: ""),
            ),
          ),
          NavigatedEditProfileForm<CandidateOnBoarding>(
            title: TranslationKeys.about,
            value: aboutMe,
            data: state.candidateOnBoarding,
            bordered: false,
            form: EditProfileByCandidateAbout(
              TextEditingController(text: ""),
            ),
          ),
        ],
      ),
    );
  }
}
