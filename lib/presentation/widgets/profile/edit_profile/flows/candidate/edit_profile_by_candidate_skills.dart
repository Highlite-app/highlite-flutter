import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import '../../../../../bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import '../../../../../bloc/dashboard/profile/candidate/candidate_editor_event.dart';
import '../../../../form/tags_selection.dart';
import '../../form/profile_editor_form.dart';
import '../../form/profile_editor_form_item.dart';

class EditProfileByCandidateSkills
    extends EditorFormModel<CandidateOnBoarding> {
  EditProfileByCandidateSkills(List<String> skills)
      : super(
          title: TranslationKeys.editSkills,
          children: (candidate, formState, setState) => [
            ProfileEditorFormItem(
              label: TranslationKeys.editSkills,
              padded: false,
              children: TagsSelection(
                title: TranslationKeys.skills,
                selection: skills,
                onSelect: (selectedSkills) {
                  setState(() {
                    skills = selectedSkills;
                  });
                },
                maxCount: 3,
              ),
            ),
          ],
          onComplete: (candidate, context) async {
            context.read<CandidateEditorBloc>().add(
                  UpdateCandidateEvent(
                    candidate: candidate!.copyWith(skills:skills ),
                  ),
                );
          },
          validated: () => true,
        );
}
