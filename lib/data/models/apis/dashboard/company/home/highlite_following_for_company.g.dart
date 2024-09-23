// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'highlite_following_for_company.dart';
//
// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************
//
// HighliteFollowingForCompanyItemsResponse
//     _$HighliteFollowingForCompanyItemsResponseFromJson(
//             Map<String, dynamic> json) =>
//         HighliteFollowingForCompanyItemsResponse(
//           items: (json['items'] as List<dynamic>)
//               .map((e) => HighliteFollowingForCompany.fromJson(
//                   e as Map<String, dynamic>))
//               .toList(),
//           nextToken: json['nextToken'] as String?,
//         );
//
// Map<String, dynamic> _$HighliteFollowingForCompanyItemsResponseToJson(
//         HighliteFollowingForCompanyItemsResponse instance) =>
//     <String, dynamic>{
//       'items': instance.items,
//       'nextToken': instance.nextToken,
//     };
//
// HighliteFollowingForCompany _$HighliteFollowingForCompanyFromJson(
//         Map<String, dynamic> json) =>
//     HighliteFollowingForCompany(
//       id: json['id'] as String,
//       currentUserCompanyID: json['currentUserCompanyID'] as String,
//       ownerCandidateFeedID: json['ownerCandidateFeedID'] as String,
//       status: json['status'] as bool,
//       ownerCandidateFeed: HighliteFollowingCandidateVideoFeed.fromJson(
//           json['ownerCandidateFeed'] as Map<String, dynamic>),
//     );
//
// Map<String, dynamic> _$HighliteFollowingForCompanyToJson(
//         HighliteFollowingForCompany instance) =>
//     <String, dynamic>{
//       'id': instance.id,
//       'currentUserCompanyID': instance.currentUserCompanyID,
//       'ownerCandidateFeedID': instance.ownerCandidateFeedID,
//       'status': instance.status,
//       'ownerCandidateFeed': instance.ownerCandidateFeed,
//     };
