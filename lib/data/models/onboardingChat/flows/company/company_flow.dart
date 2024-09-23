import 'package:get/get.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/api_flows/company_signup.dart';

import '../../../../../core/routes/route_constants.dart';
import '../../../../../presentation/widgets/onboarding/onboarding_success.dart';
import '../general/general_flow_model.dart';
import '../onboarding_chat_models.dart';
import 'company_flow_model.dart';
import 'company_steps.dart';

class CompanyFlow extends OnboardingChatFlow<CompanyFlowModel> {
  @override
  List<OnboardingChatFlowItem> get steps => [
        CompanySteps.companyNameStep,
        CompanySteps.jobIndustry,
        CompanySteps.location,
        CompanySteps.companySizeStep,
        CompanySteps.companyWebsite,
        CompanySteps.companyBenefitStep,
        CompanySteps.about,
        CompanySteps.emailAddress,
      ];

  final GeneralFlowModel generalModel;

  CompanyFlow({
    required super.initialStep,
    required this.generalModel,
  });

  @override
  FlowStepResponse Function() get conclusion => () {
        final companyFlowModel = getGeneratedModel();
        return FlowStepResponse(
          indicator: FlowResponseTags.completeFlow,
          apiFlow: CompanySignupFlow(
              companyOnboarding: CompanyOnboarding.fromOnboarding(
                  generalModel, companyFlowModel)),
          completionFlow: showOnboardingSuccess(
            companyFlowModel.companyName,
            () async {
              await Get.toNamed(RouteConstants.companyDashboard);
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
