import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';
import '../../../presentation/widgets/chat/chat_bubble.dart';
import '../onboardingChat/flows/onboarding_chat_models.dart';

class OnboardingStepDefaults {
  static List<ChatMessage> Function(Map<String, dynamic>, List<String>)
      createPostModifyStep(String tag, bool editable) => (data, messages) => [
            ChatMessage(
              tag: tag,
              message: messages.first,
              chatId: OnboardingChatter.user,
              editable: editable,
            ),
          ];

  static List<ChatMessage> Function(Map<String, dynamic>, List<String>)
      createPostModifyStepAsWhole(String tag, bool editable) =>
          (data, messages) => messages
              .mapIndexed(
                (message, index) => ChatMessage(
                  tag: tag,
                  message: message,
                  chatId: OnboardingChatter.user,
                  editable: index == messages.length - 1,
                ),
              )
              .toList();
}
