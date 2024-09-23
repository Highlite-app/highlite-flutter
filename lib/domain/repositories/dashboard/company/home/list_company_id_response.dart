import 'package:json_annotation/json_annotation.dart';
part 'list_company_id_response.g.dart';

@JsonSerializable()
class CompanyIDResponse {
  final String companyId;
  const CompanyIDResponse({required this.companyId});
  factory CompanyIDResponse.fromJson(Map<String, dynamic> json) =>
      _$CompanyIDResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyIDResponseToJson(this);
}

@JsonSerializable()
class ListCompanyIDResponse {
  final String? nextToken;
  final List<CompanyIDResponse> items;
  const ListCompanyIDResponse({
    this.nextToken,
    required this.items,
  });
  factory ListCompanyIDResponse.fromJson(Map<String, dynamic> json) =>
      _$ListCompanyIDResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListCompanyIDResponseToJson(this);
}
