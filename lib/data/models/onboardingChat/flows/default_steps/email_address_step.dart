import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:highlite_flutter_mvp/core/constants/user_types.dart';
import 'package:highlite_flutter_mvp/core/local_storage/shared_preference.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/core/resources/preference_constants.dart';
import 'package:highlite_flutter_mvp/core/services/firebase_service.dart';
import 'package:highlite_flutter_mvp/data/models/apis/authentication/create_user.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/candidate_steps.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/login/login_flow/login_flow.dart';
import 'package:highlite_flutter_mvp/domain/repositories/onboarding/onboarding_repositoy.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/selection_view.dart';
import '../../../../../core/constants/default_responders.dart';
import '../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../presentation/widgets/chat/chat_responder.dart';
import '../../../defaults/onboarding_step_defaults.dart';
import '../general/general_flow.dart';
import '../onboarding_chat_models.dart';
import 'default_steps.dart';

Future<String?> _authenticateBySocial(
  String message,
) async {
  if (message == TranslationKeys.signUpApple) {
    return FirebaseService.sociallyAuthenticate(
        authProvider: TranslationKeys.signUpApple);
  } else if (message == TranslationKeys.signUpGoogle) {
    return FirebaseService.sociallyAuthenticate(
        authProvider: TranslationKeys.signUpGoogle);
  } else if (message == TranslationKeys.signUpFacebook) {
    return FirebaseService.sociallyAuthenticate(
        authProvider: TranslationKeys.signUpFacebook);
  }
  return null;
}

enum ProviderEnum {
   google
}



class EmailAddressStep extends OnboardingChatFlowItem {
  EmailAddressStep()
      : super(
          flowStep: FlowStep(
              tag: DefaultTags.email,
              flowTag: DefaultFlowTags.email),
          messages: (payload) => [
            ChatMessage(
              tag: DefaultFlowTags.email,
              message: TranslationKeys.onboardingEmailOptions,
              chatId: OnboardingChatter.bot,
            )
          ],
          respondent: (focusNode) => Future.value(ChatRespondent(
            options: [
              Selection(
                icon: AssetConstant.mailIcon,
                text: TranslationKeys.signUpEmailAddress,
              ),
              if (Platform.isIOS)
                Selection(
                  icon: AssetConstant.appleIcon,
                  text: TranslationKeys.signUpApple,
                ),
              Selection(
                icon: AssetConstant.googleIcon,
                text: TranslationKeys.signUpGoogle,
              ),
              Selection(
                icon: AssetConstant.facebookIcon,
                text: TranslationKeys.signUpFacebook,
              ),
              Selection(
                icon: AssetConstant.microsoftIcon,
                text: TranslationKeys.signUpMicrosoft,
              ),
              Selection(
                icon: AssetConstant.twitterIcon,
                text: TranslationKeys.signUpTwitter,
              ),
              Selection(
                icon: AssetConstant.githubIcon,
                text: TranslationKeys.signUpGithub,
              ),
            ],
          )),
          modifier: (payload, tag, messages) async {
            if (messages.first == TranslationKeys.emailAddress) {
              return Future.value(
                FlowResponse(
                  status: false,
                  payload: {
                    FlowResponseTags.emitSubflow:
                        DefaultSuccessResponseTags.emailAddress,
                  },
                ),
              );
            }
            String? emailAddressFromSocial =
                await _authenticateBySocial(messages.first);
            //    SharedPreferencesHelper.setValue(key: PreferenceConstant.googleSignInEmail , value:emailAddressFromSocial ?? "");
            debugPrint("The email address in UI :: ${emailAddressFromSocial}");


            if(messages.first == TranslationKeys.signUpGoogle){
              ProviderEnum.google ;
            }
          final signUpResponse  =   await onboardingService.signUp(CreateUser(
              firstName: CandidateTags.firstName ,
              email: DefaultTags.email ,
              provider: "google",
             providerId: FirebaseConstant.providerId ,
            userType: UserTypes.candidate
            )) ;
            if (emailAddressFromSocial != null && signUpResponse.status == true ) {
              payload[DefaultTags.email] = emailAddressFromSocial;

              print("*****The bloc is if flow*******");
              return Future.value(
                FlowResponse(
                  status: true,
                  payload: {
                    // FlowResponseTags.emitSubflow : DefaultSuccessResponseTags.socialMediaSuccessEmailAddress,
                    FlowResponseTags.message: emailAddressFromSocial,

                    // FlowResponseTags.emitSubflow:
                    //     DefaultSuccessResponseTags.existingEmailAddress,
                  },
                ),
              );
            } else {
              print("*****The bloc is else flow*******");
              //    await SharedPreferencesHelper.setValue(key: PreferenceConstant.googleSignInEmail , value: "");
              return Future.value(
                FlowResponse(
                  status: false,
                  payload: {
                    FlowResponseTags.emitSubflow:
                        DefaultSuccessResponseTags.existingEmailAddress,
                  },
                ),
              );
            }
          },
          successStep: (payload, responsePayload) => [
            ChatMessage(
              tag: DefaultTags.email,
              message: responsePayload[FlowResponseTags.message],
              chatId: OnboardingChatter.user,
              editable: false,
            ),
            ChatMessage(
              tag: DefaultFlowTags.email,
              message: TranslationKeys.successFlow,
              chatId: OnboardingChatter.bot,
            ),
            ChatMessage(
              tag:  DefaultFlowTags.email,
              message: TranslationKeys.takingYouToHomeScreen,
              chatId: OnboardingChatter.bot,
            ),
          ],
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
              DefaultTags.email, true),
          failureSubflow: (payload) {
            if (payload[FlowResponseTags.emitSubflow] ==
                DefaultSuccessResponseTags.socialMediaSuccessEmailAddress) {
              return SocialMediaSuccessEmailAddressStep();
            }

            if (payload[FlowResponseTags.emitSubflow] ==
                DefaultSuccessResponseTags.existingEmailAddress) {
              return ExistingEmailAddressSubstep();
            }
            if (payload[FlowResponseTags.emitSubflow] ==
                DefaultSuccessResponseTags.emailAddress) {
              debugPrint(
                  "***** Coming In EmailAddressInputSubstep Bloc *******");
              return EmailAddressInputSubstep();
            }
            return OnboardingChatSubstepItem.blank;
          },
        );
}

