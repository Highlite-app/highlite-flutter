
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/user_types.dart';
import '../candidate/candidate_flow.dart';
import '../company/company_flow.dart';
import '../onboarding_chat_models.dart';
import 'general_flow_model.dart';
import 'general_steps.dart';

class GeneralTags {

  static String userType = 'userType';

}

class GeneralFlowTags {
  static String userType = 'userType_flow';
}



class GeneralFlow extends OnboardingChatFlow<GeneralFlowModel> {
  GeneralFlow({required super.initialStep});

  @override
  List<OnboardingChatFlowItem> get steps => [

        GeneralSteps.userType,

      ];
  @override
  FlowStepResponse Function() get conclusion => () {
        GeneralFlowModel flowModel = getGeneratedModel();
        debugPrint("********|| CANDIDATE || *********");
        debugPrint("The User-Type is :::${flowModel.userType}");
        if (flowModel.userType == UserTypes.candidate) {
          GeneralFlowTags.userType = UserTypes.candidate ;
          return FlowStepResponse(
            indicator: FlowResponseTags.nextFlow,
            flowAttached: CandidateFlow(
              initialStep: 0,
              generalSection: flowModel,
            ),
          );
        } else {
          GeneralFlowTags.userType = UserTypes.company ;
          debugPrint("********|| COMPANY || *********");
          debugPrint("The User-Type is :::${flowModel.userType}");
          return FlowStepResponse(
            indicator: FlowResponseTags.nextFlow,
            flowAttached: CompanyFlow(
              initialStep: 0,
              generalModel: flowModel,
            ),
          );
        }
      };

  @override
  GeneralFlowModel getGeneratedModel() {
    GeneralFlowModel flowModel = GeneralFlowModel.fromJson(payload);
    return flowModel;
  }
}
