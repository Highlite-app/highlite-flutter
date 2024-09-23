import 'package:app_settings/app_settings.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_state.dart';
import 'package:highlite_flutter_mvp/presentation/pages/onboarding/onboarding_splash_screen.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';
import 'package:sizer/sizer.dart';

import '../../../../../app.dart';
import '../../../../../core/constants/user_types.dart';
import '../../../../../core/resources/typography_theme.dart';
import '../../../../bloc/dashboard/auth/authentication_event.dart';
import '../../../../sub_pages/help_and_support/help_and_support_page.dart';
import '../../../../sub_pages/privacy_policy/privacy_policy_page.dart';
import '../../../../sub_pages/settings/account_info_page.dart';
import '../../../../sub_pages/settings/subscriptions_page.dart';
import '../../../../sub_pages/settings/upgrade_page.dart';
import '../../../../widgets/buttons/tag_chip_button.dart';
import '../../../../widgets/constants/text_style.dart';
import '../../../../widgets/list/navigated_tile.dart';
import '../../../../widgets/navigation/navigated_page.dart';
import '../../../../widgets/profile/profile_picture.dart';
import '../../../../widgets/svg/svg_asset.dart';
import '../../../../widgets/text_field/neutral_field.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigatedPage(
      backgroundColor: ColorConstant.neutral50,
      title: "Settings",
      includesBorder: true,
      child: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SettingsHeader(),
                SizedBox(height: 24),
                SettingsOptions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc , AuthenticationState>(
      builder: (context , authState) {
        return Container(
          decoration: BoxDecoration(
            color: ColorConstant.shade00,
            borderRadius: BorderRadius.circular(12),
          ),
          child:  Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ProfilePicture(
                      size: 68,
                      isPremiumUser: true,
                      isSuperPremiumUser: true,
                      url:
                      (authState.userType == UserTypes.candidate
                          ? authState.candidate?.profilePicture ?? ""
                          : authState.companyProfile?.companyLogo ?? ""),
                      ),
                ),
                SizedBox(width: 4),
                Expanded(flex: 3, child:  ProfileInfos()),
              ],
            ),
          ),
        );
      }
    );
  }
}

class ProfileInfos extends StatelessWidget {
  const ProfileInfos({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: BlocBuilder<AuthenticationBloc , AuthenticationState>(
          builder: (context , authState) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    authState.userType == UserTypes.candidate
                        ? authState.candidate?.fullName ?? ""
                        : authState.companyProfile?.companyName ?? "",
                    style: BaseTextStyle(
                      fontSize: TypographyTheme.heading_H5,
                      color: ColorConstant.primary900,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Free Member",
                        style: BaseTextStyle(
                            fontSize: TypographyTheme.paragraph_p3,
                            color: ColorConstant.neutral600,
                            fontWeight: FontWeight.w500,
                            height: 1.2),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // if (state.currentPackage.subscriptionType ==
                      //     SubscriptionTiers.freeTier)

                      ActionChip(
                        onPressed: () {
                          context.navigator.push(MaterialPageRoute(
                            builder: (_) => const UpgradeSubscriptionPage(),
                          ));
                        },
                        backgroundColor: ColorConstant.primary500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100) ,
                          side: const BorderSide(color: Colors.white)
                        ),
                        label: Text(
                          'Upgrade',
                          style: BaseTextStyle(
                            fontSize: TypographyTheme.paragraph_p1,
                            color: ColorConstant.shade00,
                            fontWeight: FontWeight.w600,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]);
          }
        ));
  }
}

