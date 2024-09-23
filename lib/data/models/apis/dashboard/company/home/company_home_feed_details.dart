import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';

class CompanyHomeFeedDetails {
  final String companyHomeFeedDetailsId;
  final String companyId;
  final String jobPostId;
  final String jobVideoFeedId;
  final String like;
  final String share;
  final String follows;
  final String following;
  final String profileVisit;
  final String bookmark;

  CompanyHomeFeedDetails({
    required this.companyHomeFeedDetailsId,
    required this.companyId,
    required this.jobPostId,
    required this.jobVideoFeedId,
    required this.like,
    required this.share,
    required this.follows,
    required this.following,
    required this.profileVisit,
    required this.bookmark,
  });

  // From JSON
  factory CompanyHomeFeedDetails.fromJson(Map<String, dynamic> json) {
    return CompanyHomeFeedDetails(
      companyHomeFeedDetailsId: json['companyHomeFeedDetailsId'],
      companyId: json['companyId'],
      jobPostId: json['jobPostId'],
      jobVideoFeedId: json['jobVideoFeedId'],
      like: json['like'],
      share: json['share'],
      follows: json['follows'],
      following: json['following'],
      profileVisit: json['profileVisit'],
      bookmark: json['bookmark'],
    );
  }

  static CompanyHomeFeedDetails getDefaultCompanyHomeFeedDetails() => CompanyHomeFeedDetails(
    companyHomeFeedDetailsId:"",
    companyId:authService.getUserID(),
    jobPostId: '',
    jobVideoFeedId: '',
    like: "0",
    share: "0",
    follows: "0",
    following: "0",
    profileVisit: "0",
    bookmark: "0",
  );

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'companyHomeFeedDetailsId': companyHomeFeedDetailsId,
      'companyId': companyId,
      'jobPostId': jobPostId,
      'jobVideoFeedID': jobVideoFeedId,
      'like': like,
      'share': share,
      'follows': follows,
      'following': following,
      'profileVisit': profileVisit,
      'bookmark': bookmark,
    };
  }

  // CopyWith
  CompanyHomeFeedDetails copyWith({
    String? companyHomeFeedDetailsId,
    String? companyId,
    String? jobPostId,
    String? jobVideoFeedID,
    String? like,
    String? share,
    String? follows,
    String? following,
    String? profileVisit,
    String? bookmark,
  }) {
    return CompanyHomeFeedDetails(
      companyHomeFeedDetailsId: companyHomeFeedDetailsId ?? this.companyHomeFeedDetailsId,
      companyId: companyId ?? this.companyId,
      jobPostId: jobPostId ?? this.jobPostId,
      jobVideoFeedId: jobVideoFeedID ?? this.jobVideoFeedId,
      like: like ?? this.like,
      share: share ?? this.share,
      follows: follows ?? this.follows,
      following: following ?? this.following,
      profileVisit: profileVisit ?? this.profileVisit,
      bookmark: bookmark ?? this.bookmark,
    );
  }
}
