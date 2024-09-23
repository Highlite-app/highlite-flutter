import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:form_validator/form_validator.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/resume_navigation_page.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../widgets/text/heading_text.dart';
import '../../../../../widgets/text_field/text_field_with_button.dart';
import 'company_benifit.dart';

class CompanySize extends StatefulWidget {
  const CompanySize({super.key});

  @override
  State<CompanySize> createState() => _CompanySizeState();
}

class _CompanySizeState extends State<CompanySize> {
  @override
  Widget build(BuildContext context) {
    return ResumeNavigation(children: [
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadingText(
                  headingText: TranslationKeys.companySize,
                  subHeading: TranslationKeys.subHeadingCompany),
              const SizedBox(height: 24.0),
              Text(
                "Company Size*",
                style: BaseTextStyle(
                    color: ColorConstant.neutral600,
                    fontSize: TypographyTheme.paragraph_p4,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8.0),
              ConstrainedBox(
                constraints: const BoxConstraints(
                    maxWidth: 360, minHeight: 80, maxHeight: 80, minWidth: 360),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorConstant.neutral200,
                                style: BorderStyle.solid),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstant.primary500,
                                  style: BorderStyle.solid))),
                    )),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorConstant.neutral200,
                                style: BorderStyle.solid),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstant.primary500,
                                  style: BorderStyle.solid))),
                    )),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();

                    context.navigator.push(
                        MaterialPageRoute(builder: (_) => CompanyBenefits()));
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
      )
    ]);
  }
}
