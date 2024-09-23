import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_state.dart';

import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import '../../flows/candidate/edit_profile_by_candidate_hourly_rate.dart';
import '../../flows/candidate/edit_profile_by_candidate_job_duration.dart';
import '../../flows/candidate/edit_profile_by_candidate_job_flexibility.dart';
import '../../sub_section/edit_profile_list_section.dart';
import '../../sub_section/edit_profile_navigate_tile.dart';

class CandidateCareerSection extends StatelessWidget {
 // final String website;
  final String hourlyRate;
  final String jobDuration;
  final String jobFlexibility;
  final String communication;

  const CandidateCareerSection({
    super.key,
    // required this.website,
    required this.hourlyRate,
    required this.jobDuration,
    required this.jobFlexibility,
    required this.communication,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandidateEditorBloc, CandidateEditorState>(
      builder: (context, state) => EditProfileListSection(
        navigations: [
          NavigatedEditProfileForm<CandidateOnBoarding>(
            title: TranslationKeys.hourlyRate,
            value: hourlyRate,
            data: state.candidateOnBoarding,
            form: EditProfileByCandidateHourlyRate(
              TextEditingController(text: ""),
              CurrencyTextInputFormatter.currency(
                  locale: 'en',
                  decimalDigits: 0,
                  symbol: '\$',
                  enableNegative: false),
            ),
          ),
          NavigatedEditProfileForm<CandidateOnBoarding>(
            title: TranslationKeys.workTime,
            value: jobDuration,
            data: state.candidateOnBoarding,
            form: EditProfileByCandidateJobDuration(
              state.candidateOnBoarding?.jobDuration ?? "Job duration Api issue",
            ),
          ),
          NavigatedEditProfileForm<CandidateOnBoarding>(
            title: TranslationKeys.workType,
            value: jobFlexibility,
            data: state.candidateOnBoarding,
            form: EditProfileByCandidateJobFlexibility(
              state.candidateOnBoarding?.workType ?? "JobFlexibility Api issue",
            ),
          ),
        ],
      ),
    );
  }
}
