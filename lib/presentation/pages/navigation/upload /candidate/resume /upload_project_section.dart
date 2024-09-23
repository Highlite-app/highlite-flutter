import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/project/project_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/project/project_state.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/resume_navigation_page.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/text_field/text_field_with_button.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/form/form.dart';

import '../../../../../bloc/dashboard/upload/candidate/project/project_event.dart';
import '../../../../../widgets/chat/chat_responder.dart';
import '../../../../../widgets/chip/preselected_chip_with_heading.dart';
import '../../../../../widgets/text/heading_text.dart';

class UploadProjectSection extends StatelessWidget {
  const UploadProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResumeNavigation(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FormProvider(
              formState: context.read<UploadProjectBloc>().state.formProvider,
              formKey: context.read<UploadProjectBloc>().state.formKey,
              builder: (formProvider) => SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const HeadingText(
                      headingText: TranslationKeys.project,
                      subHeading: TranslationKeys.subHeading,
                    ),
                    const SizedBox(height: 24.0),
                    _buildProjectTitleFormSection(context, formProvider),
                    const SizedBox(height: 14.0),
                    // _tagProjectWithEmploymentChip(),
                    // const SizedBox(height: 14.0),
                    _buildClientFormSection(formProvider),
                    const SizedBox(height: 24.0),
                    _getProjectStatusChip(),
                    const SizedBox(height: 24.0),
                    _getStartEndDateFormFormSection(formProvider),
                    const SizedBox(height: 24.0),
                    _buildProjectDetailsFormSection(formProvider),
                    BlocBuilder<UploadProjectBloc, UploadProjectState>(
                      buildWhen: (previous, current) =>
                          previous.showMoreDetails != current.showMoreDetails,
                      builder: (context, state) {
                        if (!state.showMoreDetails) {
                          return _addMoreDetails(context);
                        }
                        return FormProvider(
                          formKey: state.addDetailsFormKey,
                          formState: state.addDetailsFormProvider,
                          builder: (formProvider) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _buildSkillSection(formProvider),
                              const SizedBox(height: 16.0),
                              _buildToolSection(formProvider),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16.0),
                    _saveButton(context),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectTitleFormSection(
      BuildContext context, ValueNotifier<FormProviderState> formState) {
    return BlocBuilder<UploadProjectBloc, UploadProjectState>(
        buildWhen: (previous, current) {
      return previous.projectTitleController.text !=
          current.projectTitleController.text;
    }, builder: (context, state) {
      return UnderlinedTextFieldWithButton(
        formState: formState,
        controller: state.projectTitleController,
        labelText: TranslationKeys.projectTitle,
        validator: ValidationBuilder(
                requiredMessage: "Project title cannot be left blank")
            .required()
            .build(),
      );
    });
  }

  Widget _getProjectSiteChip() {
    return BlocBuilder<UploadProjectBloc, UploadProjectState>(
        buildWhen: (previous, current) =>
            previous.projectSite != current.projectSite,
        builder: (context, state) {
          return PreSelectedChipWithHeading(
            heading: TranslationKeys.projectStatus,
            chips: state.projectSite,
            preSelectedItem: state.projectSite.first,
            onSubmitSelectedItem: (selectedItem) {},
          );
        });
  }

  Widget _getNatureOfEmploymentChip() {
    return BlocBuilder<UploadProjectBloc, UploadProjectState>(
        buildWhen: (previous, current) =>
            previous.employmentType != current.employmentType,
        builder: (context, state) {
          return PreSelectedChipWithHeading(
            heading: "Nature of employment",
            chips: state.employmentType,
            preSelectedItem: state.employmentType.first,
            onSubmitSelectedItem: (selectedItem) {},
          );
        });
  }

  Widget _tagProjectWithEmploymentChip() {
    return BlocBuilder<UploadProjectBloc, UploadProjectState>(
      buildWhen: (previous, current) =>
          previous.taggedProject != current.taggedProject,
      builder: (context, state) => PreSelectedChipWithHeading(
        chips: state.taggedProject,
        heading: "Tag project with employment / education",
        preSelectedItem: state.taggedProject.first,
        onSubmitSelectedItem: (String selectedItem) {},
      ),
    );
  }

  Widget _buildClientFormSection(ValueNotifier<FormProviderState> formState) {
    return BlocBuilder<UploadProjectBloc, UploadProjectState>(
        buildWhen: (previous, current) =>
            previous.clientDetailsController.text !=
            current.clientDetailsController.text,
        builder: (context, state) {
          return UnderlinedTextFieldWithButton(
            formState: formState,
            controller: state.clientDetailsController,
            labelText: TranslationKeys.clientTitle,
            validator: ValidationBuilder(
                    requiredMessage: "Client title cannot be left blank")
                .required()
                .build(),
          );
        });
  }

  Widget _getStartEndDateFormFormSection(
      ValueNotifier<FormProviderState> formState) {
    return BlocBuilder<UploadProjectBloc, UploadProjectState>(
        buildWhen: (previous, current) =>
            (previous.startDateController.text !=
                current.startDateController.text) ||
            (previous.projectStatus != current.projectStatus) ||
            (previous.endDateController.text != current.endDateController.text),
        builder: (context, state) {
          return IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: UnderlinedTextFieldWithButton(
                    textFieldType: TextFieldType.datePicker,
                    formState: formState,
                    controller: state.startDateController,
                    labelText: TranslationKeys.startDate,
                    hinText: TranslationKeys.workedFrom,
                    validator: ValidationBuilder(
                            requiredMessage: "Start Date Cannot be empty")
                        .required()
                        .build(),
                  ),
                ),
                const SizedBox(width: 12.0),
                if (state.projectStatus.isNotEmpty || state.projectStatus != '')
                  Expanded(
                    child: UnderlinedTextFieldWithButton(
                      textFieldType: TextFieldType.datePicker,
                      formState: formState,
                      controller: state.endDateController,
                      labelText: TranslationKeys.endDate,
                      hinText: TranslationKeys.workedTill,
                      validator: ValidationBuilder(
                              requiredMessage: "EndDate Cannot be empty")
                          .required()
                          .build(),
                    ),
                  ),
              ],
            ),
          );
        });
  }

