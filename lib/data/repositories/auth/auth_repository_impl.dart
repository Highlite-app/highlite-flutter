import 'package:flutter/cupertino.dart';
import 'package:highlite_flutter_mvp/core/constants/user_types.dart';
import 'package:highlite_flutter_mvp/core/local_storage/highlite_candidate_storage_service.dart';
import 'package:highlite_flutter_mvp/data/models/apis/authentication/persisted_user.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post_video_feed.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/push_notification/push_notification_payload.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:highlite_flutter_mvp/data/repositories/persistent/persistent_repository_impl.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/profile/candidate_profile_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/common/feed_service/home_feed_state_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/company/profile/company_profile_repository.dart';
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../../domain/repositories/persistent/persistent_repository.dart';
import '../../../presentation/widgets/utils/logger.dart';
import '../../models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import '../../models/apis/onboarding/candidate/candidate_onboarding.dart';

class AuthRepositoryImpl implements AuthRepository {

  @override
  List<CandidateVideoFeed> candidateVideoFeed = [] ;
  @override
  bool initialized = false;
  @override
  CandidateOnBoarding? candidateOnBoarding;

  @override
  List<CompanyJobPostVideoFeed>? companyJobPostVideoFeed;

  @override
  List<CompanyJobPost>? companyJobPosts;

  @override
  CompanyOnboarding? companyOnboarding;
  @override
  PersistedUser? persistedUser;

  @override
  Future<bool> autoLogin() async {
    final persisted = await persistenceService.get();
    persistedUser = persisted;
    if (persisted != null) {
      // gqlService.authenticate(persisted.accessToken, persisted.id);
      await _setByPersistence(persisted);
      return persisted.isLoggedIn;
    } else {
      return false;
    }
  }

  Future<void> _setByPersistence(PersistedUser persistedUser) async {
    return _setByIdAndUserType(persistedUser.id, persistedUser.userType);
  }

  Future<void> _setByIdAndUserType(String id, String userType) async {
    if (userType == UserTypes.company) {
      debugPrint("The user type is in AuthRepositoryImpl  $userType");
      final companyDetails  = await companyProfileService.getCompanyOnboarding(id) ;
      companyOnboarding =  companyDetails ;

      //TODO : REQUIRED WHILE WORKING ON COMPANY PROFILE
    } else {
      debugPrint("The user type is in AuthRepositoryImpl  $userType");
     final candidateOnboarding = await candidateProfileService.getCandidateOnBoarding(id);
     candidateOnBoarding = candidateOnboarding;
     await hiveStorage.setCandidateToStorage(candidateOnboarding);
     List<CandidateVideoFeed> videoFeed = await candidateProfileService.getCandidateVideoFeed(id) ;
     candidateVideoFeed.addAll(videoFeed) ;

      print("Called before fetch");
     await homeFeedState.getCurrentUserBookmarkList(getUserID()) ;
     await homeFeedState.fetch();
      print("Called after fetch");
      print("Also Called");
      logger.logEvent(persistedUser?.toJson().toString() ?? "Empty JSON");
      initialized = true ;


    }
  }

  @override
  String getEmailAddress() {
    if (authService.persistedUser?.userType == UserTypes.candidate) {
      return candidateOnBoarding?.email ?? "";
    } else {
      return companyOnboarding?.email ?? "";
    }
  }

  @override
  String getName() {
    if (authService.persistedUser?.userType == UserTypes.candidate) {
      return candidateOnBoarding?.fullName ?? "";
    } else {
      return companyOnboarding?.companyName ?? "";
    }
  }

  @override
  String getUserID() {
    if (authService.persistedUser?.userType == UserTypes.candidate) {
      return candidateOnBoarding?.candidateId ?? "";
    } else {
      return companyOnboarding?.companyId ?? "";
    }
  }

  @override
  Future<void> logout() async {
    PersistentRepositoryImpl persistentRepository = PersistentRepositoryImpl();
    await persistentRepository.clear();
  }

  @override
  Future<void> mapFromOnboarding(String id, String userType) {
    return _setByIdAndUserType(id, userType);
  }

  @override
  Future<void> pushNotificationEvent(PushNotificationPayload payload) {
    // TODO: implement pushNotificationEvent
    throw UnimplementedError();
  }








}

