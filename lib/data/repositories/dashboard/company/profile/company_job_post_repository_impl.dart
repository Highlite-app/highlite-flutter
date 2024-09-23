import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/profile/id_request.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/profile/id_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/company/home/company_job_post_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../models/apis/dashboard/company/home/company_job_feed_item_response.dart';


@Injectable(as: CompanyJobPostRepository)
class CompanyJobPostRepositoryImpl extends CompanyJobPostRepository{
  @override
  Future<IDResponse> createCompanyJobPosting(CompanyJobPost request) {
    // TODO: implement createCompanyJobPosting
    throw UnimplementedError();
  }

  @override
  Future<CompanyJobPost> deleteCompanyJobPosting(String request) {
    // TODO: implement deleteCompanyJobPosting
    throw UnimplementedError();
  }

  @override
  Future<CompanyJobPost> getCompanyJobPosting(IDRequest request) {
    // TODO: implement getCompanyJobPosting
    throw UnimplementedError();
  }

  @override
  Future<CompanyJobFeedItemsResponse> listCompanyJobPostingFeeds(IDRequest request) {
    // TODO: implement listCompanyJobPostingFeeds
    throw UnimplementedError();
  }

  @override
  Future<CompanyJobPost> updateCompanyJobPosting(CompanyJobPost request) {
    // TODO: implement updateCompanyJobPosting
    throw UnimplementedError();
  }
  
}



