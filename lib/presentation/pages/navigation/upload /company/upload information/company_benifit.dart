
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/upload%20/candidate/resume%20/resume_navigation_page.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/chat_responder.dart';

import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../widgets/chip/chip_with_button_section.dart';
import '../../../../../widgets/form/form.dart';
import '../../../../../widgets/text/heading_text.dart';
class CompanyBenefits extends StatefulWidget {
  const CompanyBenefits({super.key});

  @override
  State<CompanyBenefits> createState() => _CompanyBenefitsState();
}

class _CompanyBenefitsState extends State<CompanyBenefits> {
  @override
  Widget build(BuildContext context) {
    return  ResumeNavigation(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeadingText(
                    headingText: TranslationKeys.benefits,
                    subHeading: TranslationKeys.subHeadingCompany),
                const SizedBox(
                  height: 16.0,
                ),
                ChipWithButtonSection(
                    chipWithButtonType: ChipWithButtonType.normal,
                    title: "Benefits",
                    buttonEnabled: true,
                    items:[ "Work From Home" , "International Relocation" ,"Health Insurance" ,"Relocation" ,  "Others" , "Travel" ],
                    onSubmit: (selectedLanguage) {


                    },
                    maxItemSelection: MinMax(0,3),
                    onTapNext: () {

                    }
                )


              ],
            ),
          ),
        ),
      ],

    );
  }
}
