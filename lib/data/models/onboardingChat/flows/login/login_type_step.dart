import 'dart:io';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/default_steps/default_steps.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/login/substpes/email_substep.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/login/substpes/no_existing_account_substep.dart';

import '../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../presentation/widgets/buttons/selection_view.dart';
import '../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../presentation/widgets/chat/chat_responder.dart';
import '../../../defaults/onboarding_step_defaults.dart';
import '../general/general_flow.dart';
import '../onboarding_chat_models.dart';
import 'login_flow/login_flow.dart';

// Future<String?> _authenticateBySocial(
//   Map<String, dynamic> payload,
//   String message,
// ) async {
//   if (message == TranslationKeys.loginWithApple) {
//     return _sociallyAuthenticate(payload, AuthProvider.apple);
//   } else if (message == TranslationKeys.signUpGoogle) {
//     return _sociallyAuthenticate(payload, AuthProvider.google);
//   } else if (message == TranslationKeys.signUpFacebook) {
//     return _sociallyAuthenticate(payload, AuthProvider.facebook);
//   }
//   return null;
// }
//
// Future<String?> _sociallyAuthenticate(
//     Map<String, dynamic> payload, async {
//   final SSOProviderResponse? data =
//       await SSOProvider.signInWithWebUI(buildContext, provider);
//   gqlService.authenticate(data?.accessToken ?? "", data?.userId ?? "");
//   await _setupCognitoData(payload, data!);
//   return data.email;
// }

// Future<void> _setupCognitoData(
//     Map<String, dynamic> payload, SSOProviderResponse response) async {
//   payload[LoginTags.accessToken] = response.accessToken;
//   payload[LoginTags.refreshToken] = response.refreshToken;
//   payload[LoginTags.tokenId] = response.tokenId;
//   // gqlService.authenticate(
//   //     payload[LoginTags.accessToken], payload[LoginTags.id]);
//   // final cognitoData = await onboardingService.getCognitoDataForEmail();
//   // if (cognitoData != null) {
//   //   if (cognitoData.status == true) {
//   //   }
//   // }
// }

class LoginTypeStep extends OnboardingChatFlowItem {
  LoginTypeStep(bool ignoreLoginMessage)
      : super(
          flowStep: FlowStep(
            tag: LoginTags.loginType,
            flowTag: LoginFlowTags.loginType,
          ),
          messages: (payload) => [
            if (!ignoreLoginMessage)
              ChatMessage(
                tag: LoginFlowTags.loginType,
                message: TranslationKeys.login,
                chatId: OnboardingChatter.user,
              ),
            ChatMessage(
              tag: LoginFlowTags.loginType,
              message: TranslationKeys.loginStartMessage,
              chatId: OnboardingChatter.bot,
            )
          ],
          respondent: (focusNode) => Future.value(
            ChatRespondent(
              options: [
                Selection(
                  icon: AssetConstant.mailIcon,
                  text: TranslationKeys.emailAddress,
                ),
                //TODO : THIS IS ACTUALLY PHONE NUMBER ADD PHONE NUMBER
                // Selection(
                //   icon: AssetConstant.mailIcon,
                //   text: TranslationKeys.phoneNumber,
                // ),
                if (Platform.isIOS)
                  Selection(
                    icon: AssetConstant.appleIcon,
                    text: TranslationKeys.loginWithApple,
                  ),
                Selection(
                  icon: AssetConstant.githubIcon,
                  text: TranslationKeys.signUpGithub,
                ),
                Selection(
                  icon: AssetConstant.facebookIcon,
                  text: TranslationKeys.loginWithFacebook,
                ),
              ],
            ),
          ),
          modifier: (payload, tag, messages) async {
            if (messages.first == TranslationKeys.emailAddress) {
              return Future.value(
                FlowResponse(
                  status: false,
                  payload: {
                    FlowResponseTags.emitSubflow: LoginSuccessResponseTags.emailOtp,
                  },
                ),
              );
            }
            if (messages.first == TranslationKeys.emailAddress) {
              return Future.value(
                FlowResponse(
                  status: false,
                  payload: {
                    FlowResponseTags.emitSubflow:
                        LoginSuccessResponseTags.emailAddress,
                  },
                ),
              );
            }
            String? emailAddressFromSocial ="" ;
              //  await _authenticateBySocial(payload, messages.first);
            if (payload[LoginTags.firstName] != null) {
              payload[DefaultTags.email] = emailAddressFromSocial;
              return Future.value(
                FlowResponse(
                  status: true,
                  payload: {
                    FlowResponseTags.message: emailAddressFromSocial,
                  },
                ),
              );
            } else {
              return Future.value(
                FlowResponse(
                  status: false,
                  payload: {
                    FlowResponseTags.emitSubflow:
                        LoginSuccessResponseTags.noExistingUser,
                  },
                ),
              );
            }
          },
          successStep: (payload, responsePayload) => [
            ChatMessage(
              tag: LoginTags.loginType,
              message: responsePayload[FlowResponseTags.message],
              chatId: OnboardingChatter.user,
              editable: false,
            ),
          ],
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
              LoginTags.loginType, true),

          failureSubflow: (payload) {
            if(payload[FlowResponseTags.emitSubflow] == LoginSuccessResponseTags.emailOtp){
              return LoginEmailAddressInputSubStep();
            }
            if (payload[FlowResponseTags.emitSubflow] ==
                LoginSuccessResponseTags.noExistingUser) {
              return NoExistingAccountSubstep();
            }
            // if (payload[FlowResponseTags.emitSubflow] ==
            //     LoginSuccessResponseTags.emailAddress) {
            //   return LoginEmailAddressInputSubstep();
            // }
            // if (payload[FlowResponseTags.emitSubflow] ==
            //     LoginSuccessResponseTags.countryCode) {
            //   return LoginCountryCodeSubstep();
            // }
             return OnboardingChatSubstepItem.blank;
          },
        );
}
