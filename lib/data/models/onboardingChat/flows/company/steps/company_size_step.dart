import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/presentation/pages/dashboard/company_dashboard.dart';
import '../../../../../../presentation/widgets/buttons/selection_view.dart';
import '../../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../../presentation/widgets/chat/chat_responder.dart';
import '../../../../../../presentation/widgets/utils/iterable.dart';
import '../../../../defaults/onboarding_step_defaults.dart';
import '../../onboarding_chat_models.dart';
import '../../default_steps/default_steps.dart';
import '../company_steps.dart';

enum Skill {
  zeroToHunter("0-50", "0-50"),
  administrativeAssistant(
      "5-100", "5-100"),
  animation("100-250", "100-250"),
  appointmentSetter("250-500", "Appointment Setter"),
  bookkeeper("500-1000", "500-1000"),
  copywriter("1000 +", "1000 +");


  const Skill(this.id, this.title);
  final String id;
  final String title;
}




class CompanySizeStep extends OnboardingChatFlowItem {
  CompanySizeStep()
      : super(
          flowStep: FlowStep(
              tag: CompanyTags.companySize, flowTag: CompanyFlowTags.companySize),
          messages: (payload) => [
            ChatMessage(
              tag: CompanyTags.companySize,
              message:  TranslationKeys.onboardingCompanySize,
              chatId: OnboardingChatter.bot,
            ),
          ],
          //TODO :MAKE SURE CHANGE IN CANDIDATE
          respondent: (focusNode) => Future.value(
            ChatRespondent(
              options: [
                Selection(text: TranslationKeys.zeroTwoFifty),
                Selection(text: TranslationKeys.fiftyTwoHundred),
                Selection(text: TranslationKeys.hundredToTwoFifty),
                Selection(text: TranslationKeys.twoFiftyToFiveHundred),
                Selection(text: TranslationKeys.fiveHundredToThousand),
                Selection(text: TranslationKeys.thousandPlus),
              ],
              capitalize: true,
            ),
          ),
          modifier: (payload, tag, messages) async {
            payload[tag] = messages;
            return Future.value(FlowResponse.successResponse);
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStepAsWhole(
              CompanyTags.companySize, true),
        );
}
