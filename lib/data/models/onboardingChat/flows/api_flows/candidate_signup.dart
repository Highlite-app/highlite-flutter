import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/constants/injection_constant.dart';
import 'package:highlite_flutter_mvp/core/services/injection_container.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/persistent/persistent_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/onboarding/onboarding_repositoy.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_bloc.dart';
import '../../../../../presentation/bloc/dashboard/auth/authentication_event.dart';
import '../../../apis/authentication/persisted_user.dart';
import '../onboarding_chat_models.dart';

class CandidateSignupFlow extends APIFlow {
  final CandidateOnBoarding candidate;

  CandidateSignupFlow({required this.candidate});

  @override
  Future<bool> execute() async {
    final signInResponse = await onboardingService.signUpCandidate(candidate);
    // profileSetter.add(
    //     AddProfileSettingEvent(candidateProfileId: signInResponse.data.id));
    // final updatedCandidate = candidate.copyWith(id: signInResponse.data.id);
    // await candidateProfileService.updateCandidateProfile(updatedCandidate);
    final data = signInResponse.data;

    await persistenceService.persist(
      loggedIn: data.isLoggedIn ?? false,
      tokenId: data.tokenId ?? "",
      accessToken: data.accessToken ?? "",
      refreshToken: data.refreshToken ?? "",
      id: data.id.toString(),
      userType: data.userType ?? "",
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

      authentication.add(
        AuthenticateOnboardingEvent(
          data.id ?? "",
          data.userType?? "",
        ),
      );
    }
    return signInResponse.status;
  }
}
