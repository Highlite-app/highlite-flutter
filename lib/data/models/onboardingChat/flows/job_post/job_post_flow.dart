// import '../../../../../presentation/widgets/onboarding/onboarding_success.dart';
// import '../../../apis/onboarding/company/highlite_company_job_post.dart';
// import '../../../apis/onboarding/company/highlite_company_profile.dart';
// import '../../../apis/onboarding/company/highlite_company_user_profile.dart';
// import '../api_flows/company_signup.dart';
// import '../company/company_flow_model.dart';
// import '../general/general_flow_model.dart';
// import '../onboarding_chat_models.dart';
// import 'job_post_flow_model.dart';
//
// class JobPostFlow extends OnboardingChatFlow {
//   @override
//   List<OnboardingChatFlowItem> get steps => [
//         //JobPostSteps.title,
//         // JobPostSteps.jobFlexibility,
//         // JobPostSteps.jobDuration,
//         // JobPostSteps.communication,
//         // JobPostSteps.skills,
//         // JobPostSteps.tools,
//         // JobPostSteps.salary,
//         // JobPostSteps.video,
//       ];
//   final GeneralFlowModel generalModel;
//   final CompanyFlowModel companyModel;
//   JobPostFlow({
//     required super.initialStep,
//     required this.generalModel,
//     required this.companyModel,
//   });
//
//   @override
//   FlowStepResponse Function() get conclusion => () {
//         return FlowStepResponse(
//           indicator: FlowResponseTags.completeFlow,
//           apiFlow: CompanySignupFlow(
//             companyRequest: HighliteCompanyUserProfile.fromOnboarding(companyModel),
//             companyUserRequest: HighliteCompanyUserProfile.fromOnboarding(
//               generalModel,
//               companyModel,
//               "",
//             ),
//             companyJobPostRequest:
//                 HighliteCompanyJobPost.fromOnboarding(getGeneratedModel()),
//           ),
//           //TODO : REMOTE THE function() and add actual ShowOnBoardingSuccess()
//           completionFlow:
//           showOnboardingSuccess(
//             companyModel.organization,
//             () {
//           //    globalNavKey.currentContext!.go(CompanyDashboard.routeName);
//             },
//           ),
//         );
//       };
//
//   @override
//   JobPostFlowModel getGeneratedModel() {
//     JobPostFlowModel flowModel = JobPostFlowModel.fromJson(payload);
//     return flowModel;
//   }
// }
