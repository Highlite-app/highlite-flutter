import 'package:flutter/foundation.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/candidate_flow_model.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/general/general_flow_model.dart';

class CandidateOnBoarding {
  final String? candidateId;
  final String? firstName;
  final String? lastName;
  final String? position;
  final List<String>? skills;
  final List<String>? tools;
  final String? workType;
  final String? jobDuration;
  final String? salary;
  final String? city;
  final String? country;
  final String? email;
  final String? username;
  final String? about;
  final String? profilePicture;

  CandidateOnBoarding({
    required this.candidateId,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.skills,
    required this.tools,
    required this.workType,
    required this.jobDuration,
    required this.salary,
    required this.city,
    required this.country,
    required this.email,
    required this.username,
    required this.about,
    required this.profilePicture,
  });

  // Factory constructor to create an instance from a map
  factory CandidateOnBoarding.fromJson(Map<String, dynamic> json) {
    return CandidateOnBoarding(
      candidateId: json['candidateId'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      position: json['position'] ?? '',
      skills: (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      tools: (json['tools'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      workType: json['workType'] ?? '',
      jobDuration: json['jobDuration'] ?? '',
      salary: json['salary'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      about: json['about'] ?? '',
      profilePicture: json['profilePicture'] ?? '',

    );
  }

  static CandidateOnBoarding defaultOnboarding() {
    return CandidateOnBoarding(
      candidateId: '',
      firstName: '',
      lastName: '',
      position: '',
      skills: [],
      tools: [],
      workType: '',
      jobDuration: '',
      salary: '',
      city: '',
      country: '',
      email: '',
      username: '',
      about: '',
      profilePicture: '',
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toJson() {
    return {
      'candidateId': candidateId,
      'firstName': firstName,
      'lastName': lastName,
      'position': position,
      'skills': skills,
      'tools': tools,
      'workType': workType,
      'jobDuration': jobDuration,
      'salary': salary,
      'city': city,
      'country': country,
      'email': email,
      'username': username,
      'about': about,
      'profilePicture': profilePicture,
    };
  }

  static CandidateOnBoarding fromOnboarding(GeneralFlowModel generalSection, CandidateFlowModel candidateModel) {
    return CandidateOnBoarding(
      candidateId: '',
      firstName: candidateModel.firstName,
      lastName: candidateModel.lastName,
      position: candidateModel.position,
      skills: candidateModel.skills,
      tools: candidateModel.tools,
      workType: candidateModel.workType,
      jobDuration: candidateModel.jobDuration,
      salary: candidateModel.salary,
      city: candidateModel.city,
      country: candidateModel.country,
      email: candidateModel.email,
      username: candidateModel.username,
      about: candidateModel.about,
      profilePicture: '',
    );
  }

  CandidateOnBoarding copyWith({
    String? candidateId,
    String? firstName,
    String? lastName,
    String? position,
    List<String>? skills,
    List<String>? tools,
    String? workType,
    String? jobDuration,
    String? salary,
    String? city,
    String? country,
    String? email,
    String? username,
    String? about,
    String? profilePicture,
  }) {
    return CandidateOnBoarding(
      candidateId: candidateId ?? this.candidateId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      position: position ?? this.position,
      skills: skills ?? this.skills,
      tools: tools ?? this.tools,
      workType: workType ?? this.workType,
      jobDuration: jobDuration ?? this.jobDuration,
      salary: salary ?? this.salary,
      city: city ?? this.city,
      country: country ?? this.country,
      email: email ?? this.email,
      username: username ?? this.username,
      about: about ?? this.about,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CandidateOnBoarding &&
        other.candidateId == candidateId &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.position == position &&
        listEquals(other.skills, skills) &&
        listEquals(other.tools, tools) &&
        other.workType == workType &&
        other.jobDuration == jobDuration &&
        other.salary == salary &&
        other.city == city &&
        other.country == country &&
        other.email == email &&
        other.username == username &&
        other.about == about &&
        other.profilePicture == profilePicture;
  }

  String get fullName => "$firstName $lastName";
  String get location => "$city, $country";

  @override
  int get hashCode {
    return candidateId.hashCode ^
    firstName.hashCode ^
    lastName.hashCode ^
    position.hashCode ^
    skills.hashCode ^
    tools.hashCode ^
    workType.hashCode ^
    jobDuration.hashCode ^
    salary.hashCode ^
    city.hashCode ^
    country.hashCode ^
    email.hashCode ^
    username.hashCode ^
    about.hashCode ^
    profilePicture.hashCode;
  }

  @override
  String toString() {
    return 'CandidateOnBoarding(candidateId: $candidateId, firstName: $firstName, lastName: $lastName, position: $position, skills: $skills, tools: $tools, workType: $workType, jobDuration: $jobDuration, salary: $salary, city: $city, country: $country, email: $email, username: $username, about: $about, profilePicture: $profilePicture)';
  }
}
