import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post_video_feed.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../../data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';

final videoFeedIntegratedService = sl.get<VideoFeedIntegratedRepository>();

abstract class VideoFeedIntegratedRepository {
  Future<CandidateVideoFeed> createVideoFeedForCandidate(
      String fileNameToUpload, CandidateVideoFeed? existingVideoFeed);

  Future<CompanyJobPostVideoFeed> createVideoFeedForCompanyJobPost(
      String fileNameToUpload, String? existingJobVideoFeedId);

  Future<CompanyJobPostVideoFeed> updateLastVideoFeedForCompanyJobPost(
      CompanyJobPostVideoFeed? existingVideoFeed);

  Future<CompanyJobPostVideoFeed> createEditVideoFeedForCompanyJobPost(
      String fileNameToUpload, CompanyJobPostVideoFeed? existingJobVideoFeed);
}
