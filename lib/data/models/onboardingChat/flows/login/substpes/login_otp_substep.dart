import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/constants/user_types.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/apis/login/verify_email_otp.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/profile/candidate_profile_repository.dart';

import '../../../../../../core/constants/default_responders.dart';
import '../../../../../../domain/repositories/onboarding/onboarding_repositoy.dart';
import '../../../../../../domain/repositories/persistent/persistent_repository.dart';
import '../../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../apis/login/verify_email_otp_response.dart';
import '../../onboarding_chat_models.dart';
import '../login_flow/login_flow.dart';
import 'no_existing_account_substep.dart';

class LoginOTPSubStep extends OnboardingChatSubstepItem {
  LoginOTPSubStep(String email)
      : super(
          flowStep: FlowStep(tag: LoginTags.otp, flowTag: LoginFlowTags.otp),
          messages: (payload) => [
            ChatMessage(
              tag: LoginFlowTags.otp,
              message: TranslationKeys.onboardingSentOTP(
                email,
              ),
              chatId: OnboardingChatter.bot,
            ),
          ],
          isInput: true,
          respondent: DefaultChatResponders.otp,
          delayedRespondent: (focusNode) =>
              DefaultChatResponders.otpWithTryAgainFlow(focusNode),
          delayedRespondentDuration: const Duration(seconds: 5),
          modifySubflow: modifySubFlowStepOTP(email),
          postModifyStep: createPostDefaultStep(),
        );
}

Future<void> setUpLogin(
    Map<String, dynamic> payload, VerifyEmailOtpResponse response) async {
  final data = response.data;
  await persistenceService.persist(
    loggedIn: true,
    tokenId: data?.tokenId ?? "",
    accessToken: data?.accessToken ?? "",
    refreshToken: data?.refreshToken ?? "",
    id: data?.id ?? "",
    userType: data?.userType ?? "",
  );
  payload[LoginTags.accessToken] = response.data?.accessToken;
  payload[LoginTags.refreshToken] = response.data?.refreshToken;
  payload[LoginTags.tokenId] = response.data?.tokenId;
  payload[LoginTags.id] = response.data?.id;
  payload[LoginTags.userType] = response.data?.userType;
  // gqlService.authenticate(
  //     payload[LoginTags.accessToken], payload[LoginTags.id]);
  final userData = await candidateProfileService
      .getCandidateOnBoarding(response.data?.id ?? '');
  if (userData.firstName != null) {
    debugPrint("The firstname before is ::${payload[LoginTags.firstName]}") ;
    payload[LoginTags.firstName] = userData.firstName;
    debugPrint("The firstname after  is ::${payload[LoginTags.firstName]}") ;
  }
}

class InvalidLoginOTPSubStep extends OnboardingChatSubstepItem {
  InvalidLoginOTPSubStep(String email)
      : super(
          flowStep: FlowStep(
            tag: LoginTags.invalidOTP,
            flowTag: LoginFlowTags.invalidOTP,
          ),
          messages: (payload) => [
            ChatMessage(
              tag: LoginFlowTags.invalidOTP,
              message: TranslationKeys.onboardingOTPWrong,
              chatId: OnboardingChatter.bot,
              status: BubbleStatus.error,
            )
          ],
          respondent: (focusNode) =>
              DefaultChatResponders.otpWithTryAgainFlow(focusNode),
          modifySubflow: modifySubFlowStepOTP(email),
          postModifyStep: createPostDefaultStep(),
        );
}

Future<FlowStepResponse> Function(Map<String, dynamic>, List<String>)
    modifySubFlowStepOTP(String email) => (payload, messages) async {
          if (messages.first == TranslationKeys.didntReceiveCode) {
            await onboardingService.getLoginWithEmailOtp(email);
            return Future.value(
              FlowStepResponse(
                indicator: FlowResponseTags.substepFlow,
                substepAttached: ResentOTPSubStep(email),
              ),
            );
          }
          payload[LoginTags.otp] = messages.first;
          final verifyEmailOtp = await onboardingService.verifyEmailOtp(
            VerifyEmailOtp(
                email: email,
                userType: UserTypes.candidate,
                otp: payload[LoginTags.otp]),
          );
          if (verifyEmailOtp.status == true) {
            await setUpLogin(payload, verifyEmailOtp);
            return Future.value(
              FlowStepResponse(
                indicator: FlowResponseTags.completeFlow,
              ),
            );
          } else {
            return Future.value(FlowStepResponse(
              indicator: FlowResponseTags.substepFlow,
              substepAttached: InvalidLoginOTPSubStep(
                email,
              ),
            ));
          }
        };

class ResentOTPSubStep extends OnboardingChatSubstepItem {
  ResentOTPSubStep(
    String email,
  ) : super(
          flowStep: FlowStep(
            tag: LoginTags.invalidOTP,
            flowTag: LoginFlowTags.invalidOTP,
          ),
          messages: (payload) => [
            ChatMessage(
              tag: LoginFlowTags.otp,
              message: TranslationKeys.onboardingSentOTP(
                email,
              ),
              chatId: OnboardingChatter.bot,
            )
          ],
          delayedRespondent: (focusNode) =>
              DefaultChatResponders.otpWithTryAgainFlow(focusNode),
          delayedRespondentDuration: const Duration(seconds: 5),
          respondent: DefaultChatResponders.otp,
          modifySubflow: modifySubFlowStepOTP(email),
          postModifyStep: createPostDefaultStep(),
        );
}
