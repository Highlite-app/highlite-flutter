import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import '../../../../../bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import '../../../../../bloc/dashboard/profile/candidate/candidate_editor_event.dart';
import '../../../../chat/chat_responder.dart';
import '../../form/profile_editor_form.dart';
import '../../form/profile_editor_form_field.dart';

class EditProfileByCandidateAbout extends EditorFormModel<CandidateOnBoarding> {
  EditProfileByCandidateAbout(
    TextEditingController aboutController,
  ) : super(
          title: TranslationKeys.editJobTitle,
          children: (candidate, formState, setState) => [
            ProfileEditorFormField(
              label: TranslationKeys.editAbout,
              formState: formState,
              placeholderText: TranslationKeys.about,
              height: MinMax(0, 150),
              textController: aboutController,
              characterLimit: MinMax(0, 150),
              textCapitalization: TextCapitalization.sentences,
              value: candidate?.about,
              validator: ValidationBuilder(
                      requiredMessage: "Please add a valid about.")
                  .build(),
            ),
          ],
          onComplete: (candidate, context) async {
            context.read<CandidateEditorBloc>().add(
                  UpdateCandidateEvent(
                    candidate: candidate!.copyWith(
                      about: aboutController.text,
                    ),
                  ),
                );
          },
          validated: () => true,
        );
}
