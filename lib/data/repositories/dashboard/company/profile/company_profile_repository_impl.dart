import 'package:highlite_flutter_mvp/core/platform/network_info.dart';
import 'package:highlite_flutter_mvp/data/datasources/local_datasource.dart';
import 'package:highlite_flutter_mvp/data/datasources/remote_datasources.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:injectable/injectable.dart';
import '../../../../../domain/repositories/dashboard/company/profile/company_profile_repository.dart';

@Injectable(as: CompanyProfileRepository)
class CompanyProfileRepositoryImpl implements CompanyProfileRepository {
  final RemoteDataSources remoteDataSources;

  final LocalDataSource localDataSource;

  final NetworkInfo networkInfo;

  CompanyProfileRepositoryImpl({
    required this.remoteDataSources,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<CompanyOnboarding> getCompanyOnboarding(String companyId) async {
    if (await networkInfo.isConnected()) {
      final companyOnboarding =
          await remoteDataSources.getCompanyOnboarding(companyId);
      //await hiveStorage.setCompanyToStorage(companyOnboarding);
      return companyOnboarding;
    } else {
      throw Exception("Internet is Not Connected");
    }
  }

  @override
  Future<CompanyOnboarding> updateCompanyOnboarding(
      CompanyOnboarding request, String companyId) async {
    if (await networkInfo.isConnected()) {
      final companyOnboarding =
          await remoteDataSources.updateCompanyOnboarding(companyId, request);
      //await hiveStorage.setCompanyToStorage(companyOnboarding);
      return companyOnboarding;
    } else {
      throw Exception("Internet is Not Connected");
    }
  }
}
