

import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/profile/id_request.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/profile/id_response.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/profile/candidate_video_feed_repository.dart';

import '../../../../models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';

class CandidateVideoFeedRepositoryImpl extends CandidateVideoFeedRepository{
  @override
  Future<IDResponse> createCandidateVideoFeed(CandidateVideoFeed request) {
    // TODO: implement createCandidateVideoFeed
    throw UnimplementedError();
  }

  @override
  Future<CandidateVideoFeed> getCandidateOnBoardingVideoFeed(IDRequest request) {
    // TODO: implement getCandidateOnBoardingVideoFeed
    throw UnimplementedError();
  }

  @override
  Future<CandidateVideoFeed> updateCandidateVideoFeed(CandidateVideoFeed? request) {
    // TODO: implement updateCandidateVideoFeed
    throw UnimplementedError();
  }


}