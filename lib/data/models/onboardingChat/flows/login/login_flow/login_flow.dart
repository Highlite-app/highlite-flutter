import 'package:get/get.dart';
import 'package:highlite_flutter_mvp/app.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/login/login_steps.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/login/login_type_step.dart';

import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../../core/routes/route_constants.dart';
import '../../../../../../presentation/bloc/dashboard/auth/authentication_bloc.dart';
import '../../../../../../presentation/bloc/dashboard/auth/authentication_event.dart';
import '../../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../../presentation/widgets/onboarding/onboarding_success.dart';
import '../../onboarding_chat_models.dart';
import '../login_flow_model.dart';
class LoginTags {
  static String loginType = "loginType";
  static String countryCode = "countryCode";
  static String phoneNumber = "phoneNumber";
  static String emailAddress = "emailAddress";
  static String existingUser = "existingUser";
  static String otp = "otp";
  static String invalidOTP = "invalidOTP";
  static String accessToken = "accessToken";
  static String refreshToken = "refreshToken";
  static String tokenId = "tokenId";
  static String firstName = "firstName";
  static String id = "id";
  static String userType = "userType";
}

class LoginFlowTags {
  static String loginType = "loginType_flow";
  static String countryCode = "countryCode_flow";
  static String phoneNumber = "phoneNumber_flow";
  static String emailAddress = "emailAddress_flow";
  static String existingUser = "existingUser_flow";
  static String otp = "otp_flow";
  static String invalidOTP = "invalidOTP_flow";
}

class LoginSuccessResponseTags {
  static String emailOtp = "emailOtp";
  static String emailAddress = "emailAddress_subflow";
  static String noExistingUser = "noExistingUser_subflow";
}
class LoginFlow extends OnboardingChatFlow<LoginFlowModel>{
  final bool ignoreLoginMessage ;
  LoginFlow({required super.initialStep , required this.ignoreLoginMessage});


  @override
  // TODO: implement steps
  List<OnboardingChatFlowItem> get steps => [
   LoginSteps.loginType(ignoreLoginMessage),
  ];


  @override
  LoginFlowModel getGeneratedModel() {
   LoginFlowModel flowModel = LoginFlowModel.fromJson(payload) ;
   return flowModel ;
  }


  @override
  FlowStepResponse Function() get conclusion => () {
    final flowModel = getGeneratedModel();
    return FlowStepResponse(
      indicator: FlowResponseTags.completeFlow,
      flowConclusion: FlowConclusion(
        successMessages: (payload) => [
          ChatMessage(
            message: TranslationKeys.loginEmail(
              flowModel.firstName!,
            ),
            chatId: OnboardingChatter.bot,
          ),
          ChatMessage(
            message: TranslationKeys.loginEmail1,
            chatId: OnboardingChatter.bot,
          ),
        ],
      ),
      completionFlow: _navigateToHomepage()
    );
  };



  Future<void> _navigateToHomepage() async {

    authentication.add(const AuthenticateOnStartEvent());
  }
}



