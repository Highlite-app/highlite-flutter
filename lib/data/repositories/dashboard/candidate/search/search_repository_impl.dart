import 'package:highlite_flutter_mvp/core/platform/network_info.dart';
import 'package:highlite_flutter_mvp/data/datasources/local_datasource.dart';
import 'package:highlite_flutter_mvp/data/datasources/remote_datasources.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';

import '../../../../../domain/repositories/dashboard/candidate/search/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository{
  LocalDataSource localDataSource ;
  RemoteDataSources remoteDataSources ;
  NetworkInfo networkInfo ;

  SearchRepositoryImpl(
      {required this.remoteDataSources ,
    required this.localDataSource,


    required this.networkInfo }) ;
  @override
  Future<List<CompanyOnboarding>> getOnboardingCandidateFromLocalDatabase() {
    final response  = localDataSource.getCompanyOnboardingFromJSON() ;
    return response ;
  }

  @override
  Future<List<CompanyJobPost>> getCompanyJobPostFromLocalDatabase() {
    final response  = localDataSource.getCompanyJobPostFromJSON() ;
    return response ;
  }

  @override
  Future<List<String>> getJobTitleListFromLocalDatabase() {
   final response = localDataSource.getJobTitleListFromJSON();
   return response ;
  }

  @override
  Future<List<String>> getLocationListFromLocalDatabase() {
    final response = localDataSource.getLocationListFromJSON();
    return response ;
  }

  @override
  Future<List<String>> getSkillsListFromLocalDatabase() {
    final response = localDataSource.getSkillsListFromJSON();
    return response ;
  }

  @override
  Future<List<String>> getToolsListFromLocalDatabase() {
    final response = localDataSource.getToolsListFromJSON();
    return response ;
  }

  @override
  Future<List<String>> getSalaryFromLocalDatabase() {
    final response = localDataSource.getSalaryListFromJSON();
    return response ;
  }

}