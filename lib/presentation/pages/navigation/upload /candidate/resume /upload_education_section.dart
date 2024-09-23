import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/employment/employment_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/resume_navigation_page.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/upload_employment_section.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chip/chip_with_button_section.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/form/form_element.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../../../../core/resources/color_constants.dart';
import '../../../../../../core/resources/typography_theme.dart';
import '../../../../../bloc/dashboard/upload/candidate/education/education_bloc.dart';
import '../../../../../bloc/dashboard/upload/candidate/education/education_event.dart';
import '../../../../../bloc/dashboard/upload/candidate/education/education_state.dart';
import '../../../../../widgets/chat/chat_responder.dart';
import '../../../../../widgets/constants/text_style.dart';
import '../../../../../widgets/text/heading_text.dart';
import '../../../../../widgets/text_field/text_field_with_button.dart';

class UploadEducationSection extends StatelessWidget {
  const UploadEducationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EducationBloc(),
      child: BlocBuilder<EducationBloc, EducationState>(
        builder: (context, state) {
          return ResumeNavigation(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const HeadingText(
                            headingText: TranslationKeys.education,
                            subHeading: TranslationKeys.subHeading,
                          ),
                          const SizedBox(height: 16.0),
                          _buildSchoolSection(context , state) ,
                          const SizedBox(height: 16.0),
                          _buildDegreeChip(context, state) ,
                          const SizedBox(height: 16.0),
                          _buildSpecializationChip(context, state) ,
                          const SizedBox(height: 16.0),
                          _courseDurationSection(context , state),
                          const SizedBox(height: 16.0),
                          _nextButton(context)
                        ],
                      ),
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





  Widget _buildSchoolSection(BuildContext context ,EducationState state){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      child: UnderlinedTextFieldWithButton(
        controller: state.schoolController,
        isButtonEnable: state.schoolButtonEnabled,
        onTapNext: () {
          context.read<EducationBloc>().add(UpdateSchoolEvent(true));
        },
        labelText: 'School*',
        hinText: 'Enter your School Name',
      ),
    );
  }


  Widget _buildDegreeChip(BuildContext context, EducationState state) {
    return AnimatedOpacity(
      opacity: state.schoolNext? 1:0 ,
      duration:const  Duration(milliseconds: 700),
      child: AnimatedContainer(
        duration: const  Duration(milliseconds: 700),
        child: ChipWithButtonSection(
          title: TranslationKeys.degree,
          buttonEnabled: state.degreeButtonEnabled,
          items: state.degree,
          onSubmit: (qualification) {},
          onTapNext: () {
            context.read<EducationBloc>().add(UpdateDegreeEvent(true));
          },
          maxItemSelection: MinMax(0, 3),
        ),
      ),
    );
  }

  Widget _buildSpecializationChip(BuildContext context, EducationState state) {
    return AnimatedOpacity(
      opacity: state.degreeNext ? 1:0,
      duration: const Duration(milliseconds: 700),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        curve: Curves.bounceInOut,
        child: ChipWithButtonSection(
          buttonEnabled: state.specializationButtonEnabled,
          title: 'Specialization',
          items: state.specializations,
          onSubmit: (qualification) {},
          onTapNext: () {
            context.read<EducationBloc>().add(UpdateSpecializationEvent(true));
          },
          maxItemSelection: MinMax(0, 3),
        ),
      ),
    );
  }


  Widget _courseDurationSection(BuildContext context  , EducationState state){
    return AnimatedOpacity(
      opacity: state.specializationNext? 1:0,
      duration: const Duration(milliseconds: 700),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        child:
        FormElement(
          title: 'Course duration*',
         titleColor:  ColorConstant.neutral800,
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
                      controller: state.startingYearController,
                      hinText: 'Starting year',
                      onSubmit: (startingYear){
                        context.read<EducationBloc>().add(UpdateCourseDurationEvent(courseStartingYear: startingYear ,  courseEndingYear: state.endingYearController.text, onNext: false)) ;
                      },
                    ),
                  ),
                  const SizedBox(width: 12.0),
                    Expanded(
                      child: UnderlinedTextFieldWithButton(
                        textFieldType: TextFieldType.datePicker,
                        controller: state.endingYearController,
                        onSubmit: (endingYear){
                          context.read<EducationBloc>().add(UpdateCourseDurationEvent(courseStartingYear: state.startingYearController.text, courseEndingYear: endingYear, onNext: true)) ;
                        },
                        hinText: 'Ending year',
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return    BlocBuilder<EducationBloc , EducationState>(
      builder:(context , state)=> AnimatedOpacity(
        opacity: state.courseDurationNext ? 1:0,
        duration: const Duration(milliseconds: 700),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
          child: Padding(
            padding: const EdgeInsets.only(top: 36.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  context.read<EducationBloc>().add(SaveEmploymentDetails()) ;
                  context.navigator.push(MaterialPageRoute(builder: (_)=> BlocProvider<EmploymentBloc>(
                      create: (context)=> EmploymentBloc(),
                      child: const UploadEmploymentSection()))) ;
                } ,
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primary500),
                child: Text(
                  "Next",
                  style: BaseTextStyle(
                    color: ColorConstant.shade00,
                    fontSize: TypographyTheme.paragraph_p3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
