//
// import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// import '../../../onboarding/company/highlite_company_profile.dart';
// import 'highlite_message.dart';
//
// part 'highlite_message_channel.g.dart';
//
//
//
// @JsonSerializable()
// class HighliteMessageChannelItemsResponse {
//   final List<HighliteMessageChannel> items;
//   const HighliteMessageChannelItemsResponse({required this.items});
//   factory HighliteMessageChannelItemsResponse.fromJson(
//           Map<String, dynamic> json) =>
//       _$HighliteMessageChannelItemsResponseFromJson(json);
//   Map<String, dynamic> toJson() =>
//       _$HighliteMessageChannelItemsResponseToJson(this);
// }
//
// @JsonSerializable()
// class HighliteMessageChannelData {
//   final String id;
//   final String category;
//   final String jobPostId;
//   final String candidateUserID;
//   final String companyUserID;
//   final String? messageId;
//   final List<String>? pinMessageId;
//   final List<String> isUnmatched;
//   final List<String> archivedByUsers;
//   final List<String> favoriteByUsers;
//   const HighliteMessageChannelData({
//     required this.id,
//     required this.category,
//     required this.jobPostId,
//     required this.candidateUserID,
//     required this.companyUserID,
//     required this.isUnmatched,
//     required this.archivedByUsers,
//     required this.favoriteByUsers,
//     required this.pinMessageId,
//     this.messageId,
//   });
//   factory HighliteMessageChannelData.fromJson(Map<String, dynamic> json) =>
//       _$HighliteMessageChannelDataFromJson(json);
//   Map<String, dynamic> toJson() => _$HighliteMessageChannelDataToJson(this);
//
//   HighliteMessageChannelData copyWith({
//     String? id,
//     String? messageId,
//     List<String>? isUnmatched,
//     List<String>? archivedByUsers,
//     List<String>? favoriteByUsers,
//     List<String>? pinMessageId,
//   }) =>
//       HighliteMessageChannelData(
//         id: id ?? this.id,
//         category: category,
//         jobPostId: jobPostId,
//         candidateUserID: candidateUserID,
//         companyUserID: companyUserID,
//         messageId: messageId ?? this.messageId,
//         isUnmatched: isUnmatched ?? this.isUnmatched,
//         archivedByUsers: archivedByUsers ?? this.archivedByUsers,
//         favoriteByUsers: favoriteByUsers ?? this.favoriteByUsers,
//         pinMessageId: pinMessageId ?? this.pinMessageId,
//       );
// }
//
// @JsonSerializable()
// class HighliteMessageChannel {
//   final String id;
//   final String category;
//   final String jobPostId;
//   final String candidateUserID;
//   final String companyUserID;
//   final String updatedAt;
//   final String? messageId;
//   final HighliteMessage? latestMessage;
//   final CandidateOnBoardingInfoItemsResponse candidateUsers;
//   final HighliteCompanyProfileItemsResponse companyUsers;
//   final HighliteMessageItemsResponse messages;
//   final List<String> isUnmatched;
//   final List<String> archivedByUsers;
//   final List<String> favoriteByUsers;
//   final List<String>? pinMessageId;
//   const HighliteMessageChannel({
//     required this.id,
//     required this.category,
//     required this.jobPostId,
//     required this.candidateUserID,
//     required this.companyUserID,
//     required this.updatedAt,
//     this.messageId,
//     this.latestMessage,
//     required this.candidateUsers,
//     required this.companyUsers,
//     required this.messages,
//     required this.isUnmatched,
//     required this.archivedByUsers,
//     required this.favoriteByUsers,
//     required this.pinMessageId,
//   });
//   factory HighliteMessageChannel.fromJson(Map<String, dynamic> json) =>
//       _$HighliteMessageChannelFromJson(json);
//   Map<String, dynamic> toJson() => _$HighliteMessageChannelToJson(this);
//   HighliteMessageChannelData toData() => HighliteMessageChannelData(
//         id: id,
//         category: category,
//         jobPostId: jobPostId,
//         candidateUserID: candidateUserID,
//         companyUserID: companyUserID,
//         messageId: messageId,
//         isUnmatched: isUnmatched,
//         archivedByUsers: archivedByUsers,
//         favoriteByUsers: favoriteByUsers,
//         pinMessageId: pinMessageId,
//       );
//   // String get lastMessage {
//   //   String message = latestMessage?.message ?? "";
//   //   if (category == MessageChannelTypes.directMessage &&
//   //       latestMessage == null) {
//   //     message = "You've got a new match";
//   //   }
//   //   return message;
//   // }
//
//   bool isLastMessageSeen(String userId) {
//     if (latestMessage != null) {
//       final count =
//           latestMessage!.seenByUsers.where((e) => e == userId).toList().length;
//       return count != 0;
//     } else {
//       return false;
//     }
//   }
//
//   bool isFavorite(String userId) {
//     final count = favoriteByUsers.where((e) => e == userId).toList().length;
//     return count != 0;
//   }
//
//   bool isLastMessageSeenByOtherUser(String userId) {
//     if (latestMessage != null) {
//       final count =
//           latestMessage!.seenByUsers.where((e) => e != userId).toList().length;
//       return count != 0;
//     } else {
//       return false;
//     }
//   }
//
//   // bool get isPendingSuperMessageFromYou {
//   //   if (latestMessage?.senderID == authService.getUserID()) {
//   //     return (latestMessage?.isSuperMessage ?? false);
//   //   }
//   //   return false;
//   // }
//
//   bool get isArchived {
//     return archivedByUsers.contains(authService.getUserID());
//   }
// }
