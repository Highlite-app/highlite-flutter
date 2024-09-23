import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/defaults/onboarding_step_defaults.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/company/company_steps.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/onboarding_chat_models.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/chat_bubble.dart';

import '../../../../../../core/constants/default_responders.dart';
import '../../default_steps/default_steps.dart';


class CompanyNameStep extends OnboardingChatFlowItem{
   CompanyNameStep()
        :super(
  flowStep:FlowStep(tag: CompanyTags.companyName, flowTag: CompanyFlowTags.companyName),
  messages:(payload) =>[
    ChatMessage(
        tag: CompanyTags.companyName ,
        message:   TranslationKeys.whatsYourCompanyName ,
        chatId: OnboardingChatter.bot),
  ],
  respondent:(focusNode)=> DefaultChatResponders.name(focusNode),
  modifier: (payload, tag , messages) async{
    payload[tag]= messages.first;
    return Future.value(FlowResponse.successResponse);
  },
    postModifyStep: OnboardingStepDefaults.createPostModifyStepAsWhole(
        CompanyTags.companyName, true)
  );


}