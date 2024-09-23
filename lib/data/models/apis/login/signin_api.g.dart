// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigninRequest _$SigninRequestFromJson(Map<String, dynamic> json) =>
    SigninRequest(
      signInOption: json['signInOption'] as String,
      sendTo: json['sendTo'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$SigninRequestToJson(SigninRequest instance) =>
    <String, dynamic>{
      'signInOption': instance.signInOption,
      'sendTo': instance.sendTo,
      'otp': instance.otp,
    };

SigninResponse _$SigninResponseFromJson(Map<String, dynamic> json) =>
    SigninResponse(
      status: json['status'] as bool,
      data: SigninTokensResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SigninResponseToJson(SigninResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

SigninTokensResponse _$SigninTokensResponseFromJson(
        Map<String, dynamic> json) =>
    SigninTokensResponse(
      id: json['id'] as String?,
      message: json['message'] as String,
      accessToken: json['accessToken'] as String?,
      tokenId: json['tokenId'] as String?,
      refreshToken: json['refreshToken'] as String?,
      userType: json['userType'] as String?,
      isLoggedIn: json['isLoggedIn'] as bool?,
    );

Map<String, dynamic> _$SigninTokensResponseToJson(
        SigninTokensResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'accessToken': instance.accessToken,
      'tokenId': instance.tokenId,
      'refreshToken': instance.refreshToken,
      'userType': instance.userType,
      'isLoggedIn': instance.isLoggedIn,
    };
