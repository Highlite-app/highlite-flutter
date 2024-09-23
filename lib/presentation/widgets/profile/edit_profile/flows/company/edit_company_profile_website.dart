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

class EditCompanyProfileWebsite
    extends EditorFormModel<CompanyOnboarding> {
  EditCompanyProfileWebsite(
    TextEditingController websiteController,
  ) : super(
          title: TranslationKeys.editWebsite,
          children: (company, formState, setState) => [
            ProfileEditorFormField(
              label: TranslationKeys.yourWebsite,
              formState: formState,
              placeholderText: TranslationKeys.yourWebsite,
              height: MinMax(50, 50),
              textController: websiteController,
              textCapitalization: TextCapitalization.sentences,
              value: company?.website,
              validator: ValidationBuilder(
                      requiredMessage:
                          "Invalid URL. Please provide a valid url.")
                  .required()
                  .build(),
            ),
          ],
          onComplete: (companyProfile, context) async {
            context.read<CompanyEditorBloc>().add(
                  UpdateCompanyEvent(
                    companyProfile: companyProfile!.copyWith(
                      website: websiteController.text,
                    ),
                  ),
                );
          },
          validated: () => websiteController.text.isNotEmpty,
        );
}
