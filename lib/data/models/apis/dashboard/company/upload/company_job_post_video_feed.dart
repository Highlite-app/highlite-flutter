class CompanyJobPostVideoFeed {
  final String jobVideoFeedId;
  final String playbackId;
    final String thumbnailWidth;
  final String thumbnailHeight;
  final String assetId;
  final String uploadId;
  final String jobStatus;
  final String companyId;

  CompanyJobPostVideoFeed({
    required this.jobVideoFeedId,
    required this.playbackId,
    required this.thumbnailWidth,
    required this.thumbnailHeight,
    required this.assetId,
    required this.uploadId,
    required this.jobStatus,
    required this.companyId,
  });

  factory CompanyJobPostVideoFeed.fromJson(Map<String, dynamic> json) {
    return CompanyJobPostVideoFeed(
      jobVideoFeedId: json['id'],
      playbackId: json['playbackId'],
      thumbnailWidth: json['thumbNailHeight'],
      thumbnailHeight: json['thumbNailWidth'],
      assetId: json['assetId'],
      uploadId: json['uploadId'],
      jobStatus: json['jobStatus'],
      companyId: json['companyId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': jobVideoFeedId,
      'playbackId': playbackId,
      'thumbNailHeight': thumbnailWidth,
      'thumbNailWidth': thumbnailHeight,
      'assetId': assetId,
      'uploadId': uploadId,
      'jobStatus': jobStatus,
      'companyId': companyId,
    };
  }

  CompanyJobPostVideoFeed copyWith({
    String? id,
    String? playbackId,
    String? thumbNailHeight,
    String? thumbNailWidth,
    String? assetId,
    String? uploadId,
    String? jobStatus,
    String? companyId,
  }) {
    return CompanyJobPostVideoFeed(
      jobVideoFeedId: id ?? this.jobVideoFeedId,
      playbackId: playbackId ?? this.playbackId,
      thumbnailWidth: thumbNailHeight ?? this.thumbnailWidth,
      thumbnailHeight: thumbNailWidth ?? this.thumbnailHeight,
      assetId: assetId ?? this.assetId,
      uploadId: uploadId ?? this.uploadId,
      jobStatus: jobStatus ?? this.jobStatus,
      companyId: companyId ?? this.companyId,
    );
  }
}
