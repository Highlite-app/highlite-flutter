import '../../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../../presentation/widgets/chat/chat_responder.dart';
import '../../../../../../presentation/widgets/utils/iterable.dart';
import '../../../../defaults/onboarding_step_defaults.dart';
import '../../onboarding_chat_models.dart';
import '../company_steps.dart';


enum IndustryType{
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

  const IndustryType(this.id, this.title);
  final String id;
  final String title;
}






class CompanyIndustryStep extends OnboardingChatFlowItem {
  CompanyIndustryStep()
      : super(
          flowStep: FlowStep(
            tag: CompanyTags.industry,
            flowTag: CompanyFlowTags.industry,
          ),
          messages: (payload) => [
            ChatMessage(
              tag: CompanyFlowTags.industry,
              message: 'What is your industry type?',
              chatId: OnboardingChatter.bot,
            ),
          ],
          isInput: true,
           respondent: (focusNode) => Future.value(
           ChatRespondent(
             checkBoxHintText: "Search industries",
          checkbox: sort(IndustryType.values.toList().map((skill) => skill.title).toList()) ,
          checkboxSelection: MinMax(1, 1),
      ),
    ),
          modifier: (payload, tag, messages) async {
            payload[tag] = messages.first;
            return Future.value(FlowResponse.successResponse);
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStep(
            CompanyTags.industry,
            true,
          ),
        );
}
