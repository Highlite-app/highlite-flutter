import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/resume_navigation_page.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../../../../core/resources/color_constants.dart';
import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../../core/resources/typography_theme.dart';
import '../../../../../widgets/chat/chat_responder.dart';
import '../../../../../widgets/constants/text_style.dart';
import '../../../../../widgets/form/form.dart';
import '../../../../../widgets/text/heading_text.dart';
import '../../../../../widgets/text_field/form_field.dart';
import 'company_size.dart';

class OurServices extends StatefulWidget {
  OurServices({super.key});

  @override
  State<OurServices> createState() => _OurServicesState();
}

class _OurServicesState extends State<OurServices> {
  final TextEditingController serviceController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ValueNotifier<FormProviderState> formProvider =
      ValueNotifier(FormProviderState.empty);

  @override
  void initState() {
    serviceController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResumeNavigation(children: [
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FormProvider(
            formKey: formKey,
            formState: formProvider,
            builder: (formState) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeadingText(
                  headingText: TranslationKeys.ourServices,
                  subHeading: TranslationKeys.subHeadingCompany,
                ),
                const SizedBox(height: 16.0),
                CustomFormField(
                  formState: formState,
                  title: TranslationKeys.tellAboutYourself,
                  placeholderText: TranslationKeys.shareABriefAboutYourself,
                  height: MinMax(0, 150),
                  characterLimit: MinMax(0, 150),
                  minMaxLines: MinMax(1, 30),
                  textController: serviceController,
                  value: serviceController.text,
                  validator: ValidationBuilder(
                          requiredMessage: "services cannot be empty")
                      .required()
                      .build(),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                if (serviceController.text.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        formState.value = FormProviderState.submitted;
                        if (formKey.currentState!.validate()) {
                          context.navigator.push(
                              MaterialPageRoute(builder: (_) => const CompanySize()));
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
                  )
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
