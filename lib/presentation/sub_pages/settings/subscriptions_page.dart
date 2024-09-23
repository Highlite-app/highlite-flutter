import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/sub_pages/settings/upgrade_page.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';
import 'package:sizer/sizer.dart';
import '../../../core/resources/typography_theme.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/constants/text_style.dart';
import '../../widgets/drawer/content/content_subpage.dart';
import '../../widgets/layout/bordered_box.dart';
import '../../widgets/setting/sub_benefits_wrap.dart';
import '../../widgets/svg/svg_asset.dart';

class SubscriptionsPage extends StatelessWidget {
  const SubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentSubcontainer(
      backgroundColor: ColorConstant.neutral50,
      title: "My Subscriptions",
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [
              SubscriptionSection(
                title: "Current Balance",
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SubscriptionBox(
                      value:
                          // state.currentPackage.subscriptionType ==
                          //         SubscriptionTiers.proTier ?
                          "3",
                      //   : state.superMessageCount.toString(),
                      title: "Super Messages",
                    ),
                    const Spacer(),
                    SubscriptionBox(
                      value: '7',
                      // state.currentPackage.subscriptionType ==
                      //         SubscriptionTiers.proTier
                      //     ? "Unlimited"
                      //     : state.jobPostingCount.toString(),
                      title: "Job Postings",
                    ),
                  ],
                ),
              ),
              SubscriptionSection(
                title: "Current Plan",
                child: BorderedBox(
                  backgroundColor: ColorConstant.shade00,
                  child: PlanBox(
                    planType: 'Free',
                    //   state.currentPackage.subscribed_package?.package_name ?? "",
                    amount: '0',
                    //    state.currentPackage.subscribed_package?.amount.toString() ?? "",
                    benefits: [
                      // state.currentPackage.subscribed_package
                      //         ?.super_message_info ??
                      "3 super messages per month",
                      // state.currentPackage.subscribed_package
                      //         ?.job_posting_info ??
                      "1 job posting",
                      // if (state.currentPackage.subscribed_package
                      //         ?.isPriorityMatching ??
                      //     false)
                    ],
                    upgradeButton: true,
                    // state.currentPackage.subscriptionType ==
                    //     SubscriptionTiers.freeTier,

                    cancelButton: false,
                    // state.currentPackage.subscriptionType !=
                    //     SubscriptionTiers.freeTier,
                    onTapCancel: () {
                      // final package = state.packages
                      //     .where((e) =>
                      //         e.package_name == SubscriptionTiers.freeTier)
                      //     .toList()
                      //     .first;
                      // context
                      //     .read<SettingsBloc>()
                      //     .add(SelectPlanEvent(package));
                    },
                    proButton: false,
                    // state.currentPackage.subscriptionType ==
                    //     SubscriptionTiers.plusTier,
                    onTapPro: () {
                      // final package = state.packages
                      //     .where((e) =>
                      //         e.package_name == SubscriptionTiers.proTier)
                      //     .toList()
                      //     .first;
                      // context
                      //     .read<SettingsBloc>()
                      //     .add(SelectPlanEvent(package));
                    },
                  ),
                ),
              ),
              SubscriptionSection(
                title: "Current Billing Cycle",
                child: BorderedBox(
                  backgroundColor: ColorConstant.shade00,
                  child: BillingCycleBox(
                    amount: '0',
                    /*    state.currentPackage.subscribed_package?.amount
                              .toString() ??*/

                    monthCycle: "3 Jul, 2024 - 31 Jun, 2024",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionSection extends StatelessWidget {
  final String title;
  final Widget child;

  const SubscriptionSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p2,
            color: ColorConstant.neutral700,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8.0),
        child,
      ],
    );
  }
}

class SubscriptionBox extends StatelessWidget {
  final String value;
  final String title;

  const SubscriptionBox({
    super.key,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      height: 120,
      width: 45.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: BaseTextStyle(
              fontSize: TypographyTheme.heading_H4_small,
              color: ColorConstant.neutral700,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            title,
            style: BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p2,
              color: ColorConstant.neutral700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class PlanBox extends StatelessWidget {
  final String planType;
  final String amount;
  final List<String> benefits;
  final bool upgradeButton;
  final bool cancelButton;
  final VoidCallback onTapCancel;
  final bool proButton;
  final VoidCallback onTapPro;

  const PlanBox({
    super.key,
    required this.planType,
    required this.amount,
    required this.benefits,
    required this.upgradeButton,
    required this.cancelButton,
    required this.onTapCancel,
    required this.proButton,
    required this.onTapPro,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          planType,
          style: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p2,
            color: ColorConstant.neutral700,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          "\$$amount/month",
          style: BaseTextStyle(
            fontSize: TypographyTheme.heading_H5,
            color: ColorConstant.neutral700,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12.0),
        SubBenefitsWrap(benefits: benefits),
        const SizedBox(height: 12.0),
        if (proButton)
          PrimaryButton(
            title: "Upgrade to Pro",
            onTap: onTapPro,
            size: PrimaryButtonSize.small,
            horizontalPadding: 0,
          ),
        if (proButton) const SizedBox(height: 12.0),
        if (upgradeButton)
          PrimaryButton(
            title: "Upgrade",
            onTap: () {
              context.navigator.push(MaterialPageRoute(
                builder: (_) => const UpgradeSubscriptionPage(),
              ));
            },
            size: PrimaryButtonSize.small,
            horizontalPadding: 0,
          ),
        if (cancelButton)
          PrimaryButton(
            title: "Cancel Subscription",
            buttonStyle: PrimaryButtonStyle.borderedTransparent,
            onTap: onTapCancel,
            borderWidth: 1.0,
            borderColor: ColorConstant.neutral200,
            textColor: ColorConstant.neutral700,
            horizontalPadding: 0,
          ),
      ],
    );
  }
}

class BillingCycleBox extends StatelessWidget {
  final String amount;
  final String monthCycle;

  const BillingCycleBox({
    super.key,
    required this.amount,
    required this.monthCycle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "\$$amount/month",
          style: BaseTextStyle(
            fontSize: TypographyTheme.heading_H5,
            color: ColorConstant.neutral700,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgAsset(
              asset: AssetConstant.calenderIcon,
              color: ColorConstant.primary500,
              size: 18,
            ),
            const SizedBox(width: 8.0),
            Text(
              monthCycle,
              style: BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p3,
                  color: ColorConstant.neutral600,
                  fontWeight: FontWeight.w500,
                  height: 1.1),
            ),
          ],
        ),
      ],
    );
  }
}
