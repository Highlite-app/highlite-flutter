import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/routes/route_constants.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/push_notification/push_notification_payload.dart';
import '../../../core/resources/asset_constants.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../../../core/services/push_notification_service.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/constants/text_style.dart';
import '../../widgets/pager/pageview_indicator.dart';

class OnboardingSplash extends StatefulWidget {

  const OnboardingSplash({super.key});

  @override
  State<OnboardingSplash> createState() => _OnboardingSplashState();
}

class _OnboardingSplashState extends State<OnboardingSplash> {
  PushNotificationService pushNotificationService = PushNotificationService();
  int selectedIndex = 0;
  bool _loadedInitData = false;
  List<Widget> pages = [];

  @override
  void initState() {
    pushNotificationService.initialize(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      pages = [
        const OnboardingHeadlinePage(
            isPrimary: true,
            title: 'The world’s simplest job-matching app.'),
        const OnboardingHeadlinePage(
            isPrimary: false, title: 'Find your \ndream job.'),
        const OnboardingHeadlinePage(
            isPrimary: false, title: 'Hire your rockstar candidate.'),
        const OnboardingHeadlinePage(
          isPrimary: false,
          title: 'Get matches in \n5 minutes or \nless.',
          withPrimaryButton: true,
        ),
      ];
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (int page) {
              setState(() {
                selectedIndex = page;
              });
            },
            children: pages,
          ),
          PageViewIndicator(
            selectedIndex: selectedIndex,
            pages: pages,
            lightThemed: selectedIndex >= 1,
          ),
        ],
      ),
    );
  }
}

class OnboardingHeadlinePage extends StatelessWidget {
  final bool isPrimary;
  final String title;
  final bool withPrimaryButton;
  const OnboardingHeadlinePage({
    super.key,
    required this.isPrimary,
    required this.title,
    this.withPrimaryButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isPrimary ? ColorConstant.primary500 : ColorConstant.shade00),
      child: Column(
        children: [
          HeadlineContent(
            isPrimary: isPrimary,
            title: title,
          ),
          LoginContent(
            isPrimary: isPrimary,
            withPrimaryButton: withPrimaryButton,
          ),
        ],
      ),
    );
  }
}

class LoginContent extends StatelessWidget {
  final bool withPrimaryButton;
  final bool isPrimary;
  const LoginContent({
    super.key,
    required this.withPrimaryButton,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 70.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (withPrimaryButton)
            PrimaryButton(
              title: 'Let’s Get Started!',
              borderRadius: 6.0,
              onTap: () async {
                Navigator.pushNamed(context, RouteConstants.onBoardingChat);
              },
            ),
          LoginFooter(isPrimary: isPrimary),
        ],
      ),
    );
  }
}

class LoginFooter extends StatelessWidget {
  final bool isPrimary;
  const LoginFooter({
    super.key,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    if (!isPrimary) {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: PrimaryButton(
          title:
          "Already have an account? Login",
          state: PrimaryButtonState.invertedBordered,
          size: PrimaryButtonSize.normal,
          borderWidth: 1.0,
          borderRadius: 6.0,
          borderColor: ColorConstant.primary100,
          onTap: () {
            Navigator.pushNamed(context, RouteConstants.onBoardingChat);
          },
        ),
      );
    }
    return Container(
      margin:const  EdgeInsets.only(top: 20 , left: 16 , right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 16),
      decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(6)  ,
          border: Border.all(color: ColorConstant.shade00 , width: 1)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p2,
              color: isPrimary ? ColorConstant.shade00 : ColorConstant.neutral800,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: InkWell(
              onTap: () {

                Navigator.pushNamed(context, RouteConstants.onBoardingChatLogin);
              },
              child: Text(
                'Login',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p2,
                  color: isPrimary ? ColorConstant.shade00 : ColorConstant.primary500,
                  fontWeight: isPrimary ? FontWeight.bold : FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeadlineContent extends StatelessWidget {
  final bool isPrimary;
  final String title;
  const HeadlineContent({
    super.key,
    required this.isPrimary,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    Widget titleContent = Padding(
      padding: EdgeInsets.only(top: isPrimary ? 20.0 : 36.0),
      child: SizedBox(
        width: 350,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 16.0),
          child: Text(
            title,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: BaseTextStyle(
                fontSize: isPrimary
                    ? TypographyTheme.heading_H4
                    : TypographyTheme.heading_H2_small,
                color: isPrimary ? ColorConstant.shade00 : ColorConstant.primary500,
                fontWeight: isPrimary ? FontWeight.bold : FontWeight.w900,
                height: 1.2),
          ),
        ),
      ),
    );
    return Expanded(
      child: Column(
        mainAxisAlignment:
        isPrimary ? MainAxisAlignment.center : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: height + 20.0),
            child: Image.asset(
              isPrimary
                  ? AssetConstant.icHighLiteLogo
                  : AssetConstant.icHighLiteSMLogo,
              width: isPrimary ? 120 : 48,
              height: isPrimary ? 120 : 48,
            ),
          ),
          isPrimary
              ? titleContent
              : Padding(
            padding: const EdgeInsets.only(top: 130.0 , left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Expanded(child: titleContent)],
            ),
          ),
        ],
      ),
    );
  }
}
