import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/data/models/defaults/onboarding_step_defaults.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/candidate_steps.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/onboarding_chat_models.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/chat_bubble.dart';

import '../../../../../../core/constants/default_responders.dart';



class PositionStep extends OnboardingChatFlowItem{
  PositionStep()
      :super(
      flowStep:FlowStep(
          tag: CandidateTags.position,
          flowTag: CandidateFlowTag.position),
      messages:(payload) =>[
        ChatMessage(
            tag: CandidateTags.position ,
            message: TranslationKeys.whatKindOfJob ,
            chatId: OnboardingChatter.bot),
      ],
      respondent:(focusNode)=> DefaultChatResponders.name(focusNode),
      modifier: (payload, tag , messages) async{
        payload[tag]= messages.first;
        return Future.value(FlowResponse.successResponse);
      },
      postModifyStep: OnboardingStepDefaults.createPostModifyStepAsWhole(
          CandidateTags.position, true)
  );


}