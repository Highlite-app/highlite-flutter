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

class EditProfileByCandidateTitle extends EditorFormModel<CandidateOnBoarding> {
  EditProfileByCandidateTitle(
    TextEditingController titleController,
  ) : super(
          title: TranslationKeys.editJobTitle,
          children: (candidate, formState, setState) => [
            ProfileEditorFormField(
              label: TranslationKeys.title,
              formState: formState,
              placeholderText: TranslationKeys.title,
              height: MinMax(50, 50),
              textController: titleController,
              textCapitalization: TextCapitalization.sentences,
              value: candidate?.position,
              validator: ValidationBuilder(
                      requiredMessage: "Please add a valid title.")
                  .required()
                  .build(),
            ),
          ],
          onComplete: (candidate, context) async {
            context.read<CandidateEditorBloc>().add(
                  UpdateCandidateEvent(
                    candidate: candidate!.copyWith(
                      position: titleController.text,
                    ),
                  ),
                );
          },
          validated: () => titleController.text.isNotEmpty,
        );
}
