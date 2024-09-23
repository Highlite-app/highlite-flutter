import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:highlite_flutter_mvp/core/constants/injection_constant.dart';
import 'package:highlite_flutter_mvp/core/routes/route_constants.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/logger.dart';
import '../../../../app.dart';
import '../../../../core/constants/user_types.dart';
import '../../../../core/services/injection_container.dart';
import '../../../../data/repositories/auth/auth_repository_impl.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

final authentication = sl.get<AuthenticationBloc>(instanceName: InjectionConstant.authenticationBloc) ;


class AuthenticationBloc  extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      ) : super(AuthenticationState()) {

    on<AuthenticateOnStartEvent>(_handleAuthenticateOnStart);
    on<AuthenticateOnboardingEvent>(_handleAuthenticateOnboarding);
    on<AttachAuthenticationEvent>(_handleAttach);
    on<AuthenticateCompanyEvent>(_handleAuthenticateCompany);
    on<AuthenticateCandidateEvent>(_handleAuthenticateCandidate);
    on<LogoutEvent>((event, emit) async {
        await authService.logout();
      },
    );
  }

  Future<void> _handleAuthenticateOnboarding(
    AuthenticateOnboardingEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(
      state.copyWith(
        id: event.id,
        userType: event.userType,
      ),
    );
    await authService.mapFromOnboarding(event.id, event.userType);
    emit(
      state.copyWith(
        isAuthenticated: true,
      ),
    );
    if (event.userType == UserTypes.company) {
      add(const AuthenticateCompanyEvent());
    } else {
      add(const AuthenticateCandidateEvent());
    }
   // profileSetter.add(const ExecuteProfileUpdateEvent());
  }

  Future<void> _handleAuthenticateOnStart(
    AuthenticateOnStartEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
   // await homeFeedState.reset();
    await authService.autoLogin();
    emit(state.copyWith(isAuthenticated: authService.persistedUser != null));
    add(const AttachAuthenticationEvent());

  }

  Future<void> _handleAttach(
    AttachAuthenticationEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (state.isAuthenticated) {
      emit(
        state.copyWith(
          id: authService.persistedUser!.id,
          userType: authService.persistedUser!.userType,
        ),
      );
      if (authService.persistedUser!.userType == UserTypes.company) {
        logger.logEvent("*******Inside Company Section ********" , tag: "COMPANY");
        add(const AuthenticateCompanyEvent());
        Get.toNamed(RouteConstants.companyDashboard) ;
      } else {
        add(const AuthenticateCandidateEvent());
        logger.logEvent("*******Inside Candidate Section ********" , tag:"CANDIDATE");
        Get.toNamed(RouteConstants.candidateDashboard);
      }
    } else {
      Get.toNamed(RouteConstants.onBoardingSplash);

    }
  }

  Future<void> _handleAuthenticateCompany(
    AuthenticateCompanyEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(
      state.copyWith(
        companyProfile: authService.companyOnboarding,
        companyJobPosts: authService.companyJobPosts,
        companyJobPostVideoFeed: authService.companyJobPostVideoFeed,
      ),
    );
  }

  Future<void> _handleAuthenticateCandidate(
    AuthenticateCandidateEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    debugPrint("The candidate inside AuthenticationBloc _handleAuthenticateCandidate ::: ${state.candidate?.firstName ?? "empty"} ");
    emit(state.copyWith(candidate: authService.candidateOnBoarding ,
        candidateVideoFeed: authService.candidateVideoFeed));
    debugPrint("The candidate inside AuthenticationBloc _handleAuthenticateCandidate ::: ${state.candidate?.firstName ?? ""} ");
   // emit(state.copyWith(candidateVideoFeed: authService.))
    // / candidateVideoFeed: authService.candidateVideoFeed,
  }
}
