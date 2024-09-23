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

class EditProfileByCandidateUsername
    extends EditorFormModel<CandidateOnBoarding> {
  EditProfileByCandidateUsername(
    TextEditingController usernameController,
  ) : super(
          title: TranslationKeys.editUsername,
          children: (candidate, formState, setState) => [
            ProfileEditorFormField(
              label: TranslationKeys.username,
              formState: formState,
              placeholderText: TranslationKeys.username,
              height: MinMax(50, 50),
              textController: usernameController,
              textCapitalization: TextCapitalization.sentences,
              value: candidate?.username ?? "username not found",
              validator: ValidationBuilder(
                      requiredMessage: "Please add a valid user name.")
                  .required()
                  .build(),
              caption:
                  "You can only change your username once in every 14 days.",
            ),
          ],
          onComplete: (candidate, context) async {
            context.read<CandidateEditorBloc>().add(
                  UpdateCandidateEvent(
                    candidate: candidate!.copyWith(
                      username: usernameController.text,
                    ),
                  ),
                );
          },
          validated: () => usernameController.text.isNotEmpty,
        );
}
