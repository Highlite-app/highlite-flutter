// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';

import '../../../core/resources/typography_theme.dart';
import '../../widgets/constants/text_style.dart';
import '../../widgets/list/policy_navigated_tile.dart';
import '../../widgets/navigation/navigated_page.dart';
import '../../widgets/profile/profile_picture.dart';

class EditProfilePrivacyPolicyPage extends StatefulWidget {
  final NavigatorState navigator;

  const EditProfilePrivacyPolicyPage({super.key, required this.navigator});

  @override
  State<EditProfilePrivacyPolicyPage> createState() =>
      _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<EditProfilePrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return NavigatedPage(
      title: "Privacy Policy",
      includesBorder: true,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: ColorConstant.shade00),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Column(
            children: [
              _profileOptions(context),
            ],
          ),
        ),
      ),
    );
  }

  Container _profileOptions(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ColorConstant.shade00,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            PolicyNavigatedTile(
                title: "About Us",
                onTap: () {
                  widget.navigator.push(MaterialPageRoute(
                    builder: (_) => PrivacyPolicyContentPage(
                      navigator: widget.navigator,
                      title: "About Us",
                      content: TranslationKeys.aboutUsContent,
                    ),
                  ));
                }),
            const Divider(),
            PolicyNavigatedTile(
                title: "Privacy Policy",
                onTap: () {
                  widget.navigator.push(MaterialPageRoute(
                    builder: (_) => PrivacyPolicyContentPage(
                      navigator: widget.navigator,
                      title: "Privacy Policy",
                      content: TranslationKeys.privacyPolicyContent,
                    ),
                  ));
                }),
            const Divider(),
            PolicyNavigatedTile(
                title: "Terms of Use",
                onTap: () {
                  widget.navigator.push(MaterialPageRoute(
                    builder: (_) => PrivacyPolicyContentPage(
                      navigator: widget.navigator,
                      title: "Terms of Use",
                      content: TranslationKeys.termsOfUseContent,
                    ),
                  ));
                }),
            const Divider(),
            PolicyNavigatedTile(
              title: "Open Source Library",
              onTap: () {
                widget.navigator.push(MaterialPageRoute(
                  builder: (_) => PrivacyPolicyContentPage(
                    navigator: widget.navigator,
                    title: "Open Source Library",
                    content: TranslationKeys.openSourceLibraryContent,
                  ),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  Container _profileHeader(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ColorConstant.shade00,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            ProfilePicture(
              size: 68,
              isPremiumUser: true,
              url: "",
            ),
            const SizedBox(width: 8),
            _profileInfos()
          ],
        ),
      ),
    );
  }

  Padding _profileInfos() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Srijan',
            // authState.candidateUser?.getName() ?? "",
            style: BaseTextStyle(
              fontSize: TypographyTheme.heading_H5,
              color: ColorConstant.primary900,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          Text(
            "Premium User",
            style: BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p3,
              color: ColorConstant.primary500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class PrivacyPolicyContentPage extends StatefulWidget {
  final NavigatorState navigator;
  final String title;
  final String content;

  const PrivacyPolicyContentPage(
      {super.key,
      required this.navigator,
      required this.title,
      required this.content});

  @override
  State<PrivacyPolicyContentPage> createState() =>
      _PrivacyPolicyContentPageState();
}

class _PrivacyPolicyContentPageState extends State<PrivacyPolicyContentPage> {
  @override
  Widget build(BuildContext context) {
    return NavigatedPage(
      title: widget.title,
      includesBorder: true,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: ColorConstant.shade00,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                widget.content,
                style: BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p3,
                  color: ColorConstant.neutral800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _profileOptions(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ColorConstant.shade00,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          PolicyNavigatedTile(title: "About Us", onTap: () {}),
          const Divider(),
          PolicyNavigatedTile(title: "Privacy Policy", onTap: () {}),
          const Divider(),
          PolicyNavigatedTile(title: "Terms of Use", onTap: () {}),
          const Divider(),
          PolicyNavigatedTile(
            title: "Open Source Library",
            onTap: () {
              // context.navigator.pop();
              // context.read<AuthBloc>().add(const LogoutEvent());
              // context.read<VideoFeedBloc>().add(const AllowPreloadEvent());
              // context.navigator.popAndPushNamed(OnboardingSplash.routeName);
            },
          ),
        ],
      ),
    );
  }

  Container _profileHeader(
    BuildContext context,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ColorConstant.shade00,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            ProfilePicture(
              size: 68,
              isPremiumUser: true,
              url: "",
            ),
            const SizedBox(width: 8),
            _profileInfos()
          ],
        ),
      ),
    );
  }

  Padding _profileInfos() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Srijan Mukhopadhyay",
            style: BaseTextStyle(
              fontSize: TypographyTheme.heading_H5,
              color: ColorConstant.primary900,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          Text(
            "Premium User",
            style: BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p3,
              color: ColorConstant.primary500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
