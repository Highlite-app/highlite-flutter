import 'package:get/get.dart';
import 'package:highlite_flutter_mvp/core/routes/route_constants.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/candidate_steps.dart';

import '../../../../../presentation/widgets/onboarding/onboarding_success.dart';
import '../api_flows/candidate_signup.dart';
import '../general/general_flow_model.dart';
import '../onboarding_chat_models.dart';
import 'candidate_flow_model.dart';

class CandidateFlow extends OnboardingChatFlow<CandidateFlowModel> {
  @override
  List<OnboardingChatFlowItem> get steps => [
        CandidateSteps.positionStep ,
        CandidateSteps.skills,
        CandidateSteps.tools,
        CandidateSteps.workType,
        CandidateSteps.jobDuration,
        CandidateSteps.salary,
        CandidateSteps.location ,
        CandidateSteps.about ,
        CandidateSteps.emailAddress

      ];
  GeneralFlowModel generalSection;
  CandidateFlow({
    required super.initialStep,
    required this.generalSection,
  });

  @override
  FlowStepResponse Function() get conclusion => () {
        final candidateModel = getGeneratedModel();
        final candidate =
            CandidateOnBoarding.fromOnboarding(generalSection, candidateModel);
        return FlowStepResponse(
          indicator: FlowResponseTags.completeFlow,
          apiFlow: CandidateSignupFlow(candidate: candidate),
          completionFlow:
          showOnboardingSuccess(
            candidate.firstName ??'',
            () async{
             await  Get.toNamed(RouteConstants.candidateDashboard);
            },
          ),
        );
      };

  @override
  CandidateFlowModel getGeneratedModel() {
    CandidateFlowModel flowModel = CandidateFlowModel.fromJson(payload);
    return flowModel;
  }
}


