import 'package:get/get.dart';

import '../../../../../app.dart';
import '../../../../../core/routes/route_constants.dart';
import '../../../../../presentation/pages/dashboard/company_dashboard.dart';
import '../../../../../presentation/widgets/onboarding/onboarding_success.dart';
import '../general/general_flow_model.dart';
import '../job_post/job_post_flow.dart';
import '../onboarding_chat_models.dart';
import 'company_flow_model.dart';
import 'company_steps.dart';

class CompanyFlow extends OnboardingChatFlow<CompanyFlowModel> {
  @override
  List<OnboardingChatFlowItem> get steps => [
    CompanySteps.companyNameStep,
    CompanySteps.jobIndustry ,
    CompanySteps.location ,
    CompanySteps.companyWebsite ,
    CompanySteps.companyBenefitStep,
    CompanySteps.about,
    CompanySteps.emailAddress ,
  ];

  final GeneralFlowModel generalModel;
  CompanyFlow({
    required super.initialStep,
    required this.generalModel,
  });

  @override
  FlowStepResponse Function() get conclusion => () {
        return FlowStepResponse(
          indicator: FlowResponseTags.completeFlow,
          // flowAttached: JobPostFlow(
          //   initialStep: 0,
          //   generalModel: generalModel,
          //   companyModel: getGeneratedModel(),
          // ),
            completionFlow:    showOnboardingSuccess(
             "Srijan",
                  () async{
                await  Get.toNamed(RouteConstants.companyDashboard);
              },
            ),
        );
      };

  @override
  CompanyFlowModel getGeneratedModel() {
    CompanyFlowModel flowModel = CompanyFlowModel.fromJson(payload);
    return flowModel;
  }
}
