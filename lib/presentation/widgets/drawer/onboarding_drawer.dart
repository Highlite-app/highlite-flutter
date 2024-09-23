import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/core/routes/route_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../svg/svg_asset.dart';
import 'drawer_container.dart';
import 'onboarding_drawer_tile.dart';

class OnboardingDrawer extends StatefulWidget {
  final bool isLogin;
  final VoidCallback reset;
  const OnboardingDrawer({
    super.key,
    required this.reset,
    required this.isLogin,
  });

  @override
  State<OnboardingDrawer> createState() => _OnboardingDrawerState();
}

class _OnboardingDrawerState extends State<OnboardingDrawer> {
  String version = "";
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1)).then((value) async {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      setState(() {
        this.version = "$version($buildNumber)";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DrawerContainer(
      bottomChild:
          VersionFooter(title: "AppVersion $version", icon: AssetConstant.highLiteLogoSM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const OnboardingDrawerTop(),
          OnboardingDrawerTile(
              title: TranslationKeys.provideFeedback,
              icon: AssetConstant.messageChatIcon,
              onTap: () {
                Navigator.pushNamed(
                    context, RouteConstants.provideFeedbackSubpage);
              },
          ),
          const SizedBox(height: 1),
          OnboardingDrawerTile(
              title: TranslationKeys.contactSupport,
              icon: AssetConstant.headphoneIcon,
              onTap: () {
                Navigator.pushNamed(context, RouteConstants.reportFeedbackSubpage);
              }),
          const SizedBox(height: 1),
          OnboardingDrawerTile(
              title: TranslationKeys.startOver,
              icon: AssetConstant.refreshIcon,
              onTap: ()async {
                widget.reset();
                Future.delayed(const Duration(microseconds: 200),(){
                  if(context.mounted){
                    Scaffold.of(context).closeDrawer() ;
                  }

                });

              }),
          const SizedBox(height: 1),
          if (!widget.isLogin)
            OnboardingDrawerTile(
              title: TranslationKeys.login,
              icon: AssetConstant.loginIcon,
              onTap: () {
          Navigator.pushNamed(context, RouteConstants.onBoardingChatLogin) ;
              },
            ),
          if (widget.isLogin)
            OnboardingDrawerTile(
              title: "signup",
              icon: AssetConstant.loginIcon,
              onTap: () {
                Navigator.pushNamed(context, RouteConstants.onBoardingChat) ;
              },
            ),
        ],
      ),
    );
  }
}

class OnboardingDrawerTop extends StatelessWidget {
  const OnboardingDrawerTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon:
                 const SvgAsset(asset: AssetConstant.closeIcon, color: ColorConstant.neutral800),
            onPressed: () {
              Scaffold.of(context).closeDrawer();
            },
          ),
        ],
      ),
    );
  }
}

class VersionFooter extends StatelessWidget {
  final String title;
  final String icon;
  const VersionFooter({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              title: Text(
                title,
                style:  BaseTextStyle(
                    fontSize: TypographyTheme.paragraph_p4,
                    color: ColorConstant.neutral700,
                    fontWeight: FontWeight.w600),
              ),
              contentPadding: const EdgeInsets.only(left: 8.0, right: 16.0),
              visualDensity: const VisualDensity(horizontal: 3, vertical: -2),
              horizontalTitleGap: -4.5,
              leading: IconButton(
                icon: SvgAsset(
                  asset: icon,
                  width: 24,
                  height: 24,
                ),
                onPressed: null,
              ),
              onTap: null,
            ),
          ),
        ],
      ),
    );
  }
}
