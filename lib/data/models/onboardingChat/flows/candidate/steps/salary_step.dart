import 'package:flutter/cupertino.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/candidate_steps.dart';

import '../../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../../presentation/widgets/chat/chat_responder.dart';
import '../../onboarding_chat_models.dart';
import '../../default_steps/default_steps.dart';

class SalaryStep extends OnboardingChatFlowItem {
  SalaryStep()
      : super(
          flowStep: FlowStep(
              tag: CandidateTags.salary, flowTag: CandidateFlowTag.salary),
          messages: (payload) => [
            ChatMessage(
              tag: CandidateTags.salary,
              message:  TranslationKeys.onboardingHourlyRate ,
              chatId: OnboardingChatter.bot,
            ),
          ],
          respondent: (focusNode) => Future.value(
            ChatRespondent(
              input: true,
              focusNode: focusNode,
              keyboardType: TextInputType.number,
              inputType: InputType.currency,
            ),
          ),
          isInput: true,
          modifier: (payload, tag, messages) async {
            payload[tag] = messages.first.replaceAll("\$", "");
            return Future.value(FlowResponse.successResponse);
          },
          postModifyStep: (data, messages) => [
            ChatMessage(
              tag: CandidateTags.salary,
              message: "\$${messages.first}",
              chatId: OnboardingChatter.user,
              editable: true,
            ),
          ],
        );
}
