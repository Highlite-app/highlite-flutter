// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'highlite_message.dart';
//
// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************
//
// HighliteMessageItemsResponse _$HighliteMessageItemsResponseFromJson(
//         Map<String, dynamic> json) =>
//     HighliteMessageItemsResponse(
//       items: (json['items'] as List<dynamic>)
//           .map((e) => HighliteMessage.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       nextToken: json['nextToken'] as String?,
//     );
//
// Map<String, dynamic> _$HighliteMessageItemsResponseToJson(
//         HighliteMessageItemsResponse instance) =>
//     <String, dynamic>{
//       'items': instance.items,
//       'nextToken': instance.nextToken,
//     };
//
// HighliteMessage _$HighliteMessageFromJson(Map<String, dynamic> json) =>
//     HighliteMessage(
//       id: json['id'] as String,
//       message: json['message'] as String,
//       messageType: json['messageType'] as String,
//       attachments: json['attachments'] as String?,
//       candidateUserID: json['candidateUserID'] as String?,
//       candidate: json['candidate'] == null
//           ? null
//           : CandidateOnBoardingInfo.fromJson(
//               json['candidate'] as Map<String, dynamic>),
//       companyProfileID: json['companyProfileID'] as String?,
//       company: json['company'] == null
//           ? null
//           : HighliteCompanyProfile.fromJson(
//               json['company'] as Map<String, dynamic>),
//       channelID: json['channelID'] as String,
//       seenByUsers: (json['seenByUsers'] as List<dynamic>)
//           .map((e) => e as String)
//           .toList(),
//       repliedMessageID: json['repliedMessageID'] as String?,
//       repliedMessage: json['repliedMessage'] == null
//           ? null
//           : HighliteMessage.fromJson(
//               json['repliedMessage'] as Map<String, dynamic>),
//     );
//
// Map<String, dynamic> _$HighliteMessageToJson(HighliteMessage instance) =>
//     <String, dynamic>{
//       'id': instance.id,
//       'message': instance.message,
//       'messageType': instance.messageType,
//       'attachments': instance.attachments,
//       'candidateUserID': instance.candidateUserID,
//       'companyProfileID': instance.companyProfileID,
//       'channelID': instance.channelID,
//       'seenByUsers': instance.seenByUsers,
//       'repliedMessageID': instance.repliedMessageID,
//       'candidate': instance.candidate,
//       'company': instance.company,
//       'repliedMessage': instance.repliedMessage,
//     };
