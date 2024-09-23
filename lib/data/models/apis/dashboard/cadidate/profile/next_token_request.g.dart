// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NextTokenRequest _$NextTokenRequestFromJson(Map<String, dynamic> json) =>
    NextTokenRequest(
      nextToken: json['nextToken'] as String?,
    );

Map<String, dynamic> _$NextTokenRequestToJson(NextTokenRequest instance) =>
    <String, dynamic>{
      'nextToken': instance.nextToken,
    };

NextTokenResponse _$NextTokenResponseFromJson(Map<String, dynamic> json) =>
    NextTokenResponse(
      nextToken: json['nextToken'] as String?,
    );

Map<String, dynamic> _$NextTokenResponseToJson(NextTokenResponse instance) =>
    <String, dynamic>{
      'nextToken': instance.nextToken,
    };
