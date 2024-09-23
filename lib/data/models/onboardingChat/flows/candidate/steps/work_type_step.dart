

import 'package:flutter/cupertino.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/candidate_steps.dart';

import '../../../../../../presentation/widgets/buttons/selection_view.dart';
import '../../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../../presentation/widgets/chat/chat_responder.dart';
import '../../../../defaults/onboarding_step_defaults.dart';
import '../../onboarding_chat_models.dart';
import '../../default_steps/default_steps.dart';

class WorkTypeStep extends OnboardingChatFlowItem {
  WorkTypeStep()
      : super(
          flowStep: FlowStep(
              tag: CandidateTags.workType,
              flowTag:CandidateFlowTag.workType),
          messages: (payload) => [
            ChatMessage(
              tag: CandidateTags.workType,
              message: TranslationKeys.onboardingJobType,
              chatId: OnboardingChatter.bot,
            ),
          ],
          respondent: (focusNode) => Future.value(
            ChatRespondent(
              options: [
                Selection(text: TranslationKeys.remote),
                Selection(text: TranslationKeys.inOffice),
                Selection(text: TranslationKeys.both),
              ],
              capitalize: true,
            ),
          ),
          modifier: (payload, tag, messages) async {
            payload[tag] = messages.first;
            return Future.value(FlowResponse.successResponse);
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
              CandidateTags.workType, true),
        );
}
