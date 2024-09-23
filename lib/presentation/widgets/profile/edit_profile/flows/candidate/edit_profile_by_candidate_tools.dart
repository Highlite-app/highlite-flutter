import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import '../../../../../bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import '../../../../../bloc/dashboard/profile/candidate/candidate_editor_event.dart';
import '../../../../form/tags_selection.dart';
import '../../form/profile_editor_form.dart';
import '../../form/profile_editor_form_item.dart';

class EditProfileByCandidateTools extends EditorFormModel<CandidateOnBoarding> {
  EditProfileByCandidateTools(List<String> tools)
      : super(
          title: TranslationKeys.editTools,
          children: (candidate, formState, setState) => [
            ProfileEditorFormItem(
              label: TranslationKeys.editTools,
              children: TagsSelection(
                title: TranslationKeys.tools,
                selection: tools,
                onSelect: (selectedTools) {
                  setState(() {
                    tools = selectedTools;
                  });
                },
                maxCount: 3,
              ),
            ),
          ],
          onComplete: (candidate, context) async {
            context.read<CandidateEditorBloc>().add(
                  UpdateCandidateEvent(
                    candidate: candidate!.copyWith(
                      tools: tools,
                    ),
                  ),
                );
          },
          validated: () => true,
        );
}
