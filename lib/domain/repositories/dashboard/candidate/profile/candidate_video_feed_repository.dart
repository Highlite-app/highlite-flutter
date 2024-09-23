import 'package:highlite_flutter_mvp/core/constants/injection_constant.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/profile/id_response.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../../data/models/apis/dashboard/cadidate/profile/id_request.dart';
import '../../../../../data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';

final candidateVideoFeedService = sl.get<CandidateVideoFeedRepository>(instanceName: InjectionConstant.candidateVideoFeedRepository);
abstract class CandidateVideoFeedRepository {
  Future<IDResponse> createCandidateVideoFeed(
      CandidateVideoFeed request);
  Future<CandidateVideoFeed> updateCandidateVideoFeed(
      CandidateVideoFeed? request);
  Future<CandidateVideoFeed> getCandidateOnBoardingVideoFeed(
      IDRequest request);
}