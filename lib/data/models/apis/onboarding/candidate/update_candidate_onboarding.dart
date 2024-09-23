
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';

class UpdateCandidate {
  String? message;
  CandidateOnBoarding? candidate;

  UpdateCandidate({this.message, this.candidate});

  UpdateCandidate.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    candidate = json['candidate'] != null
        ? CandidateOnBoarding.fromJson(json['candidate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    final candidate = this.candidate;
    if (candidate != null) {
      data['candidate'] = candidate.toJson();
    }
    return data;
  }
}

