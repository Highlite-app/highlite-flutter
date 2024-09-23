import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/profile_options.dart';
import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import '../../../../../bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import '../../../../../bloc/dashboard/profile/candidate/candidate_editor_event.dart';
import '../../../../form/radio_group.dart';
import '../../form/profile_editor_form.dart';
import '../../form/profile_editor_form_item.dart';
class EditProfileByCandidateJobDuration
    extends EditorFormModel<CandidateOnBoarding> {
  EditProfileByCandidateJobDuration(String jobDuration)
      : super(
          title: TranslationKeys.editWorkTime,
          children: (candidate, formState, setState) => [
            ProfileEditorFormItem(
              label: TranslationKeys.workTime,
              padded: false,
              children: RadioGroup(
                items: ProfileOptions().jobDuration(),
                initialValue: candidate?.jobDuration ?? "No Job Duration Found Api",
                onSelect: (selection) {
                  jobDuration = selection;
                },
              ),
            ),
          ],
          onComplete: (candidate, context) async {
            context.read<CandidateEditorBloc>().add(
                  UpdateCandidateEvent(
                    candidate: candidate!.copyWith(
                      jobDuration: jobDuration,
                    ),
                  ),
                );
          },
          validated: () => true,
        );
}
