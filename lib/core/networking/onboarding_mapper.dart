import 'package:highlite_flutter_mvp/data/models/apis/authentication/signup_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/home/candidate_feed_item_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import 'package:highlite_flutter_mvp/data/models/apis/default/api_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/login/verify_email_otp_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/bookmark/response/bookmark_collection_item_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/update_candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';

import '../../data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed_response.dart';
import '../../data/models/apis/dashboard/company/home/company_job_feed_item_response.dart';
import '../../data/models/apis/login/email_otp.dart';
import '../../data/models/apis/login/signin_api.dart';
import 'mapper.dart';

void registerOnBoardingConstructors() {
  MapperFactory.registerConstructor<CompanyJobFeedItemsResponse>((map) => CompanyJobFeedItemsResponse.fromJson(map));

  MapperFactory.registerConstructor<CandidateFeedItemResponse>(
      (map) => CandidateFeedItemResponse.fromJson(map));
  MapperFactory.registerConstructor<CompanyOnboarding>(
      (map) => CompanyOnboarding.fromJson(map));

  MapperFactory.registerConstructor<CandidateVideoFeedResponse>(
      (map) => CandidateVideoFeedResponse.fromJson(map));
  MapperFactory.registerConstructor<CandidateOnBoarding>(
      (map) => CandidateOnBoarding.fromJson(map));

  MapperFactory.registerConstructor<EmailOtpResponse>((map)=> EmailOtpResponse.fromJson(map));

  MapperFactory.registerConstructor<SigninResponse>(
      (map) => SigninResponse.fromJson(map));

  MapperFactory.registerConstructor<SignUpResponse>((map) {
    return SignUpResponse.fromJson(map);
  });
  MapperFactory.registerConstructor<List<CandidateVideoFeed>>((map) {
    return CandidateVideoFeed.listFromJson(map as List<dynamic>);
  });

  MapperFactory.registerConstructor<UpdateCandidate>((map)=> UpdateCandidate.fromJson(map)) ;

  MapperFactory.registerConstructor<VerifyEmailOtpResponse>((map)=>VerifyEmailOtpResponse.fromJson(map) );

  MapperFactory.registerConstructor<CandidateFeedItemResponse>(
      (map) => CandidateFeedItemResponse.fromJson(map));

  MapperFactory.registerConstructor<ApiResponse>((map)=> ApiResponse.fromJson(map)) ;

  //
  MapperFactory.registerConstructor<BookmarkCollectionItemResponse>((map)=> BookmarkCollectionItemResponse.fromJson(map)) ;

  // List of registers
}
