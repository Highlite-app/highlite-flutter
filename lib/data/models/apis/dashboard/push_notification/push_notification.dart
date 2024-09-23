import 'package:json_annotation/json_annotation.dart';

part 'push_notification.g.dart';

@JsonSerializable()
class PushNotificationRequest {
  final String messageTitle;
  final String message;
  final String messageType;
  final String senderUserID;
  final String receiverUserID;
  final String messageChannelId;
  const PushNotificationRequest({
    required this.messageTitle,
    required this.message,
    required this.messageType,
    required this.senderUserID,
    required this.receiverUserID,
    required this.messageChannelId,
  });

  factory PushNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PushNotificationRequestToJson(this);
}
