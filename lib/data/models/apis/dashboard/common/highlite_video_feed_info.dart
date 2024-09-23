import 'package:json_annotation/json_annotation.dart';

part 'highlite_video_feed_info.g.dart';

class VideoFeedInfoParams {
  static String methodParams = """
      \$currentCandidateId: ID!,
      \$currentCompanyId: ID!,
      \$jobId: ID!,
      \$status: String,
      \$candidateLiked: Boolean,
      \$companyLiked: Boolean,
      \$candidateDisliked: Boolean,
      \$companyDisliked: Boolean
  """;
  static String queryParams = """
      currentCandidateId: \$currentCandidateId,
      currentCompanyId: \$currentCompanyId,
      jobId: \$jobId,
      status: \$status,
      candidateLiked: \$candidateLiked,
      companyLiked: \$companyLiked,
      candidateDisliked: \$candidateDisliked,
      companyDisliked: \$companyDisliked
  """;
  static String modelParams = """
      id
      currentCandidateId
      currentCompanyId
      jobId
      status
      candidateLiked
      companyLiked
      candidateDisliked
      companyDisliked
  """;
}

class VideoFeedInfoStatus {
  static String pending = 'pending';
  static String matched = 'matched';
  static String unmatched = 'unmatched';
  static String superMessage = 'super-message';
}

@JsonSerializable()
class HighliteVideoFeedInfoItemsResponse {
  final List<HighliteVideoFeedInfo> items;
  final String? nextToken;
  const HighliteVideoFeedInfoItemsResponse({
    required this.items,
    this.nextToken,
  });
  factory HighliteVideoFeedInfoItemsResponse.fromJson(
          Map<String, dynamic> json) =>
      _$HighliteVideoFeedInfoItemsResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$HighliteVideoFeedInfoItemsResponseToJson(this);
}

@JsonSerializable()
class HighliteVideoFeedInfo {
  final String id;
  final String currentCandidateId;
  final String currentCompanyId;
  final String jobId;
  final String status;
  final bool candidateLiked;
  final bool companyLiked;
  final bool candidateDisliked;
  final bool companyDisliked;
  const HighliteVideoFeedInfo({
    required this.id,
    required this.currentCandidateId,
    required this.currentCompanyId,
    required this.jobId,
    required this.status,
    required this.candidateLiked,
    required this.companyLiked,
    required this.candidateDisliked,
    required this.companyDisliked,
  });

  factory HighliteVideoFeedInfo.fromJson(Map<String, dynamic> json) =>
      _$HighliteVideoFeedInfoFromJson(json);
  Map<String, dynamic> toJson() => _$HighliteVideoFeedInfoToJson(this);

  HighliteVideoFeedInfo copyWith({
    String? id,
    String? status,
    bool? candidateLiked,
    bool? companyLiked,
    bool? candidateDisliked,
    bool? companyDisliked,
  }) =>
      HighliteVideoFeedInfo(
        id: id ?? this.id,
        currentCandidateId: currentCandidateId,
        currentCompanyId: currentCompanyId,
        jobId: jobId,
        status: status ?? this.status,
        candidateLiked: candidateLiked ?? this.candidateLiked,
        companyLiked: companyLiked ?? this.companyLiked,
        candidateDisliked: candidateDisliked ?? this.candidateDisliked,
        companyDisliked: companyDisliked ?? this.companyDisliked,
      );
}