class SocialMediaSuccessEmailAddressStep extends OnboardingChatSubstepItem {
  SocialMediaSuccessEmailAddressStep()
      : super(
          flowStep: FlowStep(
            tag: DefaultTags.socialMediaEmailAddressSubFlow,
            flowTag: DefaultFlowTags.email,
          ),
          messages: (payload) => [
            ChatMessage(
              tag:  DefaultFlowTags.email,
              message: TranslationKeys.successFlow,
              chatId: OnboardingChatter.bot,
            ),
            ChatMessage(
              tag: DefaultFlowTags.email,
              message: TranslationKeys.takingYouToHomeScreen,
              chatId: OnboardingChatter.bot,
            ),
          ],
          respondent: (focusNode) => DefaultChatResponders.email(focusNode),
          modifySubflow: (payload, messages) async {
            return Future.value(
              FlowStepResponse(
                indicator: FlowResponseTags.nextStep,
              ),
            );
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
              DefaultTags.socialMediaEmailAddressSubFlow, true),
        );
}

class EmailAddressInputSubstep extends OnboardingChatSubstepItem {
  EmailAddressInputSubstep()
      : super(
          flowStep: FlowStep(
            tag: DefaultTags.emailAddressSubflow,
            flowTag: DefaultFlowTags.email,
          ),
          messages: (payload) => [
            ChatMessage(
              tag:  DefaultFlowTags.email,
              message: TranslationKeys.signUpEmailAddressMessage,
              chatId: OnboardingChatter.bot,
            ),
          ],
          isInput: true,
          respondent: (focusNode) => DefaultChatResponders.email(focusNode),
          modifySubflow: (payload, messages) async {
            final accountEmailResponse = ["srijan"];
            //    await onboardingService.accountEmail(AccountEmailRequest(email: messages.first));
            if (accountEmailResponse.isEmpty) {
              payload[DefaultTags.email] = messages.first;
              return Future.value(
                FlowStepResponse(
                  indicator: FlowResponseTags.nextStep,
                ),
              );
            } else {
              return Future.value(
                FlowStepResponse(
                    indicator: FlowResponseTags.substepFlow,
                    substepAttached: ExistingEmailAddressSubstep()),
              );
            }
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
              DefaultTags.emailAddressSubflow, true),
        );
}

class ExistingEmailAddressSubstep extends OnboardingChatSubstepItem {
  ExistingEmailAddressSubstep()
      : super(
          flowStep: FlowStep(
            tag: DefaultTags.emailAddressSubflow,
            flowTag: DefaultFlowTags.email,
          ),
          messages: (payload) => [
            ChatMessage(
              tag:  DefaultFlowTags.email,
              message: TranslationKeys.onboardingEmailUserExists,
              chatId: OnboardingChatter.bot,
              status: BubbleStatus.warningError,
            ),
            ChatMessage(
              tag:  DefaultFlowTags.email,
              message: TranslationKeys.onboardingEmailUserExists1,
              chatId: OnboardingChatter.bot,
              status: BubbleStatus.warningError,
            )
          ],
          isInput: true,
          respondent: (focusNode) => Future.value(
            ChatRespondent(
              options: [
                Selection(text: TranslationKeys.login),
                Selection(text: TranslationKeys.tryAgainResponse),
              ],
              capitalize: true,
            ),
          ),
          modifySubflow: (payload, messages) async {
            if (messages.first == TranslationKeys.tryAgainResponse) {
              return Future.value(
                FlowStepResponse(
                  indicator: FlowResponseTags.repeatStep,
                ),
              );
            } else {
              return Future.value(
                FlowStepResponse(
                  indicator: FlowResponseTags.replaceFlow,
                  flowAttached: LoginFlow(initialStep: 0, ignoreLoginMessage: true),
                ),
              );
            }
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
            DefaultTags.emailAddressSubflow,
            false,
          ),
        );
}
