import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/profile/id_request.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/profile/id_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post_video_feed.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post_video_feed.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/repositories/dashboard/company/home/company_job_post_video_feed_repository.dart';

@Injectable(as: CompanyJobPostVideoFeedRepository)
class CompanyJobPostVideoFeedRepositoryImpl extends CompanyJobPostVideoFeedRepository{
  @override
  Future<IDResponse> createCompanyJobPostVideoFeed(CompanyJobPostVideoFeed request) {
    // TODO: implement createCompanyJobPostVideoFeed
    throw UnimplementedError();
  }

  @override
  Future<CompanyJobPostVideoFeed?> deleteHighliteVideoFeedCompanyJobPost(String request) {
    // TODO: implement deleteHighliteVideoFeedCompanyJobPost
    throw UnimplementedError();
  }

  @override
  Future<CompanyJobPostVideoFeed> updateCompanyJobPostVideoFeed(CompanyJobPostVideoFeed request) {
    // TODO: implement updateCompanyJobPostVideoFeed
    throw UnimplementedError();
  }

  
  
}