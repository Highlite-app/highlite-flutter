import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';

import '../../../../../domain/repositories/auth/auth_repository.dart';
import '../../../../../domain/repositories/onboarding/onboarding_repositoy.dart';
import '../../../../../domain/repositories/persistent/persistent_repository.dart';
import '../../../../../presentation/bloc/dashboard/auth/authentication_bloc.dart';
import '../../../../../presentation/bloc/dashboard/auth/authentication_event.dart';
import '../../../apis/authentication/persisted_user.dart';

import '../onboarding_chat_models.dart';

class CompanySignupFlow extends APIFlow {
  final CompanyOnboarding companyOnboarding;
  CompanySignupFlow({
    required this.companyOnboarding,
  });

  @override
  Future<bool> execute() async {

    final signInResponse = await onboardingService.signUpCompanyUser(companyOnboarding);
    final data = signInResponse.data;
    await persistenceService.persist(
      loggedIn: data.isLoggedIn ?? false,
      tokenId: data.tokenId ?? "",
      accessToken: data.accessToken ?? "",
      refreshToken: data.refreshToken ?? "",
      id: data.id ?? "",
      userType: data.userType ?? "",
      companyId: signInResponse.data.id,
    );

    authService.persistedUser = PersistedUser(
      isLoggedIn: data.isLoggedIn ?? false,
      tokenId: data.tokenId ?? "",
      accessToken: data.accessToken ?? "",
      refreshToken: data.refreshToken ?? "",
      id: data.id ?? "",
      userType: data.userType ?? "",
    );
    if (data.id != null && data.userType != null) {
      // ignore: use_build_context_synchronously
       authentication.add(AuthenticateOnboardingEvent(
        data.id!,
        data.userType!,
      ));
    }

    return Future.value(false);
  }
}
