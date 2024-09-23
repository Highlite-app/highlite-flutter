import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/sub_pages/settings/billing_page.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../core/resources/typography_theme.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/constants/text_style.dart';
import '../../widgets/form/radio_text.dart';
import '../../widgets/layout/bordered_box.dart';
import '../../widgets/navigation/navigated_page.dart';
import '../../widgets/segment/custom_segment_controls.dart';
import '../../widgets/setting/sub_benefits_wrap.dart';

class SubscriptionTiers {
  static const String freeTier = "Free";
  static const String plusTier = "Plus";
  static const String proTier = "Pro";
}

class UpgradeSubscriptionPage extends StatefulWidget {

  const UpgradeSubscriptionPage({super.key});


  @override
  State<UpgradeSubscriptionPage> createState() => _UpgradeSubscriptionPageState();
}


class _UpgradeSubscriptionPageState extends State<UpgradeSubscriptionPage> {


  String selectedPlan = SubscriptionTiers.freeTier;
  final   CustomSegmentedController<String> segmentController =
  CustomSegmentedController(value: "Monthly");
   bool isAnnual = false ;

  @override
  void initState() {
    super.initState() ;
   segmentController.addListener((){
     if(segmentController.value == 'Annually'){
       debugPrint("The value is :: ${segmentController.value}");
       setState(() {
         isAnnual = true ;
       });
     }else {
       print("Called");
       setState(() {
         isAnnual = false ;
       });
     }
   });
  }


