// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persisted_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersistedUser _$PersistedUserFromJson(Map<String, dynamic> json) =>
    PersistedUser(
      isLoggedIn: json['isLoggedIn'] as bool,
      tokenId: json['tokenId'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      id: json['id'] as String,
      userType: json['userType'] as String,
      companyId: json['companyId'] as String?,
    );

Map<String, dynamic> _$PersistedUserToJson(PersistedUser instance) =>
    <String, dynamic>{
      'isLoggedIn': instance.isLoggedIn,
      'tokenId': instance.tokenId,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'id': instance.id,
      'userType': instance.userType,
      'companyId': instance.companyId,
    };
