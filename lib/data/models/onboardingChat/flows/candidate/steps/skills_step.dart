

import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/candidate_steps.dart';

import '../../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../../presentation/widgets/chat/chat_responder.dart';
import '../../../../defaults/onboarding_step_defaults.dart';
import '../../onboarding_chat_models.dart';

enum Skill {
  accountant("accountant", "Accountant"),
  administrativeAssistant(
      "administrativeAssistant", "Administrative Assistant"),
  animation("animation", "Animation"),
  appointmentSetter("appointmentSetter", "Appointment Setter"),
  bookkeeper("bookkeeper", "Bookkeeper"),
  copywriter("copywriter", "Copywriter"),
  dataEntry("dataEntry", "Data Entry"),
  customerSupport("customerSupport", "Customer Support"),
  dataScraper("dataScraper", "Data Scraper"),
  seo("seo", "SEO"),
  digitalMarketer("digitalMarketer", "Digital Marketer"),
  graphicDesign("graphicDesign", "Graphic Design"),
  ui("ui", "UI"),
  photoEditor("photoEditor", "Photo Editor"),
  ux("ux", "UX"),
  softwareDeveloper("softwareDeveloper", "Software Developer"),
  salesRepresentative("salesRepresentative", "Sales Representative"),
  transactionManager("transactionManager", "Transaction Manager"),
  taxPreparation("taxPreparation", "Tax Preparation"),
  other("other", "Other");

  const Skill(this.id, this.title);
  final String id;
  final String title;
}

class SkillsStep extends OnboardingChatFlowItem {
  SkillsStep()
      : super(
    flowStep: FlowStep(
        tag: CandidateTags.skills, flowTag: CandidateFlowTag.skills),
    messages: (payload) => [
      ChatMessage(
        tag:CandidateTags.skills,
        message:  TranslationKeys.onboardingSkills,
        chatId: OnboardingChatter.bot,
      ),
    ],
    respondent: (focusNode) => Future.value(
      ChatRespondent(
        checkbox: Skill.values.map((skill) => skill.title).toList()..sort(),
        checkBoxHintText: 'Search Skills',
        checkboxSelection: MinMax(1, 3),
      ),
    ),
    modifier: (payload, tag, messages) async {
      payload[tag] = messages;
      return Future.value(FlowResponse.successResponse);
    },
    postModifyStep: OnboardingStepDefaults.createPostModifyStepAsWhole(
        CandidateTags.skills, true),
  );
}
