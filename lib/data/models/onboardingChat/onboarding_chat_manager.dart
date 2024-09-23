import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../presentation/widgets/chat/chat_responder.dart';
import 'flows/onboarding_chat_models.dart';


class OnboardingChatFlowManager {
  FocusNode focusNode = FocusNode();
  final List<OnboardingChatFlow> flows;
  int currentFlowIndex = 0;
  OnboardingChatFlowManager({required this.flows});
  OnboardingChatFlow get currentFlow => flows[currentFlowIndex];

  OnboardingChatFlowItem get currentStep =>
      currentFlow.steps[currentFlow.currentStep];
  int currentStepsLength() => currentFlow.steps.length;
  bool isInLastStepOfFlow() => currentFlow.currentStep == currentStepsLength();
  bool isInLastFlow() => currentFlowIndex == flows.length - 1;

  List<ChatMessage> getCurrentMessages() {
    return currentFlow.getMessages();
  }

  Future<FlowResponse> modify(List<String> messages) async {
    return currentFlow.executeModifier(messages);
  }

  List<ChatMessage> preModifyStep(List<String> messages) {
    return currentFlow.preModifyStep(messages);
  }

  List<ChatMessage> postModifyStep(List<String> messages) {
    return currentFlow.postModifyStep(messages);
  }

  List<ChatMessage> successStep(
    Map<String, dynamic> responsePayload,
  ) {
    return currentFlow.successStep(responsePayload);
  }

  OnboardingChatSubstepItem? failureSubflow(Map<String, dynamic> errorPayload) {
    return currentFlow.failureSubflow(errorPayload);
  }

  Map<String, dynamic> get currentPayload => currentFlow.payload;

  List<Map<String, dynamic>> payloads() {
    return flows.map((flow) => flow.payload).toList();
  }

  Future<ChatRespondent> respondent() {
    return currentStep.respondent(focusNode);
  }

  String currentTag() {
    return currentFlow.currentFlowStep.tag;
  }

  String currentFlowTag() {
    return currentFlow.currentFlowStep.flowTag;
  }

  Future<void> requestFocus(OnboardingChatSubstepItem? substepItem) async {
    if (!isInLastStepOfFlow()) {
      if (currentStep.isInput) {
        focusNode.requestFocus();
      }
      if (substepItem?.isInput ?? false) {
        focusNode.requestFocus();
      }
    }
  }

  void next() {
    currentFlow.currentStep++;
  }

  void previous() {
    if (currentFlow.currentStep == 0) {
      currentFlowIndex--;
      currentFlow.currentStep = currentFlow.steps.length - 1;
    } else {
      currentFlow.currentStep--;
    }
  }

  void nextFlow() {
    currentFlowIndex++;
  }

  void addFlow(OnboardingChatFlow flow) {
    flows.add(flow);
  }

  void replaceFlow(OnboardingChatFlow flow) {
    flows.clear();
    flows.add(flow);
    currentFlowIndex = 0;
  }

  Future<FlowStepResponse?> concludeFlow() async {
    final flowStepResponse = currentFlow.conclusion();
    currentFlow.isConcluded = true;
    if (flowStepResponse.indicator == FlowResponseTags.nextFlow) {
      if (flowStepResponse.flowAttached != null) {
        flows.add(flowStepResponse.flowAttached!);
        nextFlow();
        return Future.value(null);
      }
    }
    return _runCompletionFlow(flowStepResponse);
  }

  Future<FlowStepResponse> _runCompletionFlow(
      FlowStepResponse flowStepResponse) async {
    final Completer<FlowStepResponse> completer = Completer();
    if (flowStepResponse.indicator == FlowResponseTags.completeFlow) {
      if (flowStepResponse.apiFlow != null) {
        final success = await flowStepResponse.apiFlow!.executeAPIFlow();
        if (success) {
          completer.complete(flowStepResponse);
        }
      } else {
        if (flowStepResponse.flowConclusion != null) {
          completer.complete(flowStepResponse);
        }
      }
    }
    return completer.future;
  }

  Future<void> completionFlow(FlowStepResponse flowStepResponse) async {
    if (flowStepResponse.indicator == FlowResponseTags.completeFlow) {
      if (flowStepResponse.completionFlow != null) {
        return flowStepResponse.completionFlow!;
      }
    }
  }
}
