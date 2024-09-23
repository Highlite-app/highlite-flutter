
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/candidate_steps.dart';

import '../../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../../presentation/widgets/chat/chat_responder.dart';
import '../../../../defaults/onboarding_step_defaults.dart';
import '../../onboarding_chat_models.dart';
import '../../default_steps/default_steps.dart';

enum Tool {
  airtable("airtable", "Airtable"),
  adobePremierPro("adobePremierPro", "Adobe Premier Pro"),
  adobePhotoshop("adobePhotoshop", "Adobe Photoshop"),
  androidStudio("androidStudio", "Android Studio"),
  close("close", "Close"),
  figma("figma", "Figma"),
  finalCutPro("finalCutPro", "Final Cut Pro"),
  flutter("flutter", "Flutter"),
  gmail("gmail", "Gmail"),
  googleDocs("googleDocs", "Google Docs"),
  slack("slack", "Slack"),
  typeform("typeform", "Typeform"),
  visualStudioCode("visualStudioCode", "Visual Studio Code"),
  xcode("xcode", "XCode"),
  other("other", "Other");

  const Tool(this.id, this.title);
  final String id;
  final String title;
}

class ToolsStep extends OnboardingChatFlowItem {
  ToolsStep()
      : super(
          flowStep: FlowStep(
              tag: CandidateTags.tools, flowTag: CandidateFlowTag.tools),
          messages: (payload) => [
            ChatMessage(
              tag: CandidateTags.skills,
              message:TranslationKeys.onboardingTools,
              chatId: OnboardingChatter.bot,
            ),
          ],
          respondent: (focusNode) => Future.value(
            ChatRespondent(
              checkbox:Tool.values.map((tool) => tool.title).toList(),
              checkBoxHintText: 'Search Tools',
              checkboxSelection: MinMax(1, 3),
            ),
          ),
          modifier: (payload, tag, messages) async {
            payload[tag] = messages;
            return Future.value(FlowResponse.successResponse);
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStepAsWhole(
              CandidateTags.tools, true),
        );
}
