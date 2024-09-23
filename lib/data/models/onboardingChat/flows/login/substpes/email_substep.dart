import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import '../../../../../../core/constants/default_responders.dart';
import '../../../../../../domain/repositories/onboarding/onboarding_repositoy.dart';
import '../../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../defaults/onboarding_step_defaults.dart';
import '../../onboarding_chat_models.dart';
import '../login_flow/login_flow.dart';
import 'login_otp_substep.dart';
import 'no_existing_account_substep.dart';

class LoginEmailAddressInputSubStep extends OnboardingChatSubstepItem {
  LoginEmailAddressInputSubStep()
      : super(
    flowStep: FlowStep(
      tag: LoginTags.emailAddress,
      flowTag: LoginFlowTags.emailAddress,
    ),
    messages: (payload) => [
      ChatMessage(
        tag: LoginFlowTags.emailAddress,
        message: TranslationKeys.loginEmailOption,
        chatId: OnboardingChatter.bot,
      ),
    ],
    isInput: true,
    respondent: (focusNode) => DefaultChatResponders.email(focusNode),
    modifySubflow: (payload, messages) async {
      payload[LoginTags.emailAddress] = messages.first;
      final sendOTPForSignInResponse =
      await onboardingService.getLoginWithEmailOtp(
        payload[LoginTags.emailAddress]
      );



      if (sendOTPForSignInResponse.status == false  ) {
        return Future.value(
          FlowStepResponse(
            indicator: FlowResponseTags.substepFlow,
            substepAttached: NoExistingAccountSubstep(),
          ),
        );
      } else {
        return Future.value(
          FlowStepResponse(
            indicator: FlowResponseTags.substepFlow,
              substepAttached: LoginOTPSubStep(
             payload[LoginTags.emailAddress]
            ),
          ),
        );
      }
    },
    postModifyStep: OnboardingStepDefaults.createPostModifyStep(
        LoginFlowTags.emailAddress, true),
  );
}
