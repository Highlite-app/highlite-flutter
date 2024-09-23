import 'package:json_annotation/json_annotation.dart';

part 'push_notification_payload.g.dart';

class PushNotificationTypes {
  static const chatbox = "message";
}

@JsonSerializable()
class PushNotificationPayload {
  final String messageType;
  final String senderUserID;
  final String receiverUserID;
  final String messageChannelId;
  final String page;
  const PushNotificationPayload({
    required this.messageType,
    required this.senderUserID,
    required this.receiverUserID,
    required this.messageChannelId,
    required this.page,
  });

  factory PushNotificationPayload.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$PushNotificationPayloadToJson(this);
}
