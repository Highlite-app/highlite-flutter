import '../../../../../data/models/apis/dashboard/cadidate/profile/id_request.dart';
import '../../../../../data/models/apis/dashboard/cadidate/profile/next_token_request.dart';
import '../../../../../data/models/apis/dashboard/company/home/company_job_feed.dart';
import '../../../../../data/models/apis/dashboard/company/home/company_job_feed_item_response.dart';

abstract class JobPostVideoFeedRepository {
  Future<CompanyJobFeed> getById(IDRequest request);

  Future<CompanyJobFeedItemsResponse> fetch(NextTokenRequest request);

  Future<CompanyJobFeedItemsResponse> fetchAllByCompany(
      NextTokenRequest request, String companyId);

  Future<List<CompanyJobFeed>> fetchAllPaginatedByCompany(String companyId);
}
