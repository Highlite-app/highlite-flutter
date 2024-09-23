import 'package:highlite_flutter_mvp/presentation/widgets/chat/chat_responder.dart';

import '../../../data/models/onboardingChat/flows/onboarding_chat_models.dart';
import '../../widgets/chat/chat_bubble.dart';

abstract class OnBoardingChatEvent {
  const OnBoardingChatEvent();
}

class OnboardingChatStartEvent extends OnBoardingChatEvent {
  const OnboardingChatStartEvent(this.flows);

  final List<OnboardingChatFlow> flows;
}

class OnboardingSendChatEvent extends OnBoardingChatEvent {
  const OnboardingSendChatEvent(this.message);

  final List<String> message;
}

class SubflowResponseEvent extends OnBoardingChatEvent {
  const SubflowResponseEvent(this.message);

  final List<String> message;
}

class EmitMessagesEvent extends OnBoardingChatEvent {
  const EmitMessagesEvent({
    required this.message,
    required this.responder,
    required this.continueNextFlow,
    required this.clearEditable,
    this.validTagsForEdit,
    this.subflow,
    this.flowResponse,
  });

  final List<ChatMessage> message;
  final ChatRespondent responder;
  final bool continueNextFlow;
  final bool clearEditable;
  final String? validTagsForEdit;
  final OnboardingChatSubstepItem? subflow;
  final FlowResponse? flowResponse;
}

class EmitNextFlowEvent extends OnBoardingChatEvent {
  const EmitNextFlowEvent();
}

class EmitSubflowEvent extends OnBoardingChatEvent {
  const EmitSubflowEvent(
    this.message,
    this.responder,
    this.subflow,
  );

  final List<ChatMessage> message;
  final ChatRespondent responder;
  final OnboardingChatSubstepItem subflow;
}

class OnboardingPreviousStepEvent extends OnBoardingChatEvent {
  const OnboardingPreviousStepEvent(this.message);

  final ChatMessage message;
}

class EmitDelayedRespondentEvent extends OnBoardingChatEvent {
  final Duration duration;
  final ChatRespondent respondent;
  final int currentIndex;

  const EmitDelayedRespondentEvent(
    this.duration,
    this.respondent,
    this.currentIndex,
  );
}

class InvokeResponderEvent extends OnBoardingChatEvent {
  final ChatRespondent responder;

  const InvokeResponderEvent(
    this.responder,
  );
}
