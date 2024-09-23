import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import '../../../../../../core/services/location_service.dart';
import '../../../../../bloc/dashboard/profile/company/company_editor_bloc.dart';
import '../../../../../bloc/dashboard/profile/company/company_editor_event.dart';
import '../../../../buttons/primary_button.dart';
import '../../../../chat/chat_responder.dart';
import '../../form/profile_editor_form.dart';
import '../../form/profile_editor_form_field.dart';

class EditProfileByCompanyLocation extends EditorFormModel<CompanyOnboarding> {
  EditProfileByCompanyLocation(
    TextEditingController cityController,
    TextEditingController countryController,
  ) : super(
          title: TranslationKeys.editLocation,
          children: (company, formState, setState) => [
            ProfileEditorFormField(
              label: TranslationKeys.city,
              formState: formState,
              placeholderText: TranslationKeys.city,
              height: MinMax(50, 50),
              textController: cityController,
              textCapitalization: TextCapitalization.sentences,
              value: company?.city,
              validator:
                  ValidationBuilder(requiredMessage: "Please add a valid city.")
                      .required()
                      .build(),
            ),
            ProfileEditorFormField(
              label: TranslationKeys.country,
              formState: formState,
              placeholderText: TranslationKeys.country,
              height: MinMax(50, 50),
              textController: countryController,
              textCapitalization: TextCapitalization.sentences,
              value: company?.country,
              validator: ValidationBuilder(
                      requiredMessage: "Please add a valid country.")
                  .required()
                  .build(),
            ),
          ],
          afterChildren: (company, formState, setState) => [
            PrimaryButton(
              title: TranslationKeys.editCurrentLocation,
              buttonStyle: PrimaryButtonStyle.bordered,
              onTap: () async {
                final locationManager = LocationService();
                final placemark = await locationManager.getLocation();
                setState(() {
                  if (placemark != null) {
                    cityController.text = placemark.locality!;
                    countryController.text = placemark.country!;
                  }
                });
              },
              autoGrow: false,
              autoExpand: true,
              expandType: ExpandButtonType.horizontal,
              size: PrimaryButtonSize.normal,
              borderRadius: 8,
            ),
          ],
          onComplete: (companyProfile, context) async {
            context.read<CompanyEditorBloc>().add(
                  UpdateCompanyEvent(
                    companyProfile: companyProfile!.copyWith(
                      city: cityController.text,
                      country: countryController.text,
                    ),
                  ),
                );
          },
          validated: () =>
              cityController.text.isNotEmpty &&
              countryController.text.isNotEmpty,
        );
}
