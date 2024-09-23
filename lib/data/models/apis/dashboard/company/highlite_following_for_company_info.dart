import 'package:json_annotation/json_annotation.dart';

part 'highlite_following_for_company_info.g.dart';

class HighliteFollowingForCompanyInfoParams {
  
  static String methodParams = """
      \$currentUserCompanyID: String,
      \$ownerCandidateFeedID: String,
      \$status: Boolean
  """;
  
  static String queryParams = """
      currentUserCompanyID: \$currentUserCompanyID,
      ownerCandidateFeedID: \$ownerCandidateFeedID,
      status: \$status
  """;

  static String modelParams = """
      id
      currentUserCompanyID
      ownerCandidateFeedID
      status
  """;

  
}

@JsonSerializable()
class HighliteFollowingForCompanyInfoItemsResponse {
  final List<HighliteFollowingForCompanyInfo> items;
  const HighliteFollowingForCompanyInfoItemsResponse({required this.items});
  factory HighliteFollowingForCompanyInfoItemsResponse.fromJson(
          Map<String, dynamic> json) =>
      _$HighliteFollowingForCompanyInfoItemsResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$HighliteFollowingForCompanyInfoItemsResponseToJson(this);
}
@JsonSerializable()
class HighliteFollowingForCompanyInfo {
  final String id;
  final String currentUserCompanyID;
  final String ownerCandidateFeedID;
  final bool status;
  const HighliteFollowingForCompanyInfo({
    required this.id,
    required this.currentUserCompanyID,
    required this.ownerCandidateFeedID,
    required this.status,
  });
  factory HighliteFollowingForCompanyInfo.fromJson(Map<String, dynamic> json) =>
      _$HighliteFollowingForCompanyInfoFromJson(json);
  Map<String, dynamic> toJson() => _$HighliteFollowingForCompanyInfoToJson(this);

  HighliteFollowingForCompanyInfo copyWith({
    String? id,
    String? currentUserCompanyID,
    String? ownerCandidateFeedID,
    bool? status,
  }) =>
      HighliteFollowingForCompanyInfo(
        id: id ?? this.id,
        currentUserCompanyID: currentUserCompanyID ?? this.currentUserCompanyID,
        ownerCandidateFeedID: ownerCandidateFeedID ?? this.ownerCandidateFeedID,
        status: status ?? this.status,
      );
}
