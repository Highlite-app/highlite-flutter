import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/company/company_steps.dart';

class CompanyFlowModel {
  final String companyName;
  final String industry;
  final String city;
  final String country;
  final String website;
  final String companySize;
  final List<String> benefits;
  final String about;
  final String email;
  final String userName;
  final String companyLogo;

  CompanyFlowModel({
    required this.companyName,
    required this.industry,
    required this.city,
    required this.country,
    required this.website,
    required this.companySize,
    required this.benefits,
    required this.about,
    required this.email,
    required this.userName,
    required this.companyLogo,
  });

  // fromJson method to deserialize JSON data into CompanyFlowModel
  factory CompanyFlowModel.fromJson(Map<String, dynamic> json) {

    final benefits =  json['benefits'] as  List<dynamic>?   ??  [] ;

    return CompanyFlowModel(
      companyName: json['companyName'] ?? '',
      industry: json['industry'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      website: json['website'] ?? '',
      companySize: json['companySize'] ?? '',
      benefits: benefits.isNotEmpty ? benefits.map((benefit) => benefit as String).toList() : [] ,
      about: json['about'] ?? '',
      email: CompanyTags.email,
      userName: CompanyTags.userName,
      companyLogo: json['companyLogo'] ?? '',
    );
  }

  // toJson method to serialize CompanyFlowModel to JSON data
  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'industry': industry,
      'city': city,
      'country': country,
      'website': website,
      'companySize': companySize,
      'benefits': benefits,
      'about': about,
      'email': email,
      'userName': userName,
      'companyLogo': companyLogo,
    };
  }
}