class SettingsOptions extends StatelessWidget {
  const SettingsOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        color: ColorConstant.shade00,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          NavigatedTile(
            asset: AssetConstant.userIcon,
            title: "Account Info",
            onTap: () {
              context.navigator.push(MaterialPageRoute(
                builder: (_) => const AccountInfoPage(),
              ));
            },
          ),
          const Divider(
            color: ColorConstant.neutral100,
          ),
          NavigatedTile(
            asset: AssetConstant.zapIcon,
            title: "My Subscriptions",
            onTap: () {
              context.navigator.push(MaterialPageRoute(
                builder: (_) => const SubscriptionsPage(),
              ));
            },
          ),
          const Divider(
            color: ColorConstant.neutral100,
          ),
          NavigatedTile(
            asset: AssetConstant.notificationIcon,
            title: "Notifications",
            onTap: () async {
              await AppSettings.openAppSettings(
                  type: AppSettingsType.notification);
            },
          ),
          const Divider(
            color: ColorConstant.neutral100,
          ),
          NavigatedTile(
            asset: AssetConstant.privacyPolicyIcon,
            title: "Documentation",
            onTap: () {
              context.navigator.push(MaterialPageRoute(
                builder: (_) => const PrivacyPolicyPage(),
              ));
            },
          ),
          const Divider(
            color: ColorConstant.neutral100,
          ),
          NavigatedTile(
            asset: AssetConstant.helpIcon,
            title: "Help & Support",
            onTap: () {
              context.navigator.push(MaterialPageRoute(
                builder: (_) => const HelpAndSupportPage(),
              ));
            },
          ),
          const Divider(
            color: ColorConstant.neutral100,
          ),
          NavigatedTile(
            asset: AssetConstant.deleteAccountIcon,
            title: "Delete Account",
            onTap: () async {
              _showDeleteDialog(context);
            },
          ),
          const Divider(
            color: ColorConstant.neutral100,
          ),
          NavigatedTile(
            asset: AssetConstant.logoutIcon,
            title: "Logout",
            onTap: () {
              _showLogoutDialog(context);
            },
          )
        ],
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext ctx) async {
    await showCupertinoModalPopup<void>(
      context: ctx,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          "Are you sure you want to logout?",
          style: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p2,
            color: ColorConstant.neutral800,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () async {
              Navigator.of(context).pop();
            },
            child: Text(
              TranslationKeys.cancel,
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p2,
                color: ColorConstant.primary500,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
              ctx.navigator.pop();
              authentication.add(const LogoutEvent());
              globalNavKey.currentState!.push(MaterialPageRoute(builder: (_)=> const OnboardingSplash()));
            },
            child: Text(
              "Logout",
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p2,
                color: ColorConstant.primary500,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteDialog(BuildContext ctx) async {
    await showCupertinoModalPopup<void>(
      context: ctx,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(
          "Are you sure you want to delete your account?",
          style: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p2,
            color: ColorConstant.neutral800,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          "Once you delete your account, you won’t be able to get it back.",
          style: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p3,
            color: ColorConstant.neutral800,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () async {
              Navigator.of(context).pop();
            },
            child: Text(
              TranslationKeys.cancel,
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p2,
                color: ColorConstant.primary500,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              context.navigator.pop();
              _showDeleteConfirmationDialog(ctx);
            },
            child: Text(
              "Delete",
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p2,
                color: ColorConstant.destructive500,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
    BuildContext ctx,
  ) async {
    TextEditingController controller = TextEditingController();
    FocusNode node = FocusNode();
    final name = authService.persistedUser!.userType == UserTypes.company
        ? "company name"
        : "full name";

    await showCupertinoModalPopup<void>(
      context: ctx,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (context, setState) {
          controller.addListener(() {
            setState(() {});
          });
          return CupertinoAlertDialog(
            title: Text(
              "Are you sure you want to delete your account?",
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p2,
                color: ColorConstant.neutral800,
                fontWeight: FontWeight.w700,
              ),
            ),
            content: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SvgAsset(asset: AssetConstant.alertIcon, size: 24),
                    const SizedBox(
                      width: 8.0,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 192),
                      child: EasyRichText(
                        "Once you delete your account, all your data will be erased from the database and you won’t be get it back.",
                        textAlign: TextAlign.start,
                        defaultStyle: BaseTextStyle(
                          fontSize: TypographyTheme.paragraph_p3,
                          color: ColorConstant.neutral800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgAsset(
                      asset: AssetConstant.deleteIcon,
                      size: 24,
                      color: ColorConstant.destructive500,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 192),
                      child: EasyRichText(
                        "Type your $name below to permanently delete your account.",
                        textAlign: TextAlign.start,
                        defaultStyle: BaseTextStyle(
                          fontSize: TypographyTheme.paragraph_p3,
                          color: ColorConstant.neutral800,
                          fontWeight: FontWeight.w500,
                        ),
                        patternList: [
                          EasyRichTextPattern(
                            targetString: 'permanently delete your account',
                            style: BaseTextStyle(
                              fontSize: TypographyTheme.paragraph_p3,
                              color: ColorConstant.neutral800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                NeutralField(
                  node: node,
                  placeholderText: authService.getName(),
                  controller: controller,
                )
              ],
            ),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: BaseTextStyle(
                    fontSize: TypographyTheme.paragraph_p2,
                    color: ColorConstant.primary500,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              CupertinoDialogAction(
                onPressed: controller.text == authService.getName() ?
                    () {
                  context.navigator.push(MaterialPageRoute(builder:(_)=> OnboardingSplash()) );
                }: null,
                child: Text(
                  "Delete",
                  style: BaseTextStyle(
                    fontSize: TypographyTheme.paragraph_p2,
                    color: controller.text == authService.getName()
                        ? ColorConstant.destructive500
                        : ColorConstant.neutral500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
