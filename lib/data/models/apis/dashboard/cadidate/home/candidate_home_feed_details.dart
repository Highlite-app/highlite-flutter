import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';

class CandidateHomeFeedDetails {
  final String candidateHomeFeedDetailsId;
  final String candidateId;
  final String candidateVideoFeedId;
  final String like;
  final String share;
  final String follows;
  final String following;
  final String profileVisit;
  final String bookmark;

  CandidateHomeFeedDetails({
    required this.candidateHomeFeedDetailsId,
    required this.candidateId,
    required this.candidateVideoFeedId,
    required this.like,
    required this.share,
    required this.follows,
    required this.following,
    required this.profileVisit,
    required this.bookmark,
  });

  // From JSON
  factory CandidateHomeFeedDetails.fromJson(Map<String, dynamic> json) {
    return CandidateHomeFeedDetails(
      candidateHomeFeedDetailsId: json['candidateHomeFeedDetailsId'],
      candidateId: json['candidateId'],
      candidateVideoFeedId: json['candidateVideoFeedId'],
      like: json['like'],
      share: json['share'],
      follows: json['follows'],
      following: json['following'],
      profileVisit: json['profileVisit'],
      bookmark: json['bookmark'],
    );
  }

  static CandidateHomeFeedDetails getDefaultCandidateHomeFeedDetails() => CandidateHomeFeedDetails(
    candidateHomeFeedDetailsId:"",
    candidateId:authService.getUserID(),
    candidateVideoFeedId: '',
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
      'candidateHomeFeedDetailsId': candidateHomeFeedDetailsId,
      'candidateId': candidateId,
      'candidateVideoFeedId': candidateVideoFeedId,
      'like': like,
      'share': share,
      'follows': follows,
      'following': following,
      'profileVisit': profileVisit,
      'bookmark': bookmark,
    };
  }

  // CopyWith
  CandidateHomeFeedDetails copyWith({
    String? candidateHomeFeedDetailsId,
    String? candidateId,
    String? candidateVideoFeedId,
    String? like,
    String? share,
    String? follows,
    String? following,
    String? profileVisit,
    String? bookmark,
  }) {
    return CandidateHomeFeedDetails(
      candidateHomeFeedDetailsId: candidateHomeFeedDetailsId ?? this.candidateHomeFeedDetailsId,
      candidateId: candidateId ?? this.candidateId,
      candidateVideoFeedId: candidateVideoFeedId ?? this.candidateVideoFeedId,
      like: like ?? this.like,
      share: share ?? this.share,
      follows: follows ?? this.follows,
      following: following ?? this.following,
      profileVisit: profileVisit ?? this.profileVisit,
      bookmark: bookmark ?? this.bookmark,
    );
  }
}
