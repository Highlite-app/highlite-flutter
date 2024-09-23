import '../../../data/models/onboardingChat/flows/onboarding_chat_models.dart';
import '../../widgets/chat/chat_bubble.dart';
import '../../widgets/chat/chat_responder.dart';

class OnBoardingChatState {
  final FlowStep? flowStep;
  final List<ChatMessage> messages;
  final ChatRespondent chatRespondent;
  final bool showIndicator;
  final bool resetable;
  final bool inSubflow;
  final OnboardingChatSubstepItem? subflow;
  final bool isEmittingNextFlow;

  OnBoardingChatState({
    this.flowStep,
    this.messages = const [],
    this.chatRespondent = const ChatRespondent(),
    this.showIndicator = false,
    this.resetable = false,
    this.inSubflow = false,
    this.subflow,
    this.isEmittingNextFlow = false,
  });

  OnBoardingChatState copyWith({
    FlowStep? flowStep,
    List<ChatMessage>? messages,
    ChatRespondent? chatRespondent,
    bool? showIndicator,
    bool? resetable,
    bool? inSubflow,
    OnboardingChatSubstepItem? subflow,
    bool? isEmittingNextFlow,
  }) =>
      OnBoardingChatState(
        flowStep: flowStep,
        messages: messages ?? this.messages,
        chatRespondent: chatRespondent ?? this.chatRespondent,
        showIndicator: showIndicator ?? this.showIndicator,
        resetable: resetable ?? this.resetable,
        inSubflow: inSubflow ?? this.inSubflow,
        subflow: subflow ?? this.subflow,
        isEmittingNextFlow: isEmittingNextFlow ?? this.isEmittingNextFlow,
      );
}

class InitialState extends OnBoardingChatState {}

class ChatState extends OnBoardingChatState {}
