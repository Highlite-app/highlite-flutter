import 'package:json_annotation/json_annotation.dart';

part 'signin_api.g.dart';

class SignupParams {
  static String responseParams = """
        id
        message
        tokenId
        accessToken
        refreshToken
        userType
        isLoggedIn
  """;
}

class SigninParams {
  static String responseParams = """
        id
        message
        tokenId
        accessToken
        refreshToken
        userType
  """;
}

@JsonSerializable()
class SigninRequest {
  final String signInOption;
  final String sendTo;
  final String otp;
  const SigninRequest({
    required this.signInOption,
    required this.sendTo,
    required this.otp,
  });
  factory SigninRequest.fromJson(Map<String, dynamic> json) =>
      _$SigninRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SigninRequestToJson(this);
}

@JsonSerializable()
class SigninResponse {
  final bool status;
  final SigninTokensResponse data;
  const SigninResponse({required this.status, required this.data});
  factory SigninResponse.fromJson(Map<String, dynamic> json) =>
      _$SigninResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SigninResponseToJson(this);
}

@JsonSerializable()
class SigninTokensResponse {
  final String? id;
  final String message;
  final String? accessToken;
  final String? tokenId;
  final String? refreshToken;
  final String? userType;
  final bool? isLoggedIn;

  const SigninTokensResponse({
    this.id,
    required this.message,
    this.accessToken,
    this.tokenId,
    this.refreshToken,
    this.userType,
    this.isLoggedIn,
  });
  factory SigninTokensResponse.fromJson(Map<String, dynamic> json) =>
      _$SigninTokensResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SigninTokensResponseToJson(this);
}
