import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';

class CompanyOnboarding {
  final String companyId;
  final String companyName;
  final String industry;
  final String city;
  final String country ;
  final String website;
  final String companySize;
  final List<String> benefits;
  final String about;
  final String email;
  final String userName;
  final String companyLogo;

  CompanyOnboarding({
    required this.companyId,
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

  factory CompanyOnboarding.fromJson(Map<String, dynamic> json) {
    return CompanyOnboarding(
        companyId: json['companyId'],
        companyName: json['companyName'],
        industry: json['industry'],
        city: json['city'],
        country: json['country'],
        website: json['website'],
        companySize: json['companySize'],
        benefits: (json['benefits'] as List).isNullOrEmpty ? []:(json['benefits'] as List).map((e) => e as String).toList(),
        about: json['about'],
        email: json['email'],
        userName: json['userName'],
        companyLogo: json['companyLogo']);
  }

  static CompanyOnboarding defaultOnboarding() {
    return CompanyOnboarding(
      companyId: '0',
      companyName: 'Unknown Company',
      industry: 'Unknown Industry',
      city: 'Unknown City',
      country: 'Unknown Country',
      website: 'Unknown Website',
      companySize: 'Unknown Size',
      benefits: ['Unknown Benefits'],
      about: 'No Information Available',
      email: 'unknown@example.com',
      userName: 'unknown_user',
      companyLogo:
          'https://firebasestorage.googleapis.com/v0/b/highlite-app.appspot.com/o/profile_images%2F1722284841986?alt=media&token=eb375275-67a1-446b-af2b-7dee5ede5458',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyId': companyId,
      'companyName': companyName,
      'industry': industry,
      'city': city,
      'country':country ,
      'website': website,
      'companySize': companySize,
      'benefits': benefits,
      'about': about,
      'email': email,
      'userName': userName,
    };
  }

  CompanyOnboarding copyWith(
      {String? companyId,
      String? companyName,
      String? industry,
      String? city,
        String? country ,
      String? website,
      String? companySize,
      List<String>? benefits,
      String? about,
      String? email,
      String? userName,
      String? companyLogo}) {
    return CompanyOnboarding(
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      industry: industry ?? this.industry,
      city: city ?? this.city,
      country: country ?? this.country,
      website: website ?? this.website,
      companySize: companySize ?? this.companySize,
      benefits: benefits ?? this.benefits,
      about: about ?? this.about,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      companyLogo: companyLogo ?? this.companyLogo,
    );
  }

  String get location => "$city, $country";
}
