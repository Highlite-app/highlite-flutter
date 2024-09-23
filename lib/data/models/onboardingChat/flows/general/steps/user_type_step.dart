import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';

import '../../../../../../core/constants/user_types.dart';
import '../../../../../../presentation/widgets/buttons/selection_view.dart';
import '../../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../../presentation/widgets/chat/chat_responder.dart';
import '../../../../defaults/onboarding_step_defaults.dart';
import '../general_flow.dart';
import '../../onboarding_chat_models.dart';

class UserTypeStep extends OnboardingChatFlowItem {
  UserTypeStep()
      : super(
          flowStep: FlowStep(
              tag: GeneralTags.userType, flowTag: GeneralFlowTags.userType),
          messages: (payload) => [
            ChatMessage(
              tag: GeneralFlowTags.userType,
              message: TranslationKeys.welcomeToHighLite,
              chatId: OnboardingChatter.bot,
            ),
            ChatMessage(
              tag: GeneralFlowTags.userType,
              message: TranslationKeys.lookingOrHiring,
              chatId: OnboardingChatter.bot,
            ),
          ],
          resetable: false,
          respondent: (focusNode) => Future.value(
            ChatRespondent(
              options: [
                Selection(text: TranslationKeys.looking),
                Selection(text: TranslationKeys.hiring),
              ],
              capitalize: true,
              input: false,
            ),
          ),
          modifier: (payload, tag, messages) async {
            if (messages.first == TranslationKeys.looking) {
              payload[tag] = UserTypes.candidate;
          //    profileSetter.add(VideoFeedUseCaseEvent(userType: UserTypes.candidate));
            } else {
              payload[tag] = UserTypes.company;
           //   profileSetter.add(VideoFeedUseCaseEvent(userType: UserTypes.company));
            }
            return Future.value(FlowResponse.successResponse);
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
            GeneralTags.userType,
            true,
          ),
        );
}
