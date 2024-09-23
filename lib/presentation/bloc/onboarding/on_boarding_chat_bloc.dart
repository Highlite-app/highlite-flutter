import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/onboarding/onboarding_chat_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/onboarding/onboarding_chat_state.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/list.dart';

import '../../../data/models/onboardingChat/flows/onboarding_chat_models.dart';
import '../../../data/models/onboardingChat/onboarding_chat_manager.dart';
import '../../widgets/chat/chat_bubble.dart';
import '../../widgets/chat/chat_responder.dart';

class OnBoardingChatBloc
    extends Bloc<OnBoardingChatEvent, OnBoardingChatState> {
  late OnboardingChatFlowManager flowManager;

  OnBoardingChatBloc() : super(OnBoardingChatState()) {
    on<OnboardingChatStartEvent>(_handleOnboardingStart);
    on<OnboardingSendChatEvent>(_handleSendChat);
    on<EmitNextFlowEvent>(_handleEmitNextFlow);
    on<EmitSubflowEvent>(_handleEmitSubflow);
    on<EmitMessagesEvent>(_handleEmitMessage);
    on<OnboardingPreviousStepEvent>(_handlePreviousStep);
    on<SubflowResponseEvent>(_handleSubflowResponse);
    on<EmitDelayedRespondentEvent>(_afterInvokeRespondentStep);
    on<InvokeResponderEvent>(_handleInvokeResponder);
  }

  Future<void> _handleOnboardingStart(
      OnboardingChatStartEvent event, Emitter<OnBoardingChatState> emit) async {
    List<ChatMessage> messages = [];
    state.messages.mapTo(messages, (message) => false);
    emit(state.copyWith(messages: messages));
    flowManager = OnboardingChatFlowManager(flows: event.flows);
    add(const EmitNextFlowEvent());
  }

  Future<void> _handleEmitNextFlow(
    EmitNextFlowEvent event,
    Emitter<OnBoardingChatState> emit,
  ) async {
    emit(state.copyWith(isEmittingNextFlow: true));
    if (flowManager.isInLastStepOfFlow()) {
      if (!flowManager.currentFlow.isConcluded) {
        emit(state.copyWith(showIndicator: true));
        final stepResponse = await flowManager.concludeFlow();
        if (stepResponse != null && stepResponse.flowConclusion != null) {
          await mapAsync(
            stepResponse.flowConclusion
                    ?.successMessages(flowManager.payloads()) ??
                [],
            (element) => element,
            emit,
            () async {
              await flowManager.completionFlow(stepResponse);
            },
          );
        }
        emit(state.copyWith(
            showIndicator: false, chatRespondent: const ChatRespondent()));
      }
    } else {
      final flow = flowManager.currentStep;
      emit(
        state.copyWith(
          flowStep: flow.flowStep,
          resetable: flow.resetable,
        ),
      );
      final respondent = await flowManager.respondent();
      await mapAsync(
          flowManager.getCurrentMessages(), (element) => element, emit, null);
      emit(state.copyWith(showIndicator: false, chatRespondent: respondent));
      if (flow.delayedRespondentDuration != null &&
          flow.delayedRespondent != null) {
        final delayedRespondent =
            await flow.delayedRespondent!(flowManager.focusNode);
        add(
          EmitDelayedRespondentEvent(
            flow.delayedRespondentDuration!,
            delayedRespondent,
            flowManager.currentFlowIndex,
          ),
        );
      }
    }
    emit(state.copyWith(isEmittingNextFlow: false));
  }

  Future<void> _afterInvokeRespondentStep(
    EmitDelayedRespondentEvent event,
    Emitter<OnBoardingChatState> emit,
  ) async {
    if (event.currentIndex == flowManager.currentFlowIndex) {
      Future.delayed(event.duration).then((value) {
        if (event.currentIndex == flowManager.currentFlow.currentStep &&
            state.isEmittingNextFlow == false) {
          add(InvokeResponderEvent(event.respondent));
        }
      });
    }
  }

  Future<void> _handleInvokeResponder(
    InvokeResponderEvent event,
    Emitter<OnBoardingChatState> emit,
  ) async {
    if (state.isEmittingNextFlow == false) {
      emit(
        state.copyWith(
          chatRespondent: event.responder,
        ),
      );
    }
  }

  Future<void> _handleSendChat(
    OnboardingSendChatEvent event,
    Emitter<OnBoardingChatState> emit,
  ) async {
    if (state.inSubflow == true && state.subflow != null) {
      add(SubflowResponseEvent(event.message));
    } else {
      List<ChatMessage> messages = [];
      state.messages.mapTo(messages, (p0) => true);
      for (var item in flowManager.preModifyStep(event.message)) {
        messages.add(item);
      }
      emit(state.copyWith(messages: messages, showIndicator: true));
      final flowResponse = await flowManager.modify(event.message);
      add(
        EmitMessagesEvent(
          message: flowManager.postModifyStep(event.message),
          responder: const ChatRespondent(),
          continueNextFlow: flowResponse.status == true,
          clearEditable: true,
          validTagsForEdit: flowManager.currentTag(),
          flowResponse: flowResponse,
        ),
      );
    }
  }

  Future<void> _handleSubflowResponse(
    SubflowResponseEvent event,
    Emitter<OnBoardingChatState> emit,
  ) async {
    final subflow = state.subflow;
    final payload = flowManager.currentPayload;
    emit(state.copyWith(showIndicator: true));
    await mapAsync(
      subflow!.postModifyStep(payload, event.message),
      (element) {
        if (subflow.flowStep.tag != element.tag) {
          element.editable = false;
        }
        return element;
      },
      emit,
      null,
    );
    final flowStepResponse =
        await subflow.modifySubflow(payload, event.message);
    if (flowStepResponse.indicator == FlowResponseTags.nextStep) {
      flowManager.next();
      add(const EmitNextFlowEvent());
      emit(state.copyWith(inSubflow: false, subflow: null));
    } else if (flowStepResponse.indicator == FlowResponseTags.repeatFlow) {
      emit(state.copyWith(inSubflow: false, subflow: null));
      add(const EmitNextFlowEvent());
    } else if (flowStepResponse.indicator == FlowResponseTags.repeatStep) {
      emit(state.copyWith(inSubflow: false, subflow: null));
      add(const EmitNextFlowEvent());
    } else if (flowStepResponse.indicator == FlowResponseTags.substepFlow) {
      emit(state.copyWith(inSubflow: false, subflow: null));
      final subflow = flowStepResponse.substepAttached!;
      final payload = flowManager.currentPayload;
      add(
        EmitSubflowEvent(
          subflow.messages(payload),
          await subflow.respondent(flowManager.focusNode),
          subflow,
        ),
      );
    } else if (flowStepResponse.indicator == FlowResponseTags.nextFlow) {
      emit(state.copyWith(inSubflow: false, subflow: null));
      final flowToContinue = flowStepResponse.flowAttached!;
      flowManager.addFlow(flowToContinue);
      flowManager.next();
      add(const EmitNextFlowEvent());
    } else if (flowStepResponse.indicator == FlowResponseTags.replaceFlow) {
      emit(state.copyWith(inSubflow: false, subflow: null));
      final flowToContinue = flowStepResponse.flowAttached!;
      flowManager.replaceFlow(flowToContinue);
      add(const EmitNextFlowEvent());
    } else if (flowStepResponse.indicator == FlowResponseTags.completeFlow) {
      emit(state.copyWith(showIndicator: true));
      final stepResponse = await flowManager.concludeFlow();
      if (stepResponse != null && stepResponse.flowConclusion != null) {
        await mapAsync(
          stepResponse.flowConclusion
                  ?.successMessages(flowManager.payloads()) ??
              [],
          (element) => element,
          emit,
          null,
        );
        emit(state.copyWith(
            showIndicator: false, chatRespondent: const ChatRespondent()));
      }
    }
  }

  Future<void> _handleEmitSubflow(
    EmitSubflowEvent event,
    Emitter<OnBoardingChatState> emit,
  ) async {
    await mapAsync(event.message, (element) {
      if (event.subflow.flowStep.tag != element.tag) {
        element.editable = false;
      }
      return element;
    }, emit, null);
    emit(state.copyWith(showIndicator: false, chatRespondent: event.responder));
    flowManager.requestFocus(event.subflow);
    emit(
      state.copyWith(
        inSubflow: true,
        subflow: event.subflow,
      ),
    );
    if (event.subflow.delayedRespondentDuration != null &&
        event.subflow.delayedRespondent != null) {
      add(
        EmitDelayedRespondentEvent(
          event.subflow.delayedRespondentDuration!,
          await event.subflow.delayedRespondent!(flowManager.focusNode),
          flowManager.currentFlowIndex,
        ),
      );
    }
  }

  Future<void> _handlePreviousStep(
    OnboardingPreviousStepEvent event,
    Emitter<OnBoardingChatState> emit,
  ) async {
    List<ChatMessage> messages = [];
    state.messages.mapTo(
      messages,
      (message) =>
          message.tag != flowManager.currentFlowTag() &&
          message.tag != event.message.tag,
    );
    flowManager.previous();
    final respondent = await flowManager.respondent();
    emit(
      state.copyWith(
        messages: messages,
        chatRespondent: respondent,
      ),
    );
  }

  Future<void> _handleEmitMessage(
    EmitMessagesEvent event,
    Emitter<OnBoardingChatState> emit,
  ) async {
    await mapAsync(event.message, (element) {
      if (event.validTagsForEdit != null) {
        if (event.clearEditable && element.tag != event.validTagsForEdit) {
          element.editable = false;
        }
      }
      return element;
    }, emit, null);
    emit(state.copyWith(showIndicator: false, chatRespondent: event.responder));
    final subflow = event.subflow;
    if (subflow != null) {
      final payload = flowManager.currentPayload;
      final respondent = await subflow.respondent(flowManager.focusNode);
      add(EmitSubflowEvent(subflow.messages(payload), respondent, subflow));
    } else {
      if (event.flowResponse != null) {
        final flowResponse = event.flowResponse!;
        if (flowResponse.status == true) {
          if (flowResponse.payload[FlowResponseTags.emitSubflow] != null) {
            add(
              const EmitMessagesEvent(
                message: [],
                responder: ChatRespondent(),
                continueNextFlow: false,
                clearEditable: false,
              ),
            );
          } else {
            if (flowResponse.payload[FlowResponseTags.message] != null) {
              add(
                EmitMessagesEvent(
                  message: flowManager.successStep(flowResponse.payload),
                  responder: const ChatRespondent(),
                  continueNextFlow: true,
                  clearEditable: false,
                  validTagsForEdit: flowManager.currentTag(),
                ),
              );
            } else {
              add(
                EmitMessagesEvent(
                  message: [],
                  responder: const ChatRespondent(),
                  continueNextFlow: true,
                  clearEditable: false,
                  validTagsForEdit: flowManager.currentTag(),
                ),
              );
            }
            flowManager.next();
          }
        } else {
          add(
            EmitMessagesEvent(
              message: [],
              responder: const ChatRespondent(),
              continueNextFlow: false,
              clearEditable: false,
              validTagsForEdit: flowManager.currentTag(),
              subflow: flowManager.failureSubflow(flowResponse.payload),
            ),
          );
        }
      }
    }

    if (event.continueNextFlow) {
      flowManager.requestFocus(null);
      add(const EmitNextFlowEvent());
    }
  }

  Future<void> mapAsync(
    List<ChatMessage> messagesToAdd,
    ChatMessage Function(ChatMessage) map,
    Emitter<OnBoardingChatState> emit,
    Function? conclusion,
  ) async {
    List<ChatMessage> messages = [];
    state.messages.mapWithModify(messages, map, (p0) => true);
    emit(state.copyWith(showIndicator: true));
    for (var item in messagesToAdd) {
      if (item.chatId == OnboardingChatter.bot) {
        await Future.delayed(const Duration(milliseconds: 800));
      } else {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      messages.add(item);
      emit(state.copyWith(messages: messages));
    }
    if (conclusion != null) {
      conclusion();
    }
  }

  Future<void> _handleEmitDelay(EmitDelayedRespondentEvent event,
      Emitter<OnBoardingChatState> emit) async {}
}
