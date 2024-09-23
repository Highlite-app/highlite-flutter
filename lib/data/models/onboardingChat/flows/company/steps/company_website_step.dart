import 'package:flutter/material.dart';
import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../../presentation/widgets/chat/chat_responder.dart';
import '../../../../defaults/onboarding_step_defaults.dart';
import '../../onboarding_chat_models.dart';
import '../company_steps.dart';

class CompanyWebsiteStep extends OnboardingChatFlowItem {
  CompanyWebsiteStep()
      : super(
          flowStep: FlowStep(
            tag: CompanyTags.website,
            flowTag: CompanyFlowTags.website,
          ),
          messages: (payload) => [
            ChatMessage(
              tag: CompanyFlowTags.website,
              message: TranslationKeys.whatIsYourWebsite,
              chatId: OnboardingChatter.bot,
            ),
          ],
          isInput: true,
          respondent: (focusNode) => Future.value(
            ChatRespondent(
              input: true,
              focusNode: focusNode,
              keyboardType: TextInputType.url,
            ),
          ),
          modifier: (payload, tag, messages) async {
            payload[tag] = messages.first;
            return Future.value(FlowResponse.successResponse);
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
            CompanyTags.website,
            true,
          ),
        );
}
