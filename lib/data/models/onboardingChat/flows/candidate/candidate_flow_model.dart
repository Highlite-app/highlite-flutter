import 'package:flutter/foundation.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/candidate/candidate_steps.dart';
import 'package:highlite_flutter_mvp/data/models/onboardingChat/flows/default_steps/default_steps.dart';


class CandidateFlowModel {
  final String firstName;
  final String lastName;
  final String position;
  final List<String> skills;
  final List<String> tools;
  final String workType;
  final String jobDuration;
  final String salary;
  final String city;
  final String country;
  final String email;
  final String username;
  final String about;

  CandidateFlowModel({
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
  });

  // Factory constructor to create an instance from a map
  factory CandidateFlowModel.fromJson(Map<String, dynamic> json) {
    return CandidateFlowModel(
      firstName: CandidateTags.firstName,
      lastName:CandidateTags.lastName,
      position: json['position'],
      skills: List<String>.from(json['skills']),
      tools: List<String>.from(json['tools']),
      workType: json['workType'],
      jobDuration: json['jobDuration'],
      salary: json['salary'],
      city: json['city'],
      country: json['country'],
      email: DefaultTags.email,
      username: DefaultTags.username,
      about: json['about'],
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toJson() {
    return {
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
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CandidateFlowModel &&
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
        other.about == about;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
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
    about.hashCode;
  }

  @override
  String toString() {
    return 'CandidateFlowModel(firstName: $firstName, lastName: $lastName, position: $position, skills: $skills, tools: $tools, workType: $workType, jobDuration: $jobDuration, salary: $salary, city: $city, country: $country, email: $email, username: $username, about: $about)';
  }
}
