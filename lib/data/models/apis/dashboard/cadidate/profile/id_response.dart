
import 'package:json_annotation/json_annotation.dart';

part 'id_response.g.dart';

@JsonSerializable()
class IDResponse {
  final String id;
  const IDResponse({
    required this.id,
  });
  factory IDResponse.fromJson(Map<String, dynamic> json) =>
      _$IDResponseFromJson(json);
  Map<String, dynamic> toJson() => _$IDResponseToJson(this);
}
