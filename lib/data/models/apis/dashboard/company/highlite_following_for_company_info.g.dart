// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlite_following_for_company_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HighliteFollowingForCompanyInfoItemsResponse
    _$HighliteFollowingForCompanyInfoItemsResponseFromJson(
            Map<String, dynamic> json) =>
        HighliteFollowingForCompanyInfoItemsResponse(
          items: (json['items'] as List<dynamic>)
              .map((e) => HighliteFollowingForCompanyInfo.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$HighliteFollowingForCompanyInfoItemsResponseToJson(
        HighliteFollowingForCompanyInfoItemsResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

HighliteFollowingForCompanyInfo _$HighliteFollowingForCompanyInfoFromJson(
        Map<String, dynamic> json) =>
    HighliteFollowingForCompanyInfo(
      id: json['id'] as String,
      currentUserCompanyID: json['currentUserCompanyID'] as String,
      ownerCandidateFeedID: json['ownerCandidateFeedID'] as String,
      status: json['status'] as bool,
    );

Map<String, dynamic> _$HighliteFollowingForCompanyInfoToJson(
        HighliteFollowingForCompanyInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currentUserCompanyID': instance.currentUserCompanyID,
      'ownerCandidateFeedID': instance.ownerCandidateFeedID,
      'status': instance.status,
    };
