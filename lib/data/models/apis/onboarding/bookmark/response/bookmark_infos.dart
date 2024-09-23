import '../../../dashboard/cadidate/home/candidate_home_feed_details.dart';
import '../../../dashboard/cadidate/upload/about /about_candidate.dart';
import '../../../dashboard/cadidate/upload/education/candidate_education.dart';
import '../../../dashboard/cadidate/upload/employment/candidate_employment.dart';
import '../../../dashboard/cadidate/upload/project/candidate_project.dart';
import '../../../dashboard/cadidate/upload/video/candidate_video_feed.dart';
import '../../../dashboard/company/home/company_home_feed_details.dart';
import '../../../dashboard/company/upload/company_job_post.dart';
import '../../../dashboard/company/upload/company_job_post_video_feed.dart';
import '../../candidate/candidate_onboarding.dart';
import '../../company/company_onboarding.dart';

class BookmarkInfo {
  final String bookmarkInfoId;
  final String type;
  final String bookmarkCollectionId;
  final String referenceId;



  // Candidate part
  final CandidateOnBoarding? candidateOnBoarding;
  final CandidateVideoFeed? candidateVideoFeed;
  final AboutCandidate? aboutCandidate;
  final List<CandidateEducation>? candidateEducation;
  final List<CandidateEmployment>? candidateEmployment;
  final List<CandidateProject>? candidateProject;
  final CandidateHomeFeedDetails? candidateHomeFeedDetails;

  // Company part
  final CompanyOnboarding? companyOnboarding;
  final CompanyJobPost? jobPosting;
  final CompanyHomeFeedDetails? companyHomeFeedDetails;
  final CompanyJobPostVideoFeed? companyJobPostVideoFeed;


  BookmarkInfo({
    required this.bookmarkInfoId,
    required this.type,
    required this.bookmarkCollectionId,
    required this.referenceId,
    this.companyOnboarding,
    this.jobPosting,
    this.companyHomeFeedDetails,
    this.companyJobPostVideoFeed,
    this.candidateOnBoarding,
    this.candidateVideoFeed,
    this.aboutCandidate,
    this.candidateEducation,
    this.candidateEmployment,
    this.candidateProject,
    this.candidateHomeFeedDetails,
  });

  // fromJson method
  factory BookmarkInfo.fromJson(Map<String, dynamic> json) {
    return BookmarkInfo(
      bookmarkInfoId: json['bookmarkInfoId'] ?? '',
      type: json['type'] ?? '',
      bookmarkCollectionId: json['bookmarkCollectionId'] ?? '',
      referenceId: json['referenceId'],
      companyOnboarding: json['companyOnboarding'] != null
          ? CompanyOnboarding.fromJson(json['companyOnboarding'])
          : null,
      jobPosting: json['jobPosting'] != null
          ? CompanyJobPost.fromJson(json['jobPosting'])
          : null,
      companyHomeFeedDetails: json['companyHomeFeedDetails'] != null
          ? CompanyHomeFeedDetails.fromJson(json['companyHomeFeedDetails'])
          : null,
      companyJobPostVideoFeed: json['companyJobPostVideoFeed'] != null
          ? CompanyJobPostVideoFeed.fromJson(json['companyJobPostVideoFeed'])
          : null,
      candidateOnBoarding: json['candidateOnBoarding'] != null
          ? CandidateOnBoarding.fromJson(json['candidateOnBoarding'])
          : null,
      candidateVideoFeed: json['candidateVideoFeed'] != null
          ? CandidateVideoFeed.fromJson(json['candidateVideoFeed'])
          : null,
      aboutCandidate: json['aboutCandidate'] != null
          ? AboutCandidate.fromJson(json['aboutCandidate'])
          : null,
      candidateEducation: json['candidateEducation'] != null
          ? (json['candidateEducation'] as List)
          .map((e) => CandidateEducation.fromJson(e))
          .toList()
          : null,
      candidateEmployment: json['candidateEmployment'] != null
          ? (json['candidateEmployment'] as List)
          .map((e) => CandidateEmployment.fromJson(e))
          .toList()
          : null,
      candidateProject: json['candidateProject'] != null
          ? (json['candidateProject'] as List)
          .map((e) => CandidateProject.fromJson(e))
          .toList()
          : null,
      candidateHomeFeedDetails: json['candidateHomeFeedDetails'] != null
          ? CandidateHomeFeedDetails.fromJson(json['candidateHomeFeedDetails'])
          : null,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'bookmarkInfoId': bookmarkInfoId,
      'type': type,
      'bookmarkCollectionId': bookmarkCollectionId,
      'referenceId': referenceId,
      'companyOnboarding': companyOnboarding?.toJson(),
      'jobPosting': jobPosting?.toJson(),
      'companyHomeFeedDetails': companyHomeFeedDetails?.toJson(),
      'companyJobPostVideoFeed': companyJobPostVideoFeed?.toJson(),
      'candidateOnBoarding': candidateOnBoarding?.toJson(),
      'candidateVideoFeed': candidateVideoFeed?.toJson(),
      'aboutCandidate': aboutCandidate?.toJson(),
      'candidateEducation': candidateEducation?.map((e) => e.toJson()).toList(),
      'candidateEmployment': candidateEmployment?.map((e) => e.toJson()).toList(),
      'candidateProject': candidateProject?.map((e) => e.toJson()).toList(),
      'candidateHomeFeedDetails': candidateHomeFeedDetails?.toJson(),
    };
  }

  // copyWith method
  BookmarkInfo copyWith({
    String? bookmarkInfoId,
    String? type,
    String? bookmarkCollectionId,
    String? referenceId,
    CompanyOnboarding? companyOnboarding,
    CompanyJobPost? jobPosting,
    CompanyHomeFeedDetails? companyHomeFeedDetails,
    CompanyJobPostVideoFeed? companyJobPostVideoFeed,
    CandidateOnBoarding? candidateOnBoarding,
    CandidateVideoFeed? candidateVideoFeed,
    AboutCandidate? aboutCandidate,
    List<CandidateEducation>? candidateEducation,
    List<CandidateEmployment>? candidateEmployment,
    List<CandidateProject>? candidateProject,
    CandidateHomeFeedDetails? candidateHomeFeedDetails,
  }) {
    return BookmarkInfo(
      bookmarkInfoId: bookmarkInfoId ?? this.bookmarkInfoId,
      type: type ?? this.type,
      bookmarkCollectionId: bookmarkCollectionId ?? this.bookmarkCollectionId,
      referenceId: referenceId ?? this.referenceId,
      companyOnboarding: companyOnboarding ?? this.companyOnboarding,
      jobPosting: jobPosting ?? this.jobPosting,
      companyHomeFeedDetails: companyHomeFeedDetails ?? this.companyHomeFeedDetails,
      companyJobPostVideoFeed: companyJobPostVideoFeed ?? this.companyJobPostVideoFeed,
      candidateOnBoarding: candidateOnBoarding ?? this.candidateOnBoarding,
      candidateVideoFeed: candidateVideoFeed ?? this.candidateVideoFeed,
      aboutCandidate: aboutCandidate ?? this.aboutCandidate,
      candidateEducation: candidateEducation ?? this.candidateEducation,
      candidateEmployment: candidateEmployment ?? this.candidateEmployment,
      candidateProject: candidateProject ?? this.candidateProject,
      candidateHomeFeedDetails: candidateHomeFeedDetails ?? this.candidateHomeFeedDetails,
    );
  }
}
