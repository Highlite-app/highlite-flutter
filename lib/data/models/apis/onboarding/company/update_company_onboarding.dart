import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';

class UpdateCompanyOnboarding {
  String? message;
  CompanyOnboarding? company;

  UpdateCompanyOnboarding({this.message, this.company});

  UpdateCompanyOnboarding.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    company =
        json['company'] != null ? CompanyOnboarding.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}


