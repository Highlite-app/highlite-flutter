import 'package:json_annotation/json_annotation.dart';

part 'id_request.g.dart';
@JsonSerializable()
class IDRequest {
  final String id;
  const IDRequest({
    required this.id,
  });
  factory IDRequest.fromJson(Map<String, dynamic> json) =>
      _$IDRequestFromJson(json);
  Map<String, dynamic> toJson() => _$IDRequestToJson(this);
}
