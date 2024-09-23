// import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// import '../../../onboarding/company/highlite_company_profile.dart';
//
// part 'highlite_message.g.dart';
//
// @JsonSerializable()
// class HighliteMessageItemsResponse {
//   final List<HighliteMessage> items;
//   final String? nextToken;
//
//   const HighliteMessageItemsResponse({required this.items, this.nextToken});
//
//   factory HighliteMessageItemsResponse.fromJson(Map<String, dynamic> json) =>
//       _$HighliteMessageItemsResponseFromJson(json);
//
//   Map<String, dynamic> toJson() => _$HighliteMessageItemsResponseToJson(this);
// }
//
// @JsonSerializable()
// class HighliteMessage {
//   final String id;
//   final String message;
//   final String messageType;
//   final String? attachments;
//   final String? candidateUserID;
//   final String? companyProfileID;
//   final String channelID;
//   final List<String> seenByUsers;
//   final String? repliedMessageID;
//   final CandidateOnBoarding? candidate;
//   final HighliteCompanyProfile? company;
//   final HighliteMessage? repliedMessage;
//
//   const HighliteMessage({
//     required this.id,
//     required this.message,
//     required this.messageType,
//     this.attachments,
//     this.candidateUserID,
//     this.candidate,
//     this.companyProfileID,
//     this.company,
//     required this.channelID,
//     required this.seenByUsers,
//     this.repliedMessageID,
//     this.repliedMessage,
//   });
//
//   factory HighliteMessage.fromJson(Map<String, dynamic> json) =>
//       _$HighliteMessageFromJson(json);
//
//   Map<String, dynamic> toJson() => _$HighliteMessageToJson(this);
//
//   HighliteMessage copyWith({
//     String? id,
//     String? message,
//     String? candidateUserID,
//     String? companyProfileID,
//     List<String>? seenByUsers,
//   }) =>
//       HighliteMessage(
//         id: id ?? this.id,
//         message: message ?? this.message,
//         messageType: messageType,
//         attachments: attachments,
//         candidateUserID: candidateUserID ?? this.candidateUserID,
//         companyProfileID: companyProfileID ?? this.companyProfileID,
//         channelID: channelID,
//         seenByUsers: seenByUsers ?? this.seenByUsers,
//         repliedMessageID: repliedMessageID,
//         repliedMessage: repliedMessage,
//       );
//
//   String get senderID {
//     if (candidateUserID != null) {
//       return candidateUserID!;
//     } else {
//       return companyProfileID!;
//     }
//   }
//
//   String get senderName {
//     if (candidate != null) {
//       return candidate!.candidateId;
//     } else {
//       return company!.companyName;
//     }
//   }
//
// // String get relativeName {
// //   if (authV2Service.getUserID() == senderID) {
// //     return "You";
// //   } else {
// //     return senderName;
// //   }
// // }
// //
// // ResponseContent? responseContent(String otherUser) {
// //   if (isSuperMessageResponse) {
// //     String responseContent = "";
// //     ResponseContentStyle style = ResponseContentStyle.primary;
// //     bool isLastMessage = false;
// //     var decrypted;
// //     if (message.decrypted == currentLocalizations.accept) {
// //       if (senderID != authV2Service.getUserID()) {
// //         responseContent =
// //             currentLocalizations.acceptedSuperMessage(otherUser);
// //       } else {
// //         responseContent = currentLocalizations.acceptSuperMessage(otherUser);
// //       }
// //       style = ResponseContentStyle.primary;
// //       isLastMessage = false;
// //     } else if (message.decrypted == currentLocalizations.reject) {
// //       if (senderID != authV2Service.getUserID()) {
// //         responseContent =
// //             currentLocalizations.rejectedSuperMessage(otherUser);
// //       } else {
// //         responseContent = currentLocalizations.rejectSuperMessage(otherUser);
// //       }
// //       style = ResponseContentStyle.warning;
// //       isLastMessage = true;
// //     } else {
// //       if (senderID != authV2Service.getUserID()) {
// //         responseContent = currentLocalizations.blockedSuperMessage(otherUser);
// //       } else {
// //         responseContent = currentLocalizations.blockSuperMessage(otherUser);
// //       }
// //       style = ResponseContentStyle.error;
// //       isLastMessage = true;
// //     }
// //     return ResponseContent(
// //       content: responseContent,
// //       icon: "lightning-02",
// //       style: style,
// //       bottomLine: (isLastMessage) ? currentLocalizations.findArchived : null,
// //       isLastMessage: isLastMessage,
// //     );
// //   }
// //   return null;
// // }
// //
// // String get inboxMessage {
// //   if (isSuperMessageResponse) {
// //     if (message.decrypted == currentLocalizations.accept) {
// //       if (senderID != authV2Service.getUserID()) {
// //         return "$senderName have accepted your super message.";
// //       }
// //       return "You have accepted the super message.";
// //     } else if (message.decrypted == currentLocalizations.reject) {
// //       if (senderID != authV2Service.getUserID()) {
// //         return "$senderName have declined your super message.";
// //       }
// //       return "You have rejected the super message.";
// //     }
// //     return "Blocked!";
// //   }
// //   if (isAttachment) {
// //     return "$relativeName sent an attachment.";
// //   }
// //   return message.decrypted;
// // }
// //
// // bool get isAttachment =>
// //     messageType == MessageTypes.attachments ||
// //     messageType == MessageTypes.file;
// // bool get isSuperMessage => messageType == MessageTypes.superMessage;
// // bool get isSuperMessageResponse =>
// //     messageType == MessageTypes.superMessageResponse;
// // bool get isSuperMessageAccepted =>
// //     message.decrypted == currentLocalizations.accept;
// // BubbleType get bubbleType {
// //   if (messageType == MessageTypes.superMessageResponse) {
// //     return BubbleType.response;
// //   } else if (messageType == MessageTypes.attachments) {
// //     return BubbleType.uploadedImages;
// //   } else if (messageType == MessageTypes.file) {
// //     return BubbleType.file;
// //   } else {
// //     return BubbleType.text;
// //   }
// // }
// //
// // RepliedMessage? get repliedMessageContents {
// //   if (repliedMessage != null) {
// //     final message = repliedMessage!.message.decrypted;
// //     final fileboxMessage = repliedMessage!.filePayload != null
// //         ? FileboxMessage(
// //             fileName: repliedMessage!.filePayload!.documentName,
// //             fileBytes: repliedMessage!.filePayload!.fileSize,
// //           )
// //         : null;
// //     if (repliedMessage!.senderID == authV2Service.getUserID()) {
// //       if (senderID == authV2Service.getUserID()) {
// //         return RepliedMessage(
// //           message: message,
// //           repliedTo: "You replied to yourself",
// //           fileboxMessage: fileboxMessage,
// //         );
// //       } else {
// //         return RepliedMessage(
// //           message: message,
// //           repliedTo: "$senderName replied to your message",
// //           fileboxMessage: fileboxMessage,
// //         );
// //       }
// //     } else {
// //       if (senderID == authV2Service.getUserID()) {
// //         return RepliedMessage(
// //           message: message,
// //           repliedTo: "You replied to ${repliedMessage!.senderName}'s message",
// //           fileboxMessage: fileboxMessage,
// //         );
// //       } else {
// //         return RepliedMessage(
// //           message: message,
// //           repliedTo: "${repliedMessage!.senderName} replied to their message",
// //           fileboxMessage: fileboxMessage,
// //         );
// //       }
// //     }
// //   }
// //   return null;
// // }
// //
// // AttachmentPayload? get filePayload {
// //   if (attachments != null && attachments != "") {
// //     List<Map<String, dynamic>> list = List.from(jsonDecode(attachments!));
// //     final List<AttachmentPayload> payloads =
// //         list.map((e) => AttachmentPayload.fromJson(e)).toList();
// //     return payloads.first;
// //   }
// //   return null;
// // }
// //
// // List<AttachmentPayload>? get attachmentPayloads {
// //   if (attachments != null && attachments != "") {
// //     List<Map<String, dynamic>> list = List.from(jsonDecode(attachments!));
// //
// //     final List<AttachmentPayload> payloads =
// //         list.map((e) => AttachmentPayload.fromJson(e)).toList();
// //     return payloads;
// //   }
// //   return null;
// // }
// }
