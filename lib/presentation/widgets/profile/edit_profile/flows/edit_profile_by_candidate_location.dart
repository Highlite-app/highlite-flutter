import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import '../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../core/services/location_service.dart';
import '../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import '../../../../bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import '../../../../bloc/dashboard/profile/candidate/candidate_editor_event.dart';
import '../../../buttons/primary_button.dart';
import '../../../chat/chat_responder.dart';
import '../form/profile_editor_form.dart';
import '../form/profile_editor_form_field.dart';

class EditProfileByCandidateLocation
    extends EditorFormModel<CandidateOnBoarding> {
  EditProfileByCandidateLocation(
    TextEditingController cityController,
    TextEditingController countryController,
  ) : super(
          title: TranslationKeys.editLocation,
          children: (candidate, formState, setState) => [
            ProfileEditorFormField(
              label: TranslationKeys.city,
              formState: formState,
              placeholderText: TranslationKeys.city,
              height: MinMax(50, 50),
              textController: cityController,
              textCapitalization: TextCapitalization.sentences,
              value: candidate?.city,
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
              value: candidate?.country,
              validator: ValidationBuilder(
                      requiredMessage: "Please add a valid country.")
                  .required()
                  .build(),
            ),
          ],
          afterChildren: (candidate, formState, setState) => [
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
              size: PrimaryButtonSize.medium,
              borderRadius: 8,
            ),
          ],
          onComplete: (candidate, context) async {
            context.read<CandidateEditorBloc>().add(
                  UpdateCandidateEvent(
                    candidate: candidate!.copyWith(
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
