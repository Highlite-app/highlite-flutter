// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_presigned_url_without_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPresignedURLWithoutClientRequest
    _$GetPresignedURLWithoutClientRequestFromJson(Map<String, dynamic> json) =>
        GetPresignedURLWithoutClientRequest(
          filename: json['filename'] as String,
          type: json['type'] as String,
        );

Map<String, dynamic> _$GetPresignedURLWithoutClientRequestToJson(
        GetPresignedURLWithoutClientRequest instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'type': instance.type,
    };

FilenameRequest _$FilenameRequestFromJson(Map<String, dynamic> json) =>
    FilenameRequest(
      filename: json['filename'] as String,
    );

Map<String, dynamic> _$FilenameRequestToJson(FilenameRequest instance) =>
    <String, dynamic>{
      'filename': instance.filename,
    };

GetPresignedURLWithoutClientResponse
    _$GetPresignedURLWithoutClientResponseFromJson(Map<String, dynamic> json) =>
        GetPresignedURLWithoutClientResponse(
          status: json['status'] as bool,
          data: GetPresignedURLWithoutClientDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$GetPresignedURLWithoutClientResponseToJson(
        GetPresignedURLWithoutClientResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

GetPresignedURLWithoutClientDataResponse
    _$GetPresignedURLWithoutClientDataResponseFromJson(
            Map<String, dynamic> json) =>
        GetPresignedURLWithoutClientDataResponse(
          message: json['message'] as String,
          getPreSignedURL: json['getPreSignedURL'] as String,
        );

Map<String, dynamic> _$GetPresignedURLWithoutClientDataResponseToJson(
        GetPresignedURLWithoutClientDataResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'getPreSignedURL': instance.getPreSignedURL,
    };
