
import 'package:json_annotation/json_annotation.dart';

part 'next_token_request.g.dart';

@JsonSerializable()
class NextTokenRequest {
  final String? nextToken;
  const NextTokenRequest({
    this.nextToken,
  });
  factory NextTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$NextTokenRequestFromJson(json);
  Map<String, dynamic> toJson() => _$NextTokenRequestToJson(this);
}

@JsonSerializable()
class NextTokenResponse {
  final String? nextToken;
  const NextTokenResponse({
    this.nextToken,
  });
  factory NextTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$NextTokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NextTokenResponseToJson(this);
}
