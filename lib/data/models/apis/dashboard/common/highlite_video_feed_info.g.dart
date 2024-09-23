// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlite_video_feed_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HighliteVideoFeedInfoItemsResponse _$HighliteVideoFeedInfoItemsResponseFromJson(
        Map<String, dynamic> json) =>
    HighliteVideoFeedInfoItemsResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => HighliteVideoFeedInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['nextToken'] as String?,
    );

Map<String, dynamic> _$HighliteVideoFeedInfoItemsResponseToJson(
        HighliteVideoFeedInfoItemsResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'nextToken': instance.nextToken,
    };

HighliteVideoFeedInfo _$HighliteVideoFeedInfoFromJson(
        Map<String, dynamic> json) =>
    HighliteVideoFeedInfo(
      id: json['id'] as String,
      currentCandidateId: json['currentCandidateId'] as String,
      currentCompanyId: json['currentCompanyId'] as String,
      jobId: json['jobId'] as String,
      status: json['status'] as String,
      candidateLiked: json['candidateLiked'] as bool,
      companyLiked: json['companyLiked'] as bool,
      candidateDisliked: json['candidateDisliked'] as bool,
      companyDisliked: json['companyDisliked'] as bool,
    );

Map<String, dynamic> _$HighliteVideoFeedInfoToJson(
        HighliteVideoFeedInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currentCandidateId': instance.currentCandidateId,
      'currentCompanyId': instance.currentCompanyId,
      'jobId': instance.jobId,
      'status': instance.status,
      'candidateLiked': instance.candidateLiked,
      'companyLiked': instance.companyLiked,
      'candidateDisliked': instance.candidateDisliked,
      'companyDisliked': instance.companyDisliked,
    };
