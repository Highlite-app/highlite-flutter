import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:provider/provider.dart';

import '../../../../../bloc/dashboard/profile/company/company_editor_bloc.dart';
import '../../../../../bloc/dashboard/profile/company/company_editor_event.dart';
import '../../../../chat/chat_responder.dart';
import '../../form/profile_editor_form.dart';
import '../../form/profile_editor_form_field.dart';

class EditCompanyProfileCompanyName
    extends EditorFormModel<CompanyOnboarding> {
  EditCompanyProfileCompanyName(
    TextEditingController companyNameController,
  ) : super(
          title: TranslationKeys.editCompanyName,
          children: (company, formState, setState) => [
            ProfileEditorFormField(
              label: TranslationKeys.companyName,
              formState: formState,
              placeholderText: TranslationKeys.companyName,
              height: MinMax(50, 50),
              textController: companyNameController,
              textCapitalization: TextCapitalization.sentences,
              value: company?.companyName,
              validator: ValidationBuilder(
                      requiredMessage: "Please add a valid company name.")
                  .required()
                  .build(),
            ),
          ],
          onComplete: (companyProfile, context) async {
            context.read<CompanyEditorBloc>().add(
                  UpdateCompanyEvent(
                    companyProfile: companyProfile!.copyWith(
                      companyName: companyNameController.text,
                    ),
                  ),
                );
          },
          validated: () => companyNameController.text.isNotEmpty,
        );
}
