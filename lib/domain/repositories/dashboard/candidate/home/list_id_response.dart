import 'package:json_annotation/json_annotation.dart';

import '../../../../../data/models/apis/dashboard/cadidate/profile/id_response.dart';



part 'list_id_response.g.dart';

@JsonSerializable()
class ListIDResponse {
  final String? nextToken;
  final List<IDResponse> items;
  const ListIDResponse({
    this.nextToken,
    required this.items,
  });
  factory ListIDResponse.fromJson(Map<String, dynamic> json) =>
      _$ListIDResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListIDResponseToJson(this);
}
