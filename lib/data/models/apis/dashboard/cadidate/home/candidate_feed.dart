import 'package:highlite_flutter_mvp/presentation/pages/navigation/home/candidate/candidate_home_feed.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';

import '../../../onboarding/candidate/candidate_onboarding.dart';
import '../upload/about /about_candidate.dart';
import '../upload/education/candidate_education.dart';
import '../upload/employment/candidate_employment.dart';
import '../upload/project/candidate_project.dart';

class CandidateFeed {
  String candidateVideoFeedId;
  String candidateId;
  String description;
  String thumbnailUrl;
  String thumbnailWidth;
  String thumbnailHeight;
  String playbackId;
  String assetId;
  String uploadId;
  List<String> tag;
  List<String> category;
  CandidateOnBoarding? candidateOnBoarding;
  AboutCandidate? aboutCandidate;
  List<CandidateEmployment>? candidateEmployment;
  List<CandidateEducation>? candidateEducation;
  List<CandidateProject>? candidateProject;

  CandidateFeed({
    required this.candidateVideoFeedId,
    required this.candidateId,
    required this.description,
    required this.thumbnailUrl,
    required this.thumbnailWidth,
    required this.thumbnailHeight,
    required this.playbackId,
    required this.assetId,
    required this.uploadId,
    required this.tag,
    required this.category,
    required this.candidateOnBoarding,
    required this.aboutCandidate,
    required this.candidateEmployment,
    required this.candidateEducation,
    required this.candidateProject,
  });

  factory CandidateFeed.fromJson(Map<String, dynamic> json) {
    return CandidateFeed(
      candidateVideoFeedId: json['candidateVideoFeedId'],
      candidateId: json['candidateId'],
      description: json['description'],
      thumbnailUrl: json['thumbnailUrl'],
      thumbnailWidth: json['thumbnailWidth'],
      thumbnailHeight: json['thumbnailHeight'],
      playbackId: json['playbackId'],
      assetId: json['assetId'],
      uploadId: json['uploadId'],
      tag:  json['tag'] != null ? List<String>.from(json['tag']) : [],
      category: json['category'] != null ? List<String>.from(json['category']) : [],
      candidateOnBoarding:   json['candidateOnBoarding'] !=null ? CandidateOnBoarding.fromJson(json['candidateOnBoarding']): null,
      aboutCandidate:  json['aboutCandidate'] != null ? AboutCandidate.fromJson(json['aboutCandidate']) :null,
      candidateEmployment: (json['candidateEmployment'] as List).isNullOrEmpty ? [] : (json['candidateEmployment'] as List).map((e)=> CandidateEmployment.fromJson(e)).toList(),
      candidateEducation: (json['candidateEducation'] as List).isNullOrEmpty ? [] : (json['candidateEducation'] as List).map((e)=> CandidateEducation.fromJson(e)).toList(),
      candidateProject: (json['candidateProject'] as List).isNullOrEmpty ? [] : (json['candidateProject'] as List).map((e) => CandidateProject.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidateVideoFeedId': candidateVideoFeedId,
      'candidateId': candidateId,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'thumbnailWidth': thumbnailWidth,
      'thumbnailHeight': thumbnailHeight,
      'playbackId': playbackId,
      'assetId': assetId,
      'uploadId': uploadId,
      'tag': tag,
      'category': category,
      'candidateOnBoarding': candidateOnBoarding?.toJson(),
      'aboutCandidate': aboutCandidate?.toJson(),
      'candidateEmployment': candidateEmployment?.map((e)=> e.toJson()).toList(),
      'candidateEducation': candidateEducation?.map((e) => e.toJson()).toList(),
      'candidateProject': candidateProject?.map((e) => e.toJson()).toList(),
    };
  }
}