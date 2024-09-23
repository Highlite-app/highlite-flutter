import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import '../../../../../core/constants/default_responders.dart';
import '../../../../../core/services/location_service.dart';
import '../../../../../presentation/widgets/buttons/selection_view.dart';
import '../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../presentation/widgets/chat/chat_responder.dart';
import '../../../defaults/onboarding_step_defaults.dart';
import '../onboarding_chat_models.dart';
import 'default_steps.dart';


class LocationStep extends OnboardingChatFlowItem {

  LocationStep(bool isCandidate)
      : super(
          flowStep: FlowStep(
            tag: DefaultTags.location,
            flowTag: DefaultFlowTags.location,
          ),
          messages: (payload) => [
            ChatMessage(
              tag: DefaultFlowTags.location,
              message: isCandidate ? TranslationKeys.onboardingCandidateLocation : TranslationKeys.onboardingLocation1,
              chatId: OnboardingChatter.bot,
            ),
            ChatMessage(
              tag: DefaultFlowTags.location,
              message:TranslationKeys.onboardingLocation2,
              chatId: OnboardingChatter.bot,
            ),
          ],
          respondent: (focusNode) => Future.value(
            ChatRespondent(
              options: [
                Selection(text: TranslationKeys.yes),
                Selection(text: TranslationKeys.addManually),
              ],
              capitalize: true,
            ),
          ),
          modifier: (payload, tag, messages) async {
            if (messages.first == TranslationKeys.yes) {
              final locationManager = LocationService();
              final placemark = await locationManager.getLocation();
              if (placemark != null) {
                payload[DefaultTags.city] = placemark.locality;
                payload[DefaultTags.country] = placemark.country;
                return Future.value(
                  FlowResponse(
                    status: true,
                    payload: {
                      FlowResponseTags.message:
                          "${payload[DefaultTags.city]}, ${payload[DefaultTags.country]}"
                    },
                  ),
                );
              } else {
                return Future.value(
                  FlowResponse(
                    status: false,
                    payload: {
                      FlowResponseTags.emitSubflow:
                          DefaultSuccessResponseTags.addManuallySubstep
                    },
                  ),
                );
              }
            } else {
              return Future.value(
                FlowResponse(
                  status: false,
                  payload: {
                    FlowResponseTags.emitSubflow:
                        DefaultSuccessResponseTags.addManually
                  },
                ),
              );
            }
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
              DefaultTags.location, false),
          successStep: (payload, responsePayload) => [
            ChatMessage(
              tag: DefaultTags.location,
              message: responsePayload[FlowResponseTags.message],
              chatId: OnboardingChatter.user,
              editable: false,
            ),
          ],
          failureSubflow: (payload) {
            if (payload[FlowResponseTags.emitSubflow] ==
                DefaultSuccessResponseTags.addManuallySubstep) {
              return DidntAllowSubstep();
            }
            if (payload[FlowResponseTags.emitSubflow] ==
                DefaultSuccessResponseTags.addManually) {
              return CitySubstep();
            }
            return OnboardingChatSubstepItem.blank;
          },
        );
}

class DidntAllowSubstep extends OnboardingChatSubstepItem {
  DidntAllowSubstep()
      : super(
          flowStep: FlowStep(
            tag: DefaultTags.location,
            flowTag: DefaultFlowTags.location,
          ),
          messages: (payload) => [
            ChatMessage(
              chatId: OnboardingChatter.user,
              message: TranslationKeys.didntAllowLocation,
              status: BubbleStatus.warningError,
              editable: false,
            ),
            ChatMessage(
              chatId: OnboardingChatter.bot,
              message: TranslationKeys.responseDidntAllowLocation,
              editable: false,
            ),
          ],
          isInput: true,
          respondent: (focusNode) => Future.value(
            ChatRespondent(
              options: [
                Selection(text: TranslationKeys.addManually),
              ],
              capitalize: true,
            ),
          ),
          modifySubflow: (payload, messages) {
            return Future.value(
              FlowStepResponse(
                indicator: FlowResponseTags.substepFlow,
                substepAttached: CitySubstep(),
              ),
            );
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
            DefaultTags.location,
            false,
          ),
        );
}

class CitySubstep extends OnboardingChatSubstepItem {
  CitySubstep()
      : super(
          flowStep: FlowStep(
            tag: DefaultTags.city,
            flowTag: DefaultFlowTags.city,
          ),
          messages: (payload) => [
            ChatMessage(
              tag: DefaultFlowTags.city,
              message: TranslationKeys.onboardingCity,
              chatId: OnboardingChatter.bot,
            ),
          ],
          respondent: (focusNode) => DefaultChatResponders.anyText(focusNode),
          modifySubflow: (payload, messages) {
            payload[DefaultTags.city] = messages.first;
            return Future.value(
              FlowStepResponse(
                indicator: FlowResponseTags.substepFlow,
                substepAttached: CountrySubstep(),
              ),
            );
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
              DefaultTags.city, false),
        );
}

class CountrySubstep extends OnboardingChatSubstepItem {
  CountrySubstep()
      : super(
          flowStep: FlowStep(
            tag: DefaultTags.country,
            flowTag: DefaultFlowTags.country,
          ),
          messages: (payload) => [
            ChatMessage(
              tag: DefaultFlowTags.country,
              message: TranslationKeys.onboardingCountry,
              chatId: OnboardingChatter.bot,
            ),
          ],
          isInput: true,
          respondent: (focusNode) => DefaultChatResponders.anyText(focusNode),
          modifySubflow: (payload, messages) {
            payload[DefaultTags.country] = messages.first;
            return Future.value(
                FlowStepResponse(indicator: FlowResponseTags.nextStep));
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
              DefaultTags.city, false),
        );
}
