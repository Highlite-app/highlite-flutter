import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:provider/provider.dart';

import '../../../../../bloc/dashboard/profile/company/company_editor_bloc.dart';
import '../../../../../bloc/dashboard/profile/company/company_editor_event.dart';
import '../../../../chat/chat_responder.dart';
import '../../form/profile_editor_form.dart';
import '../../form/profile_editor_form_field.dart';

class EditCompanyProfileAbout extends EditorFormModel<CompanyOnboarding> {
  EditCompanyProfileAbout(
    TextEditingController aboutController,
  ) : super(
          title: TranslationKeys.editAbout,
          children: (company, formState, setState) => [
            ProfileEditorFormField(
              label: TranslationKeys.editAbout,
              formState: formState,
              placeholderText: TranslationKeys.about,
              height: MinMax(0, 150),
              textController: aboutController,
              characterLimit: MinMax(0, 150),
              textCapitalization: TextCapitalization.sentences,
              value: company?.about ?? '',
              validator: ValidationBuilder(
                      requiredMessage: "Please add a valid about.")
                  .build(),
            ),
          ],
          onComplete: (companyProfile, context) async {
            context.read<CompanyEditorBloc>().add(
                  UpdateCompanyEvent(
                    companyProfile: companyProfile!.copyWith(
                      about: aboutController.text,
                    ),
                  ),
                );
          },
          validated: () => true,
        );
}
