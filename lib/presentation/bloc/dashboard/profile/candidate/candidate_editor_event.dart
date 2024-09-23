import 'package:flutter/material.dart';

import '../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import '../../../../../data/models/onboarding/file_model.dart';

abstract class CandidateEditorEvent {
   const CandidateEditorEvent();
}

class CandidateEditorStartEvent extends CandidateEditorEvent {
   const CandidateEditorStartEvent();
}

class UpdateCandidateEvent extends CandidateEditorEvent {
   const UpdateCandidateEvent({required this.candidate});
   final CandidateOnBoarding candidate;
}


class ChangeProfilePictureEvent extends CandidateEditorEvent {
   const ChangeProfilePictureEvent();

}







