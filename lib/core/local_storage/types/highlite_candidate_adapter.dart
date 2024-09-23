import 'dart:convert';

import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:hive/hive.dart';

class CandidateOnBoardingAdapter extends TypeAdapter<CandidateOnBoarding> {
  @override
  int get typeId => 0;

  @override
  CandidateOnBoarding read(BinaryReader reader) {
    final candidate = reader.readString();
    final Map<String, dynamic> candidateJson = jsonDecode(candidate);
    return CandidateOnBoarding.fromJson(candidateJson);
  }

  @override
  void write(BinaryWriter writer, CandidateOnBoarding obj) {
    final jsonString = jsonEncode(obj.toJson());
    writer.writeString(jsonString);
  }
}
