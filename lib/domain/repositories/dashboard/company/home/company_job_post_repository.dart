import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../../data/models/apis/dashboard/cadidate/profile/id_request.dart';
import '../../../../../data/models/apis/dashboard/cadidate/profile/id_response.dart';
import '../../../../../data/models/apis/dashboard/company/home/company_job_feed_item_response.dart';

final companyJobPostService = sl.get<CompanyJobPostRepository>();

abstract class CompanyJobPostRepository {

  Future<IDResponse> createCompanyJobPosting(CompanyJobPost request);
  Future<CompanyJobPost> updateCompanyJobPosting(
      CompanyJobPost request);
  Future<CompanyJobPost> deleteCompanyJobPosting(String request);
  Future<CompanyJobPost> getCompanyJobPosting(IDRequest request);
  // Future<CompanyJobPostItemsResponse> listCompanyJobPosting(
  //     IDRequest request);
  Future<CompanyJobFeedItemsResponse> listCompanyJobPostingFeeds(
      IDRequest request);
}

