import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/company/company_steps.dart';
import 'package:highlite_flutter_mvp/presentation/pages/dashboard/company_dashboard.dart';

import '../../../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../../../presentation/widgets/chat/chat_responder.dart';
import '../../../../../../presentation/widgets/utils/iterable.dart';
import '../../../../defaults/onboarding_step_defaults.dart';
import '../../default_steps/default_steps.dart';
import '../../onboarding_chat_models.dart';

enum CompanyBenefitsEnum {
  healthInsurance("healthInsurance", "Health Insurance"),
  internationalRelocation(
      "internationalRelocation", "International Relocation"),
  paidTimeOff("paidTimeOff", "Paid Time Off"),
  remoteWork("remoteWork", "Remote Work"),
  retirementPlans("retirementPlans", "Retirement Plans"),
  stockOptions("stockOptions", "Stock Options"),
  wellnessPrograms("wellnessPrograms", "Wellness Programs");

  const CompanyBenefitsEnum(this.id, this.title);

  final String id;
  final String title;
}

class CompanyBenefitsStep extends OnboardingChatFlowItem {
  CompanyBenefitsStep()
      : super(
          flowStep: FlowStep(
              tag: CompanyTags.benefits, flowTag: CompanyFlowTags.benefits),
          messages: (payload) => [
            ChatMessage(
              tag: CompanyTags.benefits,
              message: TranslationKeys.onboardingCompanyBenefits,
              chatId: OnboardingChatter.bot,
            ),
          ],
          respondent: (focusNode) => Future.value(
            ChatRespondent(
              checkBoxHintText: 'Search benefits',
              checkbox: sort(CompanyBenefitsEnum.values
                  .toList()
                  .map((skill) => skill.title)
                  .toList()),
              checkboxSelection: MinMax(1, 3),
            ),
          ),
          modifier: (payload, tag, messages) async {
            payload[tag] = messages;
            return Future.value(FlowResponse.successResponse);
          },
          postModifyStep: OnboardingStepDefaults.createPostModifyStepAsWhole(
              CompanyTags.benefits, true),
        );
}
