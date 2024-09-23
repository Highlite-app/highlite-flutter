import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';

import '../../../../../core/services/injection_container.dart';

final searchService = sl.get<SearchRepository>() ;

abstract class SearchRepository{

  Future<List<CompanyOnboarding>> getOnboardingCandidateFromLocalDatabase() ;
  Future<List<CompanyJobPost>> getCompanyJobPostFromLocalDatabase() ;
  Future<List<String>>  getSkillsListFromLocalDatabase() ;
  Future<List<String>>  getToolsListFromLocalDatabase() ;
  Future<List<String>>  getLocationListFromLocalDatabase() ;
  Future<List<String>>  getJobTitleListFromLocalDatabase() ;
  Future<List<String>>  getSalaryFromLocalDatabase() ;


}