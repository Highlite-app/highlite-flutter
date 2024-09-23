// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationRequest _$PushNotificationRequestFromJson(
        Map<String, dynamic> json) =>
    PushNotificationRequest(
      messageTitle: json['messageTitle'] as String,
      message: json['message'] as String,
      messageType: json['messageType'] as String,
      senderUserID: json['senderUserID'] as String,
      receiverUserID: json['receiverUserID'] as String,
      messageChannelId: json['messageChannelId'] as String,
    );

Map<String, dynamic> _$PushNotificationRequestToJson(
        PushNotificationRequest instance) =>
    <String, dynamic>{
      'messageTitle': instance.messageTitle,
      'message': instance.message,
      'messageType': instance.messageType,
      'senderUserID': instance.senderUserID,
      'receiverUserID': instance.receiverUserID,
      'messageChannelId': instance.messageChannelId,
    };
