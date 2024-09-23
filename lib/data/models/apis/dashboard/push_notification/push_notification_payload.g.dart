// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationPayload _$PushNotificationPayloadFromJson(
        Map<String, dynamic> json) =>
    PushNotificationPayload(
      messageType: json['messageType'] as String,
      senderUserID: json['senderUserID'] as String,
      receiverUserID: json['receiverUserID'] as String,
      messageChannelId: json['messageChannelId'] as String,
      page: json['page'] as String,
    );

Map<String, dynamic> _$PushNotificationPayloadToJson(
        PushNotificationPayload instance) =>
    <String, dynamic>{
      'messageType': instance.messageType,
      'senderUserID': instance.senderUserID,
      'receiverUserID': instance.receiverUserID,
      'messageChannelId': instance.messageChannelId,
      'page': instance.page,
    };
