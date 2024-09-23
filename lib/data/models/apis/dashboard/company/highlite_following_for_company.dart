// import 'package:json_annotation/json_annotation.dart';
//
// part 'highlite_following_for_company.g.dart';
//
// class HighliteFollowingForCompanyParams {
//
//   static String methodParams = """
//       \$currentUserCompanyID: String,
//       \$ownerCandidateFeedID: String,
//       \$status: Boolean
//   """;
//
//   static String queryParams = """
//       currentUserCompanyID: \$currentUserCompanyID,
//       ownerCandidateFeedID: \$ownerCandidateFeedID,
//       status: \$status
//   """;
//
//   static String modelParams = """
//       id
//       currentUserCompanyID
//       ownerCandidateFeedID
//       status
//   """;
//
//   static String modelParamByCurrentUserCompany = """
//       id
//       currentUserCompanyID
//       ownerCandidateFeedID
//       status
//       ownerCandidateFeed {
//         ${HighliteFollowingCandidateVideoFeedParams.modelParamByUser}
//       }
//   """;
// }
//
// @JsonSerializable()
// class HighliteFollowingForCompanyItemsResponse {
//   final List<HighliteFollowingForCompany> items;
//   final String? nextToken;
//   const HighliteFollowingForCompanyItemsResponse({required this.items, this.nextToken});
//   factory HighliteFollowingForCompanyItemsResponse.fromJson(
//           Map<String, dynamic> json) =>
//       _$HighliteFollowingForCompanyItemsResponseFromJson(json);
//   Map<String, dynamic> toJson() =>
//       _$HighliteFollowingForCompanyItemsResponseToJson(this);
// }
// @JsonSerializable()
// class HighliteFollowingForCompany {
//   final String id;
//   final String currentUserCompanyID;
//   final String ownerCandidateFeedID;
//   final bool status;
//   final HighliteFollowingCandidateVideoFeed ownerCandidateFeed;
//   const HighliteFollowingForCompany({
//     required this.id,
//     required this.currentUserCompanyID,
//     required this.ownerCandidateFeedID,
//     required this.status,
//     required this.ownerCandidateFeed,
//   });
//   factory HighliteFollowingForCompany.fromJson(Map<String, dynamic> json) =>
//       _$HighliteFollowingForCompanyFromJson(json);
//   Map<String, dynamic> toJson() => _$HighliteFollowingForCompanyToJson(this);
//
//   HighliteFollowingForCompany copyWith({
//     String? id,
//     String? currentUserCompanyID,
//     String? ownerCandidateFeedID,
//     bool? status,
//     HighliteFollowingCandidateVideoFeed? ownerCandidateFeed,
//   }) =>
//       HighliteFollowingForCompany(
//         id: id ?? this.id,
//         currentUserCompanyID: currentUserCompanyID ?? this.currentUserCompanyID,
//         ownerCandidateFeedID: ownerCandidateFeedID ?? this.ownerCandidateFeedID,
//         status: status ?? this.status,
//         ownerCandidateFeed: ownerCandidateFeed ?? this.ownerCandidateFeed,
//       );
// }
