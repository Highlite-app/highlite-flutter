// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'highlite_message_channel.dart';
//
// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************
//
// HighliteMessageChannelItemsResponse
//     _$HighliteMessageChannelItemsResponseFromJson(Map<String, dynamic> json) =>
//         HighliteMessageChannelItemsResponse(
//           items: (json['items'] as List<dynamic>)
//               .map((e) =>
//                   HighliteMessageChannel.fromJson(e as Map<String, dynamic>))
//               .toList(),
//         );
//
// Map<String, dynamic> _$HighliteMessageChannelItemsResponseToJson(
//         HighliteMessageChannelItemsResponse instance) =>
//     <String, dynamic>{
//       'items': instance.items,
//     };
//
// HighliteMessageChannelData _$HighliteMessageChannelDataFromJson(
//         Map<String, dynamic> json) =>
//     HighliteMessageChannelData(
//       id: json['id'] as String,
//       category: json['category'] as String,
//       jobPostId: json['jobPostId'] as String,
//       candidateUserID: json['candidateUserID'] as String,
//       companyUserID: json['companyUserID'] as String,
//       isUnmatched: (json['isUnmatched'] as List<dynamic>)
//           .map((e) => e as String)
//           .toList(),
//       archivedByUsers: (json['archivedByUsers'] as List<dynamic>)
//           .map((e) => e as String)
//           .toList(),
//       favoriteByUsers: (json['favoriteByUsers'] as List<dynamic>)
//           .map((e) => e as String)
//           .toList(),
//       pinMessageId: (json['pinMessageId'] as List<dynamic>?)
//           ?.map((e) => e as String)
//           .toList(),
//       messageId: json['messageId'] as String?,
//     );
//
// Map<String, dynamic> _$HighliteMessageChannelDataToJson(
//         HighliteMessageChannelData instance) =>
//     <String, dynamic>{
//       'id': instance.id,
//       'category': instance.category,
//       'jobPostId': instance.jobPostId,
//       'candidateUserID': instance.candidateUserID,
//       'companyUserID': instance.companyUserID,
//       'messageId': instance.messageId,
//       'pinMessageId': instance.pinMessageId,
//       'isUnmatched': instance.isUnmatched,
//       'archivedByUsers': instance.archivedByUsers,
//       'favoriteByUsers': instance.favoriteByUsers,
//     };
//
// HighliteMessageChannel _$HighliteMessageChannelFromJson(
//         Map<String, dynamic> json) =>
//     HighliteMessageChannel(
//       id: json['id'] as String,
//       category: json['category'] as String,
//       jobPostId: json['jobPostId'] as String,
//       candidateUserID: json['candidateUserID'] as String,
//       companyUserID: json['companyUserID'] as String,
//       updatedAt: json['updatedAt'] as String,
//       messageId: json['messageId'] as String?,
//       latestMessage: json['latestMessage'] == null
//           ? null
//           : HighliteMessage.fromJson(
//               json['latestMessage'] as Map<String, dynamic>),
//       candidateUsers: CandidateOnBoardingInfoItemsResponse.fromJson(
//           json['candidateUsers'] as Map<String, dynamic>),
//       companyUsers: HighliteCompanyProfileItemsResponse.fromJson(
//           json['companyUsers'] as Map<String, dynamic>),
//       messages: HighliteMessageItemsResponse.fromJson(
//           json['messages'] as Map<String, dynamic>),
//       isUnmatched: (json['isUnmatched'] as List<dynamic>)
//           .map((e) => e as String)
//           .toList(),
//       archivedByUsers: (json['archivedByUsers'] as List<dynamic>)
//           .map((e) => e as String)
//           .toList(),
//       favoriteByUsers: (json['favoriteByUsers'] as List<dynamic>)
//           .map((e) => e as String)
//           .toList(),
//       pinMessageId: (json['pinMessageId'] as List<dynamic>?)
//           ?.map((e) => e as String)
//           .toList(),
//     );
//
// Map<String, dynamic> _$HighliteMessageChannelToJson(
//         HighliteMessageChannel instance) =>
//     <String, dynamic>{
//       'id': instance.id,
//       'category': instance.category,
//       'jobPostId': instance.jobPostId,
//       'candidateUserID': instance.candidateUserID,
//       'companyUserID': instance.companyUserID,
//       'updatedAt': instance.updatedAt,
//       'messageId': instance.messageId,
//       'latestMessage': instance.latestMessage,
//       'candidateUsers': instance.candidateUsers,
//       'companyUsers': instance.companyUsers,
//       'messages': instance.messages,
//       'isUnmatched': instance.isUnmatched,
//       'archivedByUsers': instance.archivedByUsers,
//       'favoriteByUsers': instance.favoriteByUsers,
//       'pinMessageId': instance.pinMessageId,
//     };
