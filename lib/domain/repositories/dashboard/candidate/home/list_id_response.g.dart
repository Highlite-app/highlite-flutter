// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListIDResponse _$ListIDResponseFromJson(Map<String, dynamic> json) =>
    ListIDResponse(
      nextToken: json['nextToken'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => IDResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListIDResponseToJson(ListIDResponse instance) =>
    <String, dynamic>{
      'nextToken': instance.nextToken,
      'items': instance.items,
    };
