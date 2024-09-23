
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';

import '../../../../../../presentation/widgets/buttons/selection_view.dart';
import '../../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../../presentation/widgets/chat/chat_responder.dart';
import '../../general/general_flow.dart';
import '../../onboarding_chat_models.dart';
import '../login_flow/login_flow.dart';

List<ChatMessage> Function(Map<String, dynamic>, List<String>)
    createPostDefaultStep() => (data, messages) {
          if (messages.first == TranslationKeys.tryAgainResponse) {
            return [
              ChatMessage(
                tag: LoginTags.existingUser,
                message: TranslationKeys.tryAgainResponse,
                chatId: OnboardingChatter.user,
                editable: false,
              ),
            ];
          }
          return [
            ChatMessage(
              tag: LoginTags.existingUser,
              message: messages.first,
              chatId: OnboardingChatter.user,
              editable: false,
            ),
          ];
        };

class NoExistingAccountSubstep extends OnboardingChatSubstepItem {
  NoExistingAccountSubstep()
      : super(
          flowStep: FlowStep(
            tag: LoginTags.existingUser,
            flowTag: LoginFlowTags.existingUser,
          ),
          messages: (payload) => [
            ChatMessage(
              chatId: OnboardingChatter.bot,
              message: TranslationKeys.loginNoAccount,
              status: BubbleStatus.undeterminedError,
              editable: false,
            ),
          ],
          respondent: (focusNode) => Future.value(
            ChatRespondent(
              options: [
                Selection(text: TranslationKeys.tryAgainResponse),
                Selection(text: TranslationKeys.createNewAccount),
              ],
              capitalize: true,
              forceVertical: true,
            ),
          ),
          modifySubflow: (payload, messages) {
            if (messages.first == TranslationKeys.tryAgainResponse) {
              return Future.value(
                FlowStepResponse(
                  indicator: FlowResponseTags.replaceFlow,
                  flowAttached: LoginFlow(
                    initialStep: 0,
                    ignoreLoginMessage: true,
                  ),
                ),
              );
            } else {
              return Future.value(
                FlowStepResponse(
                  indicator: FlowResponseTags.replaceFlow,
                  flowAttached: GeneralFlow(initialStep: 0),
                ),
              );
            }
          },
          postModifyStep: createPostDefaultStep(),
        );
}
