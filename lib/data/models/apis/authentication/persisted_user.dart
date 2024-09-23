
import 'package:json_annotation/json_annotation.dart';

part 'persisted_user.g.dart';

@JsonSerializable()
class PersistedUser {
  final bool isLoggedIn;
  final String tokenId;
  final String accessToken;
  final String refreshToken;
  final String id;
  final String userType;
  final String? companyId;
  PersistedUser({
    required this.isLoggedIn,
    required this.tokenId,
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.userType,
    this.companyId,
  });

  factory PersistedUser.fromJson(Map<String, dynamic> json) =>
      _$PersistedUserFromJson(json);
  Map<String, dynamic> toJson() => _$PersistedUserToJson(this);
}
