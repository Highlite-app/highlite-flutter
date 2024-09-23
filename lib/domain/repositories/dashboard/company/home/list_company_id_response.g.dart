// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_company_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyIDResponse _$CompanyIDResponseFromJson(Map<String, dynamic> json) =>
    CompanyIDResponse(
      companyId: json['companyId'] as String,
    );

Map<String, dynamic> _$CompanyIDResponseToJson(CompanyIDResponse instance) =>
    <String, dynamic>{
      'companyId': instance.companyId,
    };

ListCompanyIDResponse _$ListCompanyIDResponseFromJson(
        Map<String, dynamic> json) =>
    ListCompanyIDResponse(
      nextToken: json['nextToken'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => CompanyIDResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListCompanyIDResponseToJson(
        ListCompanyIDResponse instance) =>
    <String, dynamic>{
      'nextToken': instance.nextToken,
      'items': instance.items,
    };
