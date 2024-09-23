import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../../presentation/widgets/chat/chat_bubble.dart';
import '../../../../presentation/widgets/chat/chat_responder.dart';

class OnboardingChatter {
  static String bot = 'bot';
  static String user = 'user';
}

class FlowResponse {
  final bool status;
  final Map<String, dynamic> payload;
  const FlowResponse({required this.status, required this.payload});
  static FlowResponse get successResponse =>
      const FlowResponse(status: true, payload: {});
}

class FlowResponseTags {
  static String response = 'response';
  static String emitSubflow = 'emitSubflow';
  static String repeatFlow = 'repeatFlow';
  static String repeatStep = 'repeatStep';
  static String nextStep = 'nextStep';
  static String nextFlow = 'nextFlow';
  static String replaceFlow = 'replaceFlow';
  static String message = 'message';
  static String substepFlow = 'substepFlow';
  static String completeFlow = 'completeFlow';
}

class FlowStep {
  final String tag;
  final String flowTag;
  const FlowStep({
    required this.tag,
    required this.flowTag,
  });
}

abstract class APIFlow {
  bool executed = false;
  Future<bool> executeAPIFlow() {
    executed = true;
    return execute();
  }
  Future<bool> execute();
}

abstract class OnboardingChatFlow<Model> {
  late final List<OnboardingChatFlowItem> steps;
  late Map<String, dynamic> payload;
  late int currentStep;
  FlowStep get currentFlowStep => steps[currentStep].flowStep;
  OnboardingChatFlowItem get currentItem => steps[currentStep];
  late final FlowStepResponse Function() conclusion;
  bool isConcluded = false;
  bool get inLastStep => currentStep == steps.length - 1;
  final int initialStep;
  OnboardingChatFlow({required this.initialStep}) {
    payload = {
      "createdAt": DateFormat("yyyy-MM-ddTHH:mm:ss.'Z'")
            .format(DateTime.now()),
      "updatedAt": DateFormat("yyyy-MM-ddTHH:mm:ss.'Z'")
            .format(DateTime.now())
    };
    currentStep = initialStep;
  }
  List<ChatMessage> getMessages() {
    return steps[currentStep].messages(payload);
  }

  Model getGeneratedModel();

  Future<FlowResponse> executeModifier(List<String> messages) async {
    return steps[currentStep]
        .modifier(payload, steps[currentStep].flowStep.tag, messages);
  }

  List<ChatMessage> preModifyStep(List<String> messages) {
    if (steps[currentStep].preModifyStep != null) {
      return steps[currentStep].preModifyStep!(payload, messages);
    }
    return [];
  }

  List<ChatMessage> postModifyStep(List<String> messages) {
    return steps[currentStep].postModifyStep(payload, messages);
  }

  List<ChatMessage> successStep(Map<String, dynamic> responsePayload) {
    if (steps[currentStep].successStep != null) {
      return steps[currentStep].successStep!(payload, responsePayload);
    }
    return [];
  }

  OnboardingChatSubstepItem? failureSubflow(Map<String, dynamic> errorPayload) {
    if (steps[currentStep].failureSubflow != null) {
      return steps[currentStep].failureSubflow!(errorPayload);
    } else {
      return null;
    }
  }
}

class FlowConclusion {
  final List<ChatMessage> Function(List<Map<String, dynamic>>) successMessages;
  const FlowConclusion({required this.successMessages});
}

class OnboardingChatFlowItem {
  final FlowStep flowStep;
  final bool isInput;
  final List<ChatMessage> Function(Map<String, dynamic>) messages;
  final Future<ChatRespondent> Function(FocusNode) respondent;
  final Future<ChatRespondent> Function(FocusNode)? delayedRespondent;
  final Duration? delayedRespondentDuration;
  final Future<FlowResponse> Function(
      Map<String, dynamic>, String, List<String>) modifier;
  final List<ChatMessage> Function(
      Map<String, dynamic> payload, List<String> messages)? preModifyStep;
  final List<ChatMessage> Function(
      Map<String, dynamic> payload, List<String> messages) postModifyStep;
  final List<ChatMessage> Function(
          Map<String, dynamic> payload, Map<String, dynamic> successPayload)?
      successStep;
  final OnboardingChatSubstepItem Function(Map<String, dynamic>)?
      failureSubflow;
  final bool resetable;
  const OnboardingChatFlowItem({
    required this.flowStep,
    this.isInput = false,
    this.resetable = true,
    required this.messages,
    required this.respondent,
    this.delayedRespondent,
    this.delayedRespondentDuration,
    required this.modifier,
    this.preModifyStep,
    this.successStep,
    required this.postModifyStep,
    this.failureSubflow,
  });
}

class FlowStepResponse {
  final String indicator;
  final OnboardingChatFlow? flowAttached;
  final OnboardingChatSubstepItem? substepAttached;
  final FlowConclusion? flowConclusion;
  final APIFlow? apiFlow;
  final Future<void>? completionFlow;
  const FlowStepResponse({
    required this.indicator,
    this.flowAttached,
    this.substepAttached,
    this.flowConclusion,
    this.apiFlow,
    this.completionFlow,
  });
}

class OnboardingChatSubstepItem {
  final FlowStep flowStep;
  final bool isInput;
  final List<ChatMessage> Function(Map<String, dynamic>) messages;
  final Future<ChatRespondent> Function(FocusNode) respondent;
  final bool resetable;
  final List<ChatMessage> Function(Map<String, dynamic>, List<String>)
      postModifyStep;
  final Future<FlowStepResponse> Function(Map<String, dynamic>, List<String>)
      modifySubflow;
  final Future<ChatRespondent> Function(FocusNode)? delayedRespondent;
  final Duration? delayedRespondentDuration;
  const OnboardingChatSubstepItem({
    required this.flowStep,
    this.isInput = false,
    this.resetable = true,
    required this.messages,
    required this.respondent,
    required this.postModifyStep,
    required this.modifySubflow,
    this.delayedRespondent,
    this.delayedRespondentDuration,
  });

  static OnboardingChatSubstepItem get blank => OnboardingChatSubstepItem(
        flowStep: const FlowStep(tag: "", flowTag: ""),
        messages: (p1) => [],
        respondent: (p1) => Future.value(const ChatRespondent()),
        postModifyStep: (p0, p1) => [],
        modifySubflow: (p0, p1) =>
            Future.value(const FlowStepResponse(indicator: "")),
      );
}
