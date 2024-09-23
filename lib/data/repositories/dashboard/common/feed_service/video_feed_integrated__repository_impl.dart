
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/common/feed_service/video_feed_integrated_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import '../../../../models/apis/dashboard/company/upload/company_job_post_video_feed.dart';

@Injectable(as: VideoFeedIntegratedRepository)
class VideoFeedIntegratedRepositoryImpl extends VideoFeedIntegratedRepository{
  @override
  Future<CompanyJobPostVideoFeed> createEditVideoFeedForCompanyJobPost(String fileNameToUpload, CompanyJobPostVideoFeed? existingJobVideoFeed) {
    // TODO: implement createEditVideoFeedForCompanyJobPost
    throw UnimplementedError();
  }

  @override
  Future<CandidateVideoFeed> createVideoFeedForCandidate(String fileNameToUpload, CandidateVideoFeed? existingVideoFeed) {
    // TODO: implement createVideoFeedForCandidate
    throw UnimplementedError();
  }

  @override
  Future<CompanyJobPostVideoFeed> createVideoFeedForCompanyJobPost(String fileNameToUpload, String? existingJobVideoFeedId) {
    // TODO: implement createVideoFeedForCompanyJobPost
    throw UnimplementedError();
  }

  @override
  Future<CompanyJobPostVideoFeed> updateLastVideoFeedForCompanyJobPost(CompanyJobPostVideoFeed? existingVideoFeed) {
    // TODO: implement updateLastVideoFeedForCompanyJobPost
    throw UnimplementedError();
  }

}