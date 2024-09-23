import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import '../../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import '../../../../../bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import '../../../../../bloc/dashboard/profile/candidate/candidate_editor_event.dart';
import '../../../../chat/chat_responder.dart';
import '../../form/profile_editor_form.dart';
import '../../form/profile_editor_form_field.dart';

class EditProfileByCandidateHourlyRate
    extends EditorFormModel<CandidateOnBoarding> {
  EditProfileByCandidateHourlyRate(TextEditingController hourlyRateController,
      CurrencyTextInputFormatter currencyFormatter)
      : super(
          title: TranslationKeys.editHourlyRate,
          children: (candidate, formState, setState) => [
            ProfileEditorFormField(
              label: TranslationKeys.hourlyRate,
              formState: formState,
              placeholderText: "\$20",
              height: MinMax(50, 50),
              textController: hourlyRateController,
              formatter: [currencyFormatter],
              validator: ValidationBuilder(
                      requiredMessage: "Hourly rate can’t be below \$3.")
                  .required()
                  .build(),
              value: currencyFormatter.formatString(candidate?.salary ?? "No Salary Found in Api"),
            ),
          ],
          onComplete: (candidate, context) async {
            context.read<CandidateEditorBloc>().add(
                  UpdateCandidateEvent(
                    candidate: candidate!.copyWith(
                      salary:
                          currencyFormatter.getUnformattedValue().toString(),
                    ),
                  ),
                );
          },
          validated: () => currencyFormatter.getUnformattedValue() >= 3,
        );
}
