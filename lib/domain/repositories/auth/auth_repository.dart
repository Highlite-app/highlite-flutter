import 'package:highlite_flutter_mvp/core/constants/injection_constant.dart';
import 'package:highlite_flutter_mvp/data/models/apis/authentication/persisted_user.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post_video_feed.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import '../../../core/services/injection_container.dart';
import '../../../data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import '../../../data/models/apis/dashboard/company/upload/company_job_post.dart';
import '../../../data/models/apis/dashboard/push_notification/push_notification_payload.dart';
import '../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';

final authService  = sl.get<AuthRepository>(instanceName: InjectionConstant.authRepository);

abstract class AuthRepository{

   PersistedUser? persistedUser;
   CandidateOnBoarding? candidateOnBoarding;
   CompanyOnboarding? companyOnboarding;
   late List<CandidateVideoFeed> candidateVideoFeed ;
   late List<CompanyJobPost>? companyJobPosts;
   List<CompanyJobPostVideoFeed>? companyJobPostVideoFeed;
   late bool initialized;
  Future<bool> autoLogin();
  Future<void> logout();
  Future<void> mapFromOnboarding(String id, String userType);
  String getUserID();
  String getName();
  String getEmailAddress();
 // StreamSubscription<GraphQLResponse<dynamic>> onPing(Function() callback);
  Future<void> pushNotificationEvent(PushNotificationPayload payload);

}



