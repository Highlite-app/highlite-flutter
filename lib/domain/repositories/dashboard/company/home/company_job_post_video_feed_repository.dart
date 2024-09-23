import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post_video_feed.dart';

import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post_video_feed.dart';

import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post_video_feed.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../../data/models/apis/dashboard/cadidate/profile/id_request.dart';
import '../../../../../data/models/apis/dashboard/cadidate/profile/id_response.dart';


final companyJobPostVideoFeedService = sl.get<CompanyJobPostVideoFeedRepository>();

abstract class CompanyJobPostVideoFeedRepository {
  Future<IDResponse> createCompanyJobPostVideoFeed(
      CompanyJobPostVideoFeed request);
  Future<CompanyJobPostVideoFeed> updateCompanyJobPostVideoFeed(
      CompanyJobPostVideoFeed request);

  //TODO : WILL THINK WHEN REQUIRE
  // Future<HighliteCompanyJobPostVideoFeedItemsResponse>
  // getHighliteCompanyJobPostVideoFeed(IDRequest request);
  Future<CompanyJobPostVideoFeed?> deleteHighliteVideoFeedCompanyJobPost(String request);
  // Future<HighliteCompanyJobPostVideoFeedItemsResponse> listHighliteVideoFeedCompanyJobPosts(
  //     IDRequest request,
  //     );
}