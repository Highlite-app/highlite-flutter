import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/platform/network_info.dart';
import 'package:highlite_flutter_mvp/data/datasources/local_datasource.dart';
import 'package:highlite_flutter_mvp/data/datasources/remote_datasources.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/profile/id_request.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/profile/next_token_request.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/home/job_post_video_feed_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../../presentation/widgets/utils/logger.dart';
import '../../../../models/apis/dashboard/company/home/company_job_feed.dart';
import '../../../../models/apis/dashboard/company/home/company_job_feed_item_response.dart';



final jobPostingFeedService = sl.get<JobPostVideoFeedRepository>();

@Injectable(as: JobPostVideoFeedRepository)
class JobPostVideoFeedRepositoryImpl extends JobPostVideoFeedRepository{
  final LocalDataSource localDataSource ;
  final RemoteDataSources remoteDataSources ;
  final NetworkInfo networkInfo ;
  final bool isRemoteAvailable ;

  JobPostVideoFeedRepositoryImpl({
    required this.localDataSource ,
    required this.remoteDataSources ,
    required this.networkInfo,
    this.isRemoteAvailable  = false ,
});
  @override
  Future<CompanyJobFeedItemsResponse> fetch(NextTokenRequest request) async {
   if(await networkInfo.isConnected() ){
     try{
       final response  = remoteDataSources.fetch(request);
       debugPrint("The Home Feed response is ::: $response");
       return response ;
     }catch(e){
       throw Exception('Local Datasource not found ::$e');
     }
   }else {
     logger.logEvent('Remote Data Source not avaialble');
     throw Exception();
   }
  }

  @override
  Future<CompanyJobFeedItemsResponse> fetchAllByCompany(NextTokenRequest request, String companyId) {
    // TODO: implement fetchAllByCompany
    throw UnimplementedError();
  }

  @override
  Future<List<CompanyJobFeed>> fetchAllPaginatedByCompany(String companyId) {
    // TODO: implement fetchAllPaginatedByCompany
    throw UnimplementedError();
  }

  @override
  Future<CompanyJobFeed> getById(IDRequest request) {
    // TODO: implement getById
    throw UnimplementedError();
  }
  
  
}