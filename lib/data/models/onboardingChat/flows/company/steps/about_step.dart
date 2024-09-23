import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/company/company_steps.dart';

import '../../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../../presentation/widgets/chat/chat_responder.dart';
import '../../../../defaults/onboarding_step_defaults.dart';
import '../../default_steps/default_steps.dart';
import '../../onboarding_chat_models.dart';

class AboutStep extends OnboardingChatFlowItem {
  AboutStep(bool isCandidate)
      : super(
          flowStep:
              FlowStep(tag: CompanyTags.about, flowTag: CompanyFlowTags.about),
          messages: (payload) => [
            ChatMessage(
              tag: CompanyFlowTags.about,
              message:  isCandidate ? TranslationKeys.aboutCandidate:TranslationKeys.aboutCompany,
              chatId: OnboardingChatter.bot,
            ),
          ],
          respondent: (focusNode) => Future.value(
            ChatRespondent(
              input: true,
              focusNode: focusNode,
              minMaxLines: MinMax(1, 5),
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          isInput: true,
          modifier: (payload, tag, messages) async {
            if (messages.first.toString().length <= 150) {
              payload[tag] = messages.first;
              return Future.value(FlowResponse.successResponse);
            } else {
              return Future.value(
                FlowResponse(
                  status: false,
                  payload: {
                    FlowResponseTags.emitSubflow:
                        DefaultSuccessResponseTags.aboutExceeding
                  },
                ),
              );
            }
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
              CompanyTags.about, true),
          failureSubflow: (payload) {
            if (payload[FlowResponseTags.emitSubflow] ==
                DefaultSuccessResponseTags.aboutExceeding) {
              return ExceedingAboutSubstep();
            }
            return OnboardingChatSubstepItem.blank;
          },
        );
}

class ExceedingAboutSubstep extends OnboardingChatSubstepItem {
  ExceedingAboutSubstep()
      : super(
          flowStep: FlowStep(
            tag: CompanyFlowTags.about,
            flowTag: CompanyFlowTags.about,
          ),
          messages: (payload) => [
            ChatMessage(
              tag: CompanyFlowTags.about,
              chatId: OnboardingChatter.bot,
              message:
                  'Looks like you exceeded the character limit. Please keep it short and within 150 characters and try again.',
              status: BubbleStatus.warningError,
              editable: false,
            ),
            ChatMessage(
              tag: CompanyFlowTags.about,
              chatId: OnboardingChatter.bot,
              message:
                  'Please tell me about your \ncompany. What kind of work do \nyou do?',
              editable: false,
            ),
          ],
          isInput: true,
          respondent: (focusNode) => Future.value(
            ChatRespondent(
              input: true,
              focusNode: focusNode,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          modifySubflow: (payload, messages) {
            if (messages.first.toString().length <= 150) {
              payload[CompanyFlowTags.about] = messages.first;
              return Future.value(
                FlowStepResponse(
                  indicator: FlowResponseTags.nextStep,
                ),
              );
            } else {
              return Future.value(
                FlowStepResponse(
                  indicator: FlowResponseTags.substepFlow,
                  substepAttached: ExceedingAboutSubstep(),
                ),
              );
            }
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
              CompanyFlowTags.about, false),
        );
}
