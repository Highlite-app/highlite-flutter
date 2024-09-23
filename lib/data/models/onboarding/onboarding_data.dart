

import 'dart:io';

import 'package:flutter/material.dart';

enum UserType {
  company,
  applicant;
}

class OnboardingData {
  String? accessToken;
  bool? existingSocialSignin;
  bool? isFromSocialSignin;

  UserType? userType;
  String? firstName;
  String? lastName;

  String? organization;
  String? workType;
  String? verificationId;

  String? countryCode;
  String? countryCodeNumber;
  String? phoneNumber;
  String? maskedPhone;
  String? otp;
  String? emailAddress;
  String? language;
  String? location;
  String? city;
  String? country;
  String? jobLocation;
  String? jobType;
  String? communication;
  String? salary;
  List<String>? skills;

  String? loginStep;
  String? login;
  String? loginResponse;
  FileImage? fileImage;
  File? videoFile;
  String? profilePicture;
  String? videoPath;
  String? videoFileName;

  String? userId;
  String? assetId;
  String? playbackId;
  String? aboutMe;

}