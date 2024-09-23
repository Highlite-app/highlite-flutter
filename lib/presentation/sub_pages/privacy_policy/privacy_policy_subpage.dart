import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../../widgets/constants/text_style.dart';
import '../../widgets/drawer/content/content_subpage.dart';

class PrivacyPolicySubpage extends StatelessWidget {
  final perLineSpacing = 16.0;

  const PrivacyPolicySubpage({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      title: "Privacy Policy",
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
          "Welcome to Highlite!"
          "\n\nWe take your privacy seriously and are committed to protecting the personal information of all our users. This Privacy Policy explains how we collect, use, and share information about you when you use our mobile application and our services.",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral800,
            fontSize: TypographyTheme.paragraph_p3,
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "1. Information We Collect",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p2,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: perLineSpacing),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: EasyRichText(
            "1.1. Information You Provide",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral900,
              fontSize: TypographyTheme.paragraph_p3,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: EasyRichText(
            "• Account Information: When you create an account, we collect information such as your email address, username, and password."
            "\n• Profile Information: You may choose to provide additional information for your profile, like a profile picture or bio."
            "\n• Content: We collect the content you create and share on our platform, including photos, videos, and comments.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: EasyRichText(
            "1.2. Information We Collect Automatically",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral900,
              fontSize: TypographyTheme.paragraph_p3,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: EasyRichText(
            "• Usage Information: We collect information about your activity on Highlite, such as the features you use and the interactions you have."
            "\n• Device Information: We collect information about the device you use to access Highlite, including the device model, operating system, and unique device identifiers."
            "\n• Location Information: With your consent, we may collect information about the location of your device.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "2. How We Use Your Information",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p2,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: perLineSpacing),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: EasyRichText(
            "We use the information we collect to:",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: EasyRichText(
            "• Provide, maintain, and improve our services."
            "\n• Personalize your experience on Highlite."
            "\n• Respond to your comments, questions, and requests."
            "\n• Send you technical notices, updates, security alerts, and support messages.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "3. Sharing Your Information",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p2,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: perLineSpacing),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: EasyRichText(
            "We may share your information:",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: EasyRichText(
            "• With third parties who perform services on our behalf."
            "\n• In response to a request for information if we believe disclosure is in accordance with applicable law, regulation, or legal process."
            "\n• With your consent or at your direction.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "4. Your Choices",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p2,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: EasyRichText(
            "• Account Information: You may update or correct your account information at any time by logging into your account settings."
            "\n• Location Information: You can choose whether or not to allow the app to collect and use information about your device's location.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "5. Security",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p2,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: EasyRichText(
            "•We take reasonable measures to help protect information about you from loss, theft, misuse, and unauthorized access, disclosure, alteration, and destruction.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "6. Changes to This Policy",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p2,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: EasyRichText(
            "• We may revise this Privacy Policy from time to time. If we make changes, we will notify you by revising the date at the top of the policy.",
            defaultStyle: BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
        SizedBox(height: perLineSpacing),
        EasyRichText(
          "7. Contact Us",
          defaultStyle: BaseTextStyle(
            color: ColorConstant.neutral900,
            fontSize: TypographyTheme.paragraph_p2,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: EasyRichText(
            "• If you have any questions about this Privacy Policy, please contact us at support@highlite.com",
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
