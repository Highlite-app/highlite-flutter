import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';

import '../../../../../core/services/injection_container.dart';


 final companyProfileService = sl.get<CompanyProfileRepository>() ;

abstract class  CompanyProfileRepository {

  Future<CompanyOnboarding> getCompanyOnboarding(String companyId) ;
  Future<CompanyOnboarding> updateCompanyOnboarding(CompanyOnboarding request , String companyId) ;


}