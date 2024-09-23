

import 'package:flutter/cupertino.dart';
import 'package:highlite_flutter_mvp/core/constants/injection_constant.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/services/injection_container.dart';

final candidateProfileService  = sl.get<CandidateProfileRepository>(instanceName: InjectionConstant.candidateProfileRepository);

abstract class CandidateProfileRepository{

  late  Map<String, VideoPlayerController> selfVideoPlayerController ;
  late  Map<String, ImageProvider> selfVideoPlayerThumbnail ;

  late List<CandidateVideoFeed> candidateVideoFeed ;

  Future<CandidateOnBoarding> getCandidateOnBoarding(String id) ;

  Future<CandidateOnBoarding> updateCandidateProfile(CandidateOnBoarding  request , String id);

  Future<List<CandidateVideoFeed>> getCandidateVideoFeed(String candidateId) ;

  Future<void> ping(String id) ;

}
