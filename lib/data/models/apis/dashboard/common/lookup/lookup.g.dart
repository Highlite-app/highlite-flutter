// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lookup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HighliteLookupItemsResponse _$HighliteLookupItemsResponseFromJson(
        Map<String, dynamic> json) =>
    HighliteLookupItemsResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => HighliteLookup.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextToken: json['nextToken'] as String?,
    );

Map<String, dynamic> _$HighliteLookupItemsResponseToJson(
        HighliteLookupItemsResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'nextToken': instance.nextToken,
    };

HighliteLookup _$HighliteLookupFromJson(Map<String, dynamic> json) =>
    HighliteLookup(
      id: json['id'] as String,
      candidateID: json['candidateID'] as String,
      companyID: json['companyID'] as String,
      jobID: json['jobID'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$HighliteLookupToJson(HighliteLookup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'candidateID': instance.candidateID,
      'companyID': instance.companyID,
      'jobID': instance.jobID,
      'type': instance.type,
    };
