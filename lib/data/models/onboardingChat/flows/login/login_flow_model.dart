import 'package:json_annotation/json_annotation.dart';
part 'login_flow_model.g.dart';

@JsonSerializable()
class LoginFlowModel {
  final String? phoneNumber;
  final String? emailAddress;
  final String? firstName;
  final String? accessToken;
  final String? refreshToken;
  final String? tokenId;
  const LoginFlowModel({
    this.phoneNumber,
    this.emailAddress,
    this.firstName,
    this.accessToken,
    this.refreshToken,
    this.tokenId,
  });
  factory LoginFlowModel.fromJson(Map<String, dynamic> json) =>
      _$LoginFlowModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginFlowModelToJson(this);
}
