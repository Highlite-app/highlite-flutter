import 'package:json_annotation/json_annotation.dart';

part 'company_flow_model.g.dart';

@JsonSerializable()
class CompanyFlowModel {
  final String organization;
  final String jobIndustry;
  final String companyWebsite;
  final String city;
  final String country;
  final String jobTitle;
  final String about;
  final String username;
  final String createdAt;
  final String updatedAt;
  const CompanyFlowModel({
    required this.city,
    required this.country,
    required this.jobTitle,
    required this.companyWebsite,
    required this.organization,
    required this.about,
    required this.username,
    required this.jobIndustry,
    required this.createdAt,
    required this.updatedAt,
  });
  factory CompanyFlowModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyFlowModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyFlowModelToJson(this);
}
