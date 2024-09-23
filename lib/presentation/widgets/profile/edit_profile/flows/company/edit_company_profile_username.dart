import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import '../../../../../bloc/dashboard/profile/company/company_editor_bloc.dart';
import '../../../../../bloc/dashboard/profile/company/company_editor_event.dart';
import '../../../../chat/chat_responder.dart';
import '../../form/profile_editor_form.dart';
import '../../form/profile_editor_form_field.dart';

class EditProfileByCompanyUsername extends EditorFormModel<CompanyOnboarding> {
  EditProfileByCompanyUsername(
    TextEditingController usernameController,
  ) : super(
          title: TranslationKeys.editUsername,
          children: (company, formState, setState) => [
            ProfileEditorFormField(
              label: TranslationKeys.username,
              formState: formState,
              placeholderText: TranslationKeys.username,
              height: MinMax(50, 50),
              textController: usernameController,
              textCapitalization: TextCapitalization.sentences,
              value: company?.userName,
              validator: ValidationBuilder(
                      requiredMessage: "Please add a valid user name.")
                  .required()
                  .build(),
              caption:
                  "You can only change your username once in every 14 days.",
            ),
          ],
          onComplete: (companyProfile, context) async {
            context.read<CompanyEditorBloc>().add(
                  UpdateCompanyEvent(
                    companyProfile: companyProfile!.copyWith(
                      userName: usernameController.text,
                    ),
                  ),
                );
          },
          validated: () => usernameController.text.isNotEmpty,
        );
}
