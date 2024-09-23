// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_flow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginFlowModel _$LoginFlowModelFromJson(Map<String, dynamic> json) =>
    LoginFlowModel(
      phoneNumber: json['phoneNumber'] as String?,
      emailAddress: json['emailAddress'] as String?,
      firstName: json['firstName'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      tokenId: json['tokenId'] as String?,
    );

Map<String, dynamic> _$LoginFlowModelToJson(LoginFlowModel instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'emailAddress': instance.emailAddress,
      'firstName': instance.firstName,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'tokenId': instance.tokenId,
    };
