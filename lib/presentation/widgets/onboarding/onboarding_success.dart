import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/general/general_flow.dart';
import '../../../core/resources/spacing_theme.dart';
import '../../../core/resources/typography_theme.dart';
import '../../../data/models/onboardingChat/flows/candidate/candidate_steps.dart';
import '../buttons/primary_button.dart';
import '../constants/text_style.dart';

Future<void> showOnboardingSuccess(String firstName, VoidCallback completion) =>
    Get.bottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Spacing.spacing_big),
          topRight: Radius.circular(Spacing.spacing_big),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      useRootNavigator: true,
     OnboardingSuccessView(
          name: firstName,
          onComplete: () async {
            Get.close(0);
            completion();
          },
    ));

class OnboardingSuccessView extends StatelessWidget {
  final String name;
  final VoidCallback onComplete;

  const OnboardingSuccessView(
      {super.key, required this.name, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: ColorConstant.shade00,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: Spacing.spacing_lg,
              bottom: 60.0
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image.asset(AssetConstant.checkMarkCircle),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                   "Welcome ${CandidateTags.firstName}!",
                    textAlign: TextAlign.center,
                    style:  BaseTextStyle(
                      fontSize: TypographyTheme.heading_H5,
                      fontWeight: FontWeight.w600,
                      color: ColorConstant.neutral900,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: Spacing.spacing_x_big),
                  child: Text(
                   TranslationKeys.onboardingSuccessViewDescription,
                    style:  BaseTextStyle(
                      fontSize: TypographyTheme.paragraph_p3,
                      color: ColorConstant.neutral600,
                    ),
                  ),
                ),
                PrimaryButton(title: TranslationKeys.letsGo, onTap: onComplete, horizontalPadding: 20.0,)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
