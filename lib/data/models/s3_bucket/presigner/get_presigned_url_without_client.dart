import 'package:json_annotation/json_annotation.dart';

part 'get_presigned_url_without_client.g.dart';

@JsonSerializable()
class GetPresignedURLWithoutClientRequest {
  final String filename;
  final String type;
  const GetPresignedURLWithoutClientRequest({
    required this.filename,
    required this.type,
  });
  factory GetPresignedURLWithoutClientRequest.fromJson(
          Map<String, dynamic> json) =>
      _$GetPresignedURLWithoutClientRequestFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetPresignedURLWithoutClientRequestToJson(this);
}
@JsonSerializable()
class FilenameRequest {
  final String filename;
  const FilenameRequest({
    required this.filename,
  });
  factory FilenameRequest.fromJson(
          Map<String, dynamic> json) =>
      _$FilenameRequestFromJson(json);
  Map<String, dynamic> toJson() =>
      _$FilenameRequestToJson(this);
}

@JsonSerializable()
class GetPresignedURLWithoutClientResponse {
  final bool status;
  final GetPresignedURLWithoutClientDataResponse data;
  const GetPresignedURLWithoutClientResponse({
    required this.status,
    required this.data,
  });
  factory GetPresignedURLWithoutClientResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetPresignedURLWithoutClientResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetPresignedURLWithoutClientResponseToJson(this);
}

@JsonSerializable()
class GetPresignedURLWithoutClientDataResponse {
  final String message;
  final String getPreSignedURL;
  const GetPresignedURLWithoutClientDataResponse({
    required this.message,
    required this.getPreSignedURL,
  });
  factory GetPresignedURLWithoutClientDataResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetPresignedURLWithoutClientDataResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetPresignedURLWithoutClientDataResponseToJson(this);
}
