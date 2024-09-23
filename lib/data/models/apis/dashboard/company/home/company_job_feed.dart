import '../../../onboarding/company/company_onboarding.dart';
import '../upload/company_job_post.dart';
import 'company_home_feed_details.dart';

class  CompanyJobFeed {
  final String jobVideoFeedId;
  final String playbackId;
  final String companyId;
  final String uploadId;
  final String assetId;
  final String thumbnailWidth;
  final String thumbnailHeight;
  final String jobStatus;
  final CompanyOnboarding companyOnboarding;
  final CompanyHomeFeedDetails companyHomeFeedDetails;
  final CompanyJobPost companyJobPost;

  CompanyJobFeed({
    required this.jobVideoFeedId,
    required this.playbackId,
    required this.companyId,
    required this.uploadId,
    required this.assetId,
    required this.thumbnailWidth,
    required this.thumbnailHeight,
    required this.jobStatus,
    required this.companyOnboarding,
    required this.companyHomeFeedDetails,
    required this.companyJobPost,
  });

  factory CompanyJobFeed.fromJson(Map<String, dynamic> json) {
    return CompanyJobFeed(
      jobVideoFeedId: json['jobVideoFeedId'] ?? '',
      playbackId: json['playbackId'] ?? '',
      companyId: json['companyId'] ?? '',
      uploadId: json['uploadId'] ?? '',
      assetId: json['assetId'] ?? '',
      thumbnailWidth: json['thumbnailWidth'] ?? '',
      thumbnailHeight: json['thumbnailHeight'] ?? '',
      jobStatus: json['jobStatus'] ?? '',
      companyOnboarding: json['companyOnboarding'] != null ? CompanyOnboarding.fromJson(json['companyOnboarding']) : CompanyOnboarding.defaultOnboarding(),
      companyHomeFeedDetails: json['companyHomeFeedDetails'] != null ? CompanyHomeFeedDetails.fromJson(json['companyHomeFeedDetails']) :CompanyHomeFeedDetails.getDefaultCompanyHomeFeedDetails(),
      companyJobPost:json['companyJobPost'] != null ? CompanyJobPost.fromJson(json['companyJobPost']) : CompanyJobPost.getDefault(),
    );
  }


  //
  // Map<String, dynamic> toJson() {
  //   return {
  //     'jobVideoFeedId': jobVideoFeedId,
  //     'playbackId': playbackId,
  //     'companyId': companyId,
  //     'uploadId': uploadId,
  //     'assetId': assetId,
  //     'thumbnailWidth': thumbnailWidth,
  //     'thumbnailHeight': thumbnailHeight,
  //     'jobStatus': jobStatus,
  //     'companyOnboarding': companyOnboarding.toJson(),
  //     'companyHomeFeedDetails': companyHomeFeedDetails.toJson(),
  //     'companyJobPost': companyJobPost.toJson(),
  //   };
  // }

  CompanyJobFeed copyWith({
    String? jobVideoFeedId,
    String? playbackId,
    String? companyId,
    String? uploadId,
    String? assetId,
    String? thumbnailWidth,
    String? thumbnailHeight,
    String? jobStatus,
    CompanyOnboarding? companyOnboarding,
    CompanyHomeFeedDetails? companyHomeFeedDetails,
    CompanyJobPost? companyJobPost,
  }) {
    return CompanyJobFeed(
      jobVideoFeedId: jobVideoFeedId ?? this.jobVideoFeedId,
      playbackId: playbackId ?? this.playbackId,
      companyId: companyId ?? this.companyId,
      uploadId: uploadId ?? this.uploadId,
      assetId: assetId ?? this.assetId,
      thumbnailWidth: thumbnailWidth ?? this.thumbnailWidth,
      thumbnailHeight: thumbnailHeight ?? this.thumbnailHeight,
      jobStatus: jobStatus ?? this.jobStatus,
      companyOnboarding: companyOnboarding ?? this.companyOnboarding,
      companyHomeFeedDetails: companyHomeFeedDetails ?? this.companyHomeFeedDetails,
      companyJobPost: companyJobPost ?? this.companyJobPost,
    );
  }
}
