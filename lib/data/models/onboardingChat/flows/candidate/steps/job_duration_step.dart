import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/defaults/onboarding_step_defaults.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/candidate_steps.dart';

import '../../../../../../presentation/widgets/buttons/selection_view.dart';
import '../../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../../presentation/widgets/chat/chat_responder.dart';
import '../../onboarding_chat_models.dart';
import '../../default_steps/default_steps.dart';

class JobDurationStep extends OnboardingChatFlowItem {
  JobDurationStep()
      : super(
          flowStep: FlowStep(
              tag: CandidateTags.jobDuration,
              flowTag: CandidateFlowTag.jobDuration),
          messages: (payload) => [
            ChatMessage(
              tag: CandidateTags.jobDuration,
              message: TranslationKeys.onboardingJobDuration ,
              chatId: OnboardingChatter.bot,
            ),
          ],
          respondent: (focusNode) => Future.value(
            ChatRespondent(
              options: [
                Selection(text: TranslationKeys.fullTime),
                Selection(text: TranslationKeys.partTime),
                Selection(text: TranslationKeys.bothFullPartTime),
              ],
              capitalize: true,
            ),
          ),
          modifier: (payload, tag, messages) async {
            payload[tag] = messages.first;
            return Future.value(FlowResponse.successResponse);
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
              CandidateTags.jobDuration, true),
        );
}
