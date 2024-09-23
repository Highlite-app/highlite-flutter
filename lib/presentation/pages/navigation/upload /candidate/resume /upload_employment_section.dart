import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/project/project_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/project_confirmation.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/resume_navigation_page.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/upload_project_section.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/primary_button.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chip/preselected_chip_with_heading.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../../../../core/resources/color_constants.dart';
import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../../core/resources/typography_theme.dart';
import '../../../../../bloc/dashboard/upload/candidate/employment/employment_bloc.dart';
import '../../../../../bloc/dashboard/upload/candidate/employment/employment_event.dart';
import '../../../../../bloc/dashboard/upload/candidate/employment/employment_state.dart';
import '../../../../../widgets/constants/text_style.dart';
import '../../../../../widgets/form/form_element.dart';
import '../../../../../widgets/text/heading_text.dart';
import '../../../../../widgets/text_field/text_field_with_button.dart';

class UploadEmploymentSection extends StatelessWidget {
  const UploadEmploymentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmploymentBloc(),
      child: BlocBuilder<EmploymentBloc, EmploymentState>(
        builder: (context, state) {
          return ResumeNavigation(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const HeadingText(
                          headingText: "Employment",
                          subHeading:
                              "These details help recruiters understand your\nprofessional experience",
                        ),
                        const SizedBox(height: 16.0),
                        _buildEmploymentStatusChip(context, state),
                        const SizedBox(height: 16.0),
                        _buildEmploymentType(context, state),
                        const SizedBox(height: 16.0),
                        _buildCurrentJobTitleSection(context, state),
                        const SizedBox(height: 16.0),
                        _buildCurrentCompanySection(context, state),
                        const SizedBox(height: 16.0),
                        _buildTotalExperienceSection(context, state),
                        const SizedBox(height: 16.0),
                        _buildOnNextButton(context, state),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmploymentStatusChip(
      BuildContext context, EmploymentState state) {
    return PreSelectedChipWithHeading(
      chips: const ["Yes", "No"],
      preSelected: false,
      heading: 'Are you currently employed',
      isButtonEnabled: state.isCurrentEmployedButtonEnabled,
      onSubmitSelectedItem: (status) {
        print("The status is :: ${status}");
        var employmentStatus = status;
        context
            .read<EmploymentBloc>()
            .add(UpdateCurrentEmploymentEvent(employmentStatus, false));
      },
      onTapNext: () {
        context.read<EmploymentBloc>().add(UpdateCurrentEmploymentEvent(
                state.employmentStatus, true, onUnemployed: () {
              context.navigator.push(MaterialPageRoute(
                  builder: (_) => const ProjectConfirmation()));
            }));
      },
    );
  }

  Widget _buildEmploymentType(BuildContext context, EmploymentState state) {
    return AnimatedOpacity(
      opacity: state.onCurrentEmploymentNext ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 700),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        child: PreSelectedChipWithHeading(
          preSelected: true,
          heading: 'What is your employment type?',
          isButtonEnabled: state.employmentTypeButtonEnabled,
          chips: const ["Full-time", "Part-time", 'Hybrid'],
          onSubmitSelectedItem: (status) {
            print("The employment Type is :: ${status}");
            context
                .read<EmploymentBloc>()
                .add(UpdateEmploymentTypeEvent(status, false));
          },
          onTapNext: () {
            context
                .read<EmploymentBloc>()
                .add(UpdateEmploymentTypeEvent(state.employmentType, true));
          },
        ),
      ),
    );
  }

  Widget _buildCurrentJobTitleSection(
      BuildContext context, EmploymentState state) {
    return AnimatedOpacity(
      opacity: state.employmentTypeNext ? 1 : 0,
      duration: const Duration(milliseconds: 700),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        child: UnderlinedTextFieldWithButton(
          controller: state.currentJobTitleController,
          isButtonEnable: state.isJobTitleButtonEnabled,
          labelText: 'Current job title*',
          hinText: 'Enter your current job title',
          onTapNext: () {
            context.read<EmploymentBloc>().add(UpdateCurrentJobTitleEvent(
                state.currentJobTitleController.text, true));
          },
        ),
      ),
    );
  }

  Widget _buildCurrentCompanySection(
      BuildContext context, EmploymentState state) {
    return AnimatedOpacity(
      opacity: state.onJobTitleNext ? 1 : 0,
      duration: const Duration(milliseconds: 700),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        child: UnderlinedTextFieldWithButton(
          controller: state.currentCompanyController,
          isButtonEnable: state.isCompanyButtonEnabled,
          labelText: 'Current company name*',
          hinText: 'Enter your current company name',
          onTapNext: () {
            context.read<EmploymentBloc>().add(UpdateCurrentCompanyNameEvent(
                state.currentCompanyController.text, true));
          },
        ),
      ),
    );
  }

  Widget _buildTotalExperienceSection(
      BuildContext context, EmploymentState state) {
    return AnimatedOpacity(
      opacity: state.onCompanyNext ? 1 : 0,
      duration: const Duration(milliseconds: 700),
      child: FormElement(
        title: 'Total work experience*',
        titleColor: ColorConstant.neutral700,
        hasErrors: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: UnderlinedTextFieldWithButton(
                    textFieldType: TextFieldType.datePicker,
                    controller: state.workedFromController,
                    hinText: TranslationKeys.workedFrom,
                    onSubmit: (value){
                    context.read<EmploymentBloc>().add(UpdateTotalExperienceEvent(value, state.workedTillController.text, false)) ;
                    },
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: UnderlinedTextFieldWithButton(
                    textFieldType: TextFieldType.datePicker,
                    controller: state.workedTillController,
                    hinText: TranslationKeys.workedTill,
                    onSubmit: (value){
                      print("The value is : $value") ;
                      if( value !=null && value.isNotEmpty) context.read<EmploymentBloc>().add(UpdateTotalExperienceEvent(state.workedFromController.text, value , true)) ;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOnNextButton(BuildContext context, EmploymentState state) {
    return AnimatedOpacity(
      opacity: state.onTotalExperienceNext? 1:0,
      duration: const Duration(milliseconds: 700),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
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
              onPressed: () {
                context.read<EmploymentBloc>().add(SaveEmploymentDetails()) ;
                context.navigator.push(MaterialPageRoute(
                    builder: (_) => const ProjectConfirmation()));
              }),
        ),
      ),
    );
  }
}