  Widget _getProjectStatusChip() {
    return BlocBuilder<UploadProjectBloc, UploadProjectState>(
        buildWhen: (previous, current) =>
            previous.projectStatusList != previous.projectStatusList,
        builder: (context, state) {
          return PreSelectedChipWithHeading(
            heading: TranslationKeys.projectStatus,
            chips: state.projectStatusList,
            onSubmitSelectedItem: (String selectedItem) {
              context
                  .read<UploadProjectBloc>()
                  .add(SubmitProjectStatusEvent(selectedItem));
            },
          );
        });
  }

  Widget _addMoreDetails(BuildContext context) {
    return TextButton(
      onPressed: () {
        debugPrint("Called Add more details");
        context.read<UploadProjectBloc>().add(AddMorDetailsEvent());
      },
      child: Text(
        TranslationKeys.addMoreDetails,
        style: BaseTextStyle(
          color: ColorConstant.primary500,
          fontSize: TypographyTheme.paragraph_p3,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildProjectDetailsFormSection(
      ValueNotifier<FormProviderState> formState) {
    return BlocBuilder<UploadProjectBloc, UploadProjectState>(
        buildWhen: (previous, current) =>
            previous.projectDetailsController.text !=
            current.projectDetailsController.text,
        builder: (context, state) {
          return UnderlinedTextFieldWithButton(
            formState: formState,
            characterLimit: MinMax(0, 1000),
            controller: state.projectDetailsController,
            labelText: TranslationKeys.projectDetails,
            validator: ValidationBuilder(
                    requiredMessage: "Project details cannot be left blank")
                .required()
                .build(),
          );
        });
  }

  Widget _buildSkillSection(ValueNotifier<FormProviderState> formState) {
    return BlocBuilder<UploadProjectBloc, UploadProjectState>(
        buildWhen: (previous, current) =>
            previous.skillController.text != current.skillController.text,
        builder: (context, state) {
          return UnderlinedTextFieldWithButton(
            formState: formState,
            textFieldType: TextFieldType.bottomSheet,
            controller: state.skillController,
            labelText: TranslationKeys.skills,
            validator:
                ValidationBuilder(requiredMessage: "Skills  cannot be empty")
                    .required()
                    .build(),
          );
        });
  }

  Widget _buildToolSection(ValueNotifier<FormProviderState> formState) {
    return BlocBuilder<UploadProjectBloc, UploadProjectState>(
        buildWhen: (previous, current) =>
            previous.toolController.text != current.toolController.text,
        builder: (context, state) {
          return UnderlinedTextFieldWithButton(
            formState: formState,
            textFieldType: TextFieldType.bottomSheet,
            controller: state.toolController,
            labelText: TranslationKeys.tools,
            validator:
                ValidationBuilder(requiredMessage: "Tools  cannot be empty")
                    .required()
                    .build(),
          );
        });
  }

  Widget _saveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.read<UploadProjectBloc>().state.formProvider.value =
              FormProviderState.submitted;
          if (context
              .read<UploadProjectBloc>()
              .state
              .formKey
              .currentState!
              .validate()) {
            context
                .read<UploadProjectBloc>()
                .state
                .addDetailsFormProvider
                .value = FormProviderState.submitted;
            if (context
                .read<UploadProjectBloc>()
                .state
                .addDetailsFormKey
                .currentState!
                .validate()) {
              debugPrint("Called Save Project");
              context.read<UploadProjectBloc>().add(SaveProjectEvent());
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstant.primary500,
        ),
        child: Text(
          TranslationKeys.next,
          style: BaseTextStyle(
            color: ColorConstant.shade00,
            fontSize: TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
