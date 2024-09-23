import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';
import '../../../../../data/models/apis/dashboard/cadidate/home/candidate_feed.dart';
import '../../../../../data/models/apis/dashboard/cadidate/upload/education/candidate_education.dart';
import '../../../../../data/models/apis/dashboard/cadidate/upload/employment/candidate_employment.dart';
import '../../../../../data/models/apis/dashboard/cadidate/upload/project/candidate_project.dart';
import '../../../../../data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import '../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import '../../../../../data/models/onboarding/file_model.dart';

class CandidateEditorState {
  final CandidateOnBoarding candidateOnBoarding;
  final List<CandidateEducation>? candidateEducation;
  final List<CandidateEmployment>? candidateEmployment;
  final List<CandidateProject>? candidateProject;
  final List<CandidateVideoFeed> candidateVideFeed;
  final PageController? profilePageController;

  final CandidateFeed? candidateFeed;
  final Map<String, VideoPlayerController> selfVideoPlayerController;

  final Map<String, ImageProvider> selfThumbnail;

  final bool isUploading;

  CandidateEditorState({
    required this.candidateOnBoarding,
    this.candidateEducation,
    this.candidateEmployment,
    this.candidateProject,
    this.candidateFeed,
    required this.candidateVideFeed,
    this.isUploading = false,
    this.profilePageController,
    this.selfVideoPlayerController = const {},
    this.selfThumbnail = const {},
  });

  CandidateEditorState copyWith(
      {CandidateOnBoarding? candidateOnBoarding,
      List<CandidateEducation>? candidateEducation,
      List<CandidateEmployment>? candidateEmployment,
      List<CandidateProject>? candidateProject,
      List<CandidateVideoFeed>? candidateVideFeed,
      CandidateFeed? candidateFeed,
      String? videoUrl,
      FileModel? videoFile,
      PageController? profilePageController,
      VideoPlayerController? videoForUrl,
      VideoPlayerController? videoForFile,
      String? fileNameToUpload,
      bool? isUploading,
      Map<String, VideoPlayerController>? selfVideoPlayerController,
      Map<String, ImageProvider>? selfThumbnail}) {
    return CandidateEditorState(
        candidateOnBoarding: candidateOnBoarding ?? this.candidateOnBoarding,
        candidateEducation: candidateEducation ?? this.candidateEducation,
        candidateEmployment: candidateEmployment ?? this.candidateEmployment,
        candidateProject: candidateProject ?? this.candidateProject,
        profilePageController:
            profilePageController ?? this.profilePageController,
        candidateVideFeed: candidateVideFeed ?? this.candidateVideFeed,
        candidateFeed: candidateFeed ?? this.candidateFeed,
        isUploading: isUploading ?? this.isUploading,
        selfVideoPlayerController:
            selfVideoPlayerController ?? this.selfVideoPlayerController,
        selfThumbnail: selfThumbnail ?? this.selfThumbnail);
  }
}
