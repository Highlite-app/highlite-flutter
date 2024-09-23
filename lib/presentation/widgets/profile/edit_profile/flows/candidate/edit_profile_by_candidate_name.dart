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

class EditProfileByCandidateName extends EditorFormModel<CandidateOnBoarding> {
  EditProfileByCandidateName(
    TextEditingController firstNameController,
    TextEditingController lastNameController,
  ) : super(
          title: TranslationKeys.editName,
          children: (candidate, formState, setState) => [
            ProfileEditorFormField(
              label: TranslationKeys.firstName,
              formState: formState,
              placeholderText: TranslationKeys.firstName,
              height: MinMax(50, 50),
              textController: firstNameController,
              textCapitalization: TextCapitalization.sentences,
              value: candidate?.firstName,
              validator: ValidationBuilder(
                      requiredMessage: "Please add a valid first name.")
                  .required()
                  .build(),
            ),
            ProfileEditorFormField(
              label: TranslationKeys.lastName,
              formState: formState,
              placeholderText: TranslationKeys.lastName,
              height: MinMax(50, 50),
              textController: lastNameController,
              textCapitalization: TextCapitalization.sentences,
              value: candidate?.lastName,
              validator: ValidationBuilder(
                      requiredMessage: "Please add a valid last name.")
                  .required()
                  .build(),
              caption: TranslationKeys.editProfileByCandidateNameCaption,
            ),
          ],
          onComplete: (candidate, context) async {
            context.read<CandidateEditorBloc>().add(
                  UpdateCandidateEvent(
                    candidate: candidate!.copyWith(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                    ),
                  ),
                );
          },
          validated: () =>
              firstNameController.text.isNotEmpty &&
              lastNameController.text.isNotEmpty,
        );
}
