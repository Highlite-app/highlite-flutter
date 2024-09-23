class CandidateVideoFeed {
  String candidateVideoFeedId;
  String candidateId;
  String description;
  String thumbnailUrl;
  String thumbnailWidth;
  String thumbnailHeight;
  String playbackId;
  String assetId;
  String uploadId;
  List<String> tag;
  List<String> category;

  CandidateVideoFeed({
    required this.candidateVideoFeedId,
    required this.candidateId,
    required this.description,
    required this.thumbnailUrl,
    required this.thumbnailWidth,
    required this.thumbnailHeight,
    required this.playbackId,
    required this.assetId,
    required this.uploadId,
    required this.tag,
    required this.category,
  });


  static List<CandidateVideoFeed> listFromJson(List<dynamic> jsonList){
  return   jsonList.map((e) => CandidateVideoFeed.fromJson(e)).toList() ;
  }
  factory CandidateVideoFeed.fromJson(Map<String, dynamic> json) {
    return CandidateVideoFeed(
      candidateVideoFeedId: json['candidateVideoFeedId'],
      candidateId: json['candidateId'],
      description: json['description'],
      thumbnailUrl: json['thumbnailUrl'],
      thumbnailWidth: json['thumbnailWidth'],
      thumbnailHeight: json['thumbnailHeight'],
      playbackId: json['playbackId'],
      assetId: json['assetId'],
      uploadId: json['uploadId'],
      tag: List<String>.from(json['tag']),
      category: List<String>.from(json['category']),
    );
  }

  static CandidateVideoFeed getDefault() => CandidateVideoFeed(
    candidateVideoFeedId: 'default_candidate_video_feed_id',
    candidateId: 'default_candidate_id',
    description: 'This is a default description.',
    thumbnailUrl: 'https://example.com/default_thumbnail.jpg',
    thumbnailWidth: '1280',
    thumbnailHeight: '720',
    playbackId: 'default_playback_id',
    assetId: 'default_asset_id',
    uploadId: 'default_upload_id',
    tag: ['default_tag1', 'default_tag2'],
    category: ['default_category1', 'default_category2'],
  );

  Map<String, dynamic> toJson() {
    return {
      'candidateVideoFeedId': candidateVideoFeedId,
      'candidateId': candidateId,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'thumbnailWidth': thumbnailWidth.toString(),
      'thumbnailHeight': thumbnailHeight.toString(),
      'playbackId': playbackId,
      'assetId': assetId,
      'uploadId': uploadId,
      'tag': tag,
      'category': category,
    };
  }
}