  @override
  Widget build(BuildContext context) {
    return NavigatedPage(
      title: "Upgrade",
      includesBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           UpgradeSegment(segmentController: segmentController),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: Column(
                  children: [
                    Wrap(spacing: 16.0, runSpacing: 16.0, children: [
                      SubscriptionItem(
                        planName: SubscriptionTiers.freeTier,
                        selectedPlan: selectedPlan,
                        planAmount: ("\$0/month"),
                        benefits: const [
                          '3 Super messages per month',
                          '1 Job posting'
                          // e.super_message_info,
                          // e.job_posting_info,
                          // if (e.isPriorityMatching) "Priority Matching",
                        ],
                        // e.package_name != "Free"
                        //     ? "You will be charged \$ $finalAmount per ${isYearly ? "year" : "month"}. Cancel anytime."
                        //     : null,
                        onTap: () {

                          setState(() {
                            selectedPlan = SubscriptionTiers.freeTier;
                          });
                          // dashboardNavKey.currentContext!
                          //     .read<SettingsBloc>()
                          //     .add(SelectPlanEvent(e));
                        },
                      ),
                      SubscriptionItem(
                        planName: SubscriptionTiers.plusTier,
                        selectedPlan: selectedPlan,
                        planAmount: isAnnual? ("\$19.20/month"): ("\$24/month"),
                        benefits: [
                          '10 Super messages per month',
                          '3 job postings',
                          'Priority matching'
                          // e.super_message_info,
                          // e.job_posting_info,
                          // if (e.isPriorityMatching) "Priority Matching",
                        ],
                        tagline:isAnnual?'You will be charged \$230.40 per year.': 'You will be charged \$24 per month. Cancel anytime.',
                        // e.package_name != "Free"
                        //     ? "You will be charged \$ $finalAmount per ${isYearly ? "year" : "month"}. Cancel anytime."
                        //     : null,
                        onTap: () {
                          setState(() {
                            selectedPlan = SubscriptionTiers.plusTier ;
                          });
                          // dashboardNavKey.currentContext!
                          //     .read<SettingsBloc>()
                          //     .add(SelectPlanEvent(e));
                        },
                      ),
                      SubscriptionItem(
                        planName: SubscriptionTiers.proTier,
                        selectedPlan: 'selected Plam',
                        planAmount: isAnnual ? ("\$38.40/month"): ("\$48/month"),
                        benefits: const [
                          'Unlimited super messages per month',
                          'Unlimited job postings',
                          'Priority matching',
                          // e.super_message_info,
                          // e.job_posting_info,
                          // if (e.isPriorityMatching) "Priority Matching",
                        ],
                        tagline: isAnnual?'You will be charged \$460.80 per year.': 'You will be charged \$48 per month. Cancel anytime.',
                        // e.package_name != "Free"
                        //     ? "You will be charged \$ $finalAmount per ${isYearly ? "year" : "month"}. Cancel anytime."
                        //     : null,
                        onTap: () {
                          setState(() {
                            selectedPlan = SubscriptionTiers.proTier ;
                          });
                          // dashboardNavKey.currentContext!
                          //     .read<SettingsBloc>()
                          //     .add(SelectPlanEvent(e));
                        },
                      ),
                    ]
                        //     state.packages.sortedBy((e) => e.amount).map((e) {
                        //   final isYearly = true ;
                        //      // state.selectedPlanDuration == "Annually";
                        //   const discount = 0.2;
                        //   final amountMultiplier = isYearly ? 12 : 1;
                        //   final discountAmount = e.amount.toInt() * discount;
                        //   final amount = (e.amount.toInt());
                        //   int finalAmount = amount.toInt();
                        //   int monthlyAmount = amount.toInt();
                        //   if (isYearly) {
                        //     finalAmount = (amount - discountAmount.toInt()) *
                        //         amountMultiplier;
                        //     monthlyAmount = (amount - discountAmount).toInt();
                        //   }
                        //   return
                        // }).toList(),
                        ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UpgradeSegment extends StatefulWidget {
  final CustomSegmentedController<String> segmentController ;

  const UpgradeSegment({
     required  this.segmentController  ,
      super.key});

  @override
  State<UpgradeSegment> createState() => _UpgradeSegmentState();
}

class _UpgradeSegmentState extends State<UpgradeSegment> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSegmentedControls(
                options: const [
                  "Monthly",
                  "Annually",
                ],
                currentValue: widget.segmentController.value ?? '',
                onValueChanged: (value) {
                  // dashboardNavKey.currentContext!
                  //     .read<SettingsBloc>()
                  //     .add(SelectPlanDurationEvent(value));
                  setState(() {
                    widget.segmentController.value = value;
                  });
                },
                controller: widget.segmentController,
              ),
              const SizedBox(
                height: 12,
              ),
              const DiscountSection(
                discountPercent: "20",
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DiscountSection extends StatelessWidget {
  final String discountPercent;

  const DiscountSection({super.key, required this.discountPercent});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "(Save $discountPercent% with yearly billing)",
          style: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p3,
            color: ColorConstant.primary500,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

class SubscriptionItem extends StatelessWidget {
  final String planName;
  final String selectedPlan;
  final String planAmount;
  final List<String> benefits;
  final String? tagline;
  final VoidCallback onTap;

  const SubscriptionItem({
    super.key,
    required this.planName,
    required this.selectedPlan,
    required this.planAmount,
    required this.benefits,
    this.tagline,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BorderedBox(
      width: double.infinity,
      borderColor: selectedPlan == planName
          ? ColorConstant.primary500
          : ColorConstant.neutral100,
      horizontalPadding: 16.0,
      verticalPadding: 16.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RadioText(
            text: planName,
            selectedText: selectedPlan,
            textStyle: BaseTextStyle(
              fontSize: TypographyTheme.paragraph_p2,
              color: ColorConstant.neutral700,
              fontWeight: FontWeight.w600,
              height: 1.1,
            ),
            onTap: null,
          ),
          Text(
            planAmount,
            style: BaseTextStyle(
              color: ColorConstant.neutral700,
              fontSize: TypographyTheme.heading_H5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SubBenefitsWrap(
              benefits: benefits,
            ),
          ),
          if (tagline != null) const SizedBox(height: 4.0),
          if (tagline != null)
            Text(
              tagline!,
              style: BaseTextStyle(
                color: ColorConstant.neutral500,
                fontSize: TypographyTheme.paragraph_p4,
                fontWeight: FontWeight.w600,
              ),
            ),
          const SizedBox(height: 16.0),
          if (selectedPlan != SubscriptionTiers.freeTier &&
              planName == SubscriptionTiers.freeTier)
            PrimaryButton(
              title: "Downgrade to $planName Plan",
              buttonStyle: PrimaryButtonStyle.borderedTransparent,
              onTap: (){
                context.navigator.push(MaterialPageRoute(builder:(_)=> const BillingPage()));
              },
              borderWidth: 1.0,
              borderColor: ColorConstant.neutral200,
              textColor: ColorConstant.neutral700,
              horizontalPadding: 0,
            ),
          if (selectedPlan == planName)
            PrimaryButton(
              title: "You are currently on the $planName Plan",
              state: PrimaryButtonState.invertedBordered,
              onTap: (){
                context.navigator.push(MaterialPageRoute(builder:(_)=> const BillingPage()));
              },
              borderWidth: 1.0,
              horizontalPadding: 0,
            ),
          if (selectedPlan != planName &&
              planName != SubscriptionTiers.freeTier)
            PrimaryButton(
              title: "Upgrade to $planName",
              onTap: (){
                context.navigator.push(MaterialPageRoute(builder:(_)=> const BillingPage()));
              },
              borderWidth: 1.0,
              horizontalPadding: 0,
            ),
        ],
      ),
    );
  }
}
