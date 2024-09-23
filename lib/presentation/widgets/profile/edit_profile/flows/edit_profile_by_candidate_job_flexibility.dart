import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import '../../../../bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import '../../../../../core/constants/profile_options.dart';
import '../../../../../core/resources/l10n/translation_key.dart';
import '../../../../bloc/dashboard/profile/candidate/candidate_editor_event.dart';
import '../../../form/radio_group.dart';
import '../form/profile_editor_form.dart';
import '../form/profile_editor_form_item.dart';

class EditProfileByCandidateJobFlexibility
    extends EditorFormModel<CandidateOnBoarding> {
  EditProfileByCandidateJobFlexibility(String workType)
      : super(
          title: TranslationKeys.editWorkType,
          children: (candidate, formState, setState) => [
            ProfileEditorFormItem(
              label: TranslationKeys.workType,
              padded: false,
              children: RadioGroup(
                items: ProfileOptions().jobFlexibility(),
                initialValue: candidate?.workType ?? "Job Flexibility Not Found in Api",
                onSelect: (selection) {
                  workType = selection;
                },
              ),
            ),
          ],
          onComplete: (candidate, context) async {
            context.read<CandidateEditorBloc>().add(
                  UpdateCandidateEvent(
                    candidate: candidate!.copyWith(
                      workType: workType,
                    ),
                  ),
                );
          },
          validated: () => true,
        );
}
