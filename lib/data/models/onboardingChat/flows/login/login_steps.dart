import '../onboarding_chat_models.dart';
import 'login_type_step.dart';

class LoginSteps {
  static OnboardingChatFlowItem loginType(bool ignoreLoginMessage) =>
      LoginTypeStep(ignoreLoginMessage);
}
