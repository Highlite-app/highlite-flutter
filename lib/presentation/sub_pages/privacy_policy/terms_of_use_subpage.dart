import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../../widgets/constants/text_style.dart';
import '../../widgets/drawer/content/content_subpage.dart';

class TermsOfUseSubpage extends StatelessWidget {
  final perLineSpacing = 16.0;

  const TermsOfUseSubpage({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      title: "Terms of Use",
      children: [
        EasyRichText(
          "Last Updated: 2023-10-28",
          softWrap: false,
          defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p4,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "1. Acceptance of Terms",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: EasyRichText(
            "• 1.1 Agreement: By accessing or using the Highlite mobile application, you agree to comply with and be bound by these Terms of Use and our Privacy Policy."
            "\n• 1.2 Changes: We reserve the right to modify these terms at any time. Your continued use of Highlite after any such changes constitutes your acceptance of the new terms.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "2. Use of Highlite",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: EasyRichText(
            "• 2.1 License: We grant you a limited, non-exclusive, non-transferable, and revocable license to use Highlite according to these terms."
            "\n• 2.2 Restrictions: You may not use Highlite for any illegal or unauthorized purpose.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "3. User Accounts",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: EasyRichText(
            "• 3.1 Registration: To use certain features of Highlite, you must register for an account."
            "\n• 3.2 Responsibility: You are responsible for maintaining the confidentiality of your account information.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "4. User Content",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: EasyRichText(
            "• 4.1 Ownership: You retain ownership of the content you submit to Highlite."
            "\n• 4.2 License to Us: You grant us a license to use, display, and distribute your content in connection with Highlite.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "5. Prohibited Conduct",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: EasyRichText(
            "• Listing specific types of conduct that are not allowed on Highlite.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "6. Termination",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: EasyRichText(
            "• 6.1 By Us: We may terminate or suspend your access to Highlite at any time, without notice, for conduct that we believe violates these terms or is harmful to other users of Highlite, us, or third parties, or for any other reason."
            "\n• 6.2 By You: You may stop using Highlite at any time.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "7. Disclaimers",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: EasyRichText(
            "• Highlite is provided “as is” without any warranties, express or implied.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "8. Limitation of Liability",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: EasyRichText(
            "• Our liability to you is limited to the maximum extent permitted by law.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "9. Indemnification",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: EasyRichText(
            "• You agree to indemnify and hold us harmless from any claims arising out of your breach of these terms or your use of Highlite.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "10. Governing Law",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: EasyRichText(
            "• These terms are governed by the laws of the jurisdiction in which you reside.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "11. Dispute Resolution",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: EasyRichText(
            "• Any disputes arising out of these terms will be resolved through arbitration.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "12. Contact Information",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: EasyRichText(
            "• If you have any questions about these terms, please contact us at [Insert Contact Information].",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
      ],
    );
  }
}
