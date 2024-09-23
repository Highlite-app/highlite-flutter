import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post_video_feed.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';

import '../../../../data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';


class AuthenticationState {
  AuthenticationState({
    this.isAuthenticated = false,
    this.isProcessing = true,
    this.id = "",
    this.userType = "",
    this.candidate,
    this.candidateVideoFeed,
    this.companyProfile,
    this.companyJobPosts,
    this.companyJobPostVideoFeed,
  });

  final bool isAuthenticated;
  final bool isProcessing;
  final String id;
  final String userType;
  final CandidateOnBoarding? candidate;
  final List<CandidateVideoFeed>? candidateVideoFeed;
  final CompanyOnboarding? companyProfile;
  final List<CompanyJobPost>? companyJobPosts;
  final List<CompanyJobPostVideoFeed>? companyJobPostVideoFeed;

  AuthenticationState copyWith({
    bool? isAuthenticated,
    bool? isProcessing,
    String? id,
    String? userType,
    CandidateOnBoarding? candidate,
    List<CandidateVideoFeed>? candidateVideoFeed,
    CompanyOnboarding? companyProfile,
    List<CompanyJobPost>? companyJobPosts,
    List<CompanyJobPostVideoFeed>? companyJobPostVideoFeed,
  }) =>
      AuthenticationState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        isProcessing: isProcessing ?? this.isProcessing,
        id: id ?? this.id,
        userType: userType ?? this.userType,
        candidate: candidate ?? this.candidate,
        candidateVideoFeed: candidateVideoFeed ?? this.candidateVideoFeed,
        companyProfile: companyProfile ?? this.companyProfile,
        companyJobPosts: companyJobPosts ?? this.companyJobPosts,
        companyJobPostVideoFeed:
            companyJobPostVideoFeed ?? this.companyJobPostVideoFeed,
      );


}
