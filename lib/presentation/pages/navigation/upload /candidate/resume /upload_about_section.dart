import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/about/candidate_about_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/about/candidate_about_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/about/candidate_about_state.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/resume_navigation_page.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/upload_education_section.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/form/form.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/text/heading_text.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../../../widgets/chat/chat_responder.dart';
import '../../../../../widgets/chip/chip_with_button_section.dart';
import '../../../../../widgets/text_field/form_field.dart';

class UploadCandidateAboutSection extends StatefulWidget {
  final List<String> languages;
  final MinMax<int> maxLanguageSelection;

  final Function(List<String> selectedLanguage) onSubmitSelectedLanguage;

  const UploadCandidateAboutSection(
      {required this.languages,
      required this.maxLanguageSelection,
      required this.onSubmitSelectedLanguage,
      super.key});

  @override
  State<UploadCandidateAboutSection> createState() => _UploadCandidateAboutSectionState();
}

class _UploadCandidateAboutSectionState extends State<UploadCandidateAboutSection> {
  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<CandidateUploadAboutBloc, CandidateUploadAboutState>(
      builder: (context, state) => ResumeNavigation(children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FormProvider(
              formKey:state.formKey ,
              formState: state.formState,
              builder:(formState)=>  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadingText(
                      headingText: TranslationKeys.about,
                      subHeading: TranslationKeys.subHeading),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CustomFormField(
                    formState: formState,
                    title: TranslationKeys.tellAboutYourself,
                    placeholderText: TranslationKeys.shareABriefAboutYourself,
                    height: MinMax(0, 150),
                    characterLimit: MinMax(0, 150),
                    minMaxLines: MinMax(1, 30),
                    textController: state.aboutController,
                    value: state.aboutController.text,
                    validator: ValidationBuilder(
                            requiredMessage: "Please enter your details")
                        .required()
                        .build(),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  if (!state.onNextAbout)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          state.formState.value = FormProviderState.submitted ;
                          if(state.formKey.currentState!.validate()){
                            context
                                .read<CandidateUploadAboutBloc>()
                                .add(SubmitAboutFormEvent());
                          }

                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.primary500),
                        child: Text(
                          TranslationKeys.next,
                          style: BaseTextStyle(
                            color: ColorConstant.shade00,
                            fontSize: TypographyTheme.paragraph_p3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  AnimatedOpacity(
                    opacity: state.onNextAbout ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 700),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeInOut,
                      height: state.onNextAbout ? null : 0,
                      child: state.onNextAbout
                          ? ChipWithButtonSection(
                             chipWithButtonType: ChipWithButtonType.formField,
                              aboutText: state.aboutController,
                              title: TranslationKeys.languages,
                              buttonEnabled: true,
                              items: widget.languages,
                              onSubmit: (selectedLanguage) {
                                FocusScope.of(context).unfocus();
                                widget.onSubmitSelectedLanguage(selectedLanguage);
                                context.read<CandidateUploadAboutBloc>().add(LanguagesSelectionEvent(selectedLanguage: selectedLanguage) ) ;

                              },
                              maxItemSelection: widget.maxLanguageSelection,
                              onTapNext: () {
                                state.formState.value = FormProviderState.submitted ;
                                if(state.formKey.currentState!.validate()){
                                  context.read<CandidateUploadAboutBloc>().add(SubmitEvent());
                                  context.navigator.push(MaterialPageRoute(
                                      builder: (_) =>
                                      const UploadEducationSection()));
                                }

                              },
                            )
                          : Container(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
