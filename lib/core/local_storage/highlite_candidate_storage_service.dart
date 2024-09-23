import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/constants/injection_constant.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/logger.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../services/injection_container.dart';

const String candidateBox = "candidate";
const String profilePhoto = "profilePhoto";

final hiveStorage = sl.get<ICandidateOnBoardingStorage>(
    instanceName: InjectionConstant.CandidateOnBoardingStorage);

abstract class ICandidateOnBoardingStorage {
  Future<CandidateOnBoarding?> getCandidateFromStorage();
  Future<void> setCandidateToStorage(CandidateOnBoarding candidate);
  Future<void> removeCandidateFromStorage();
  Future<void> setProfileImage(String profileUrl);
  Future<String> getImageProfile();
}

class HighliteStorage implements ICandidateOnBoardingStorage {
  @override
  Future<CandidateOnBoarding?> getCandidateFromStorage() async {
    final box = Hive.lazyBox<CandidateOnBoarding>(candidateBox);
    final candidateJson = await box.get(candidateBox);
    if (candidateJson != null) {
      try {
        debugPrint("The data inside candidateJson is $candidateJson");
        return candidateJson;
      } catch (e) {
        throw Exception("Data is not stored $e");
      }
    }
    throw Exception(
        "CandidateJson In Hive Database is Empty . Please use setCandidateToStorage()");
  }

  @override
  Future<String> getImageProfile() async {
    final box =  Hive.lazyBox<String>(profilePhoto);
    final profileUrl = await box.get(profilePhoto);
    if (profileUrl != null) {

      try {
        logger.logEvent("The profile Url is : $profileUrl") ;
        return profileUrl ;
      } catch (e) {
        return "";
      }
    } else {
      throw Exception("Image is Null");
    }
  }

  @override
  Future<void> removeCandidateFromStorage() async {
    final box = Hive.lazyBox<CandidateOnBoarding>(candidateBox);
    await box.clear();
  }

  @override
  Future<void> setCandidateToStorage(CandidateOnBoarding candidate) async {
    debugPrint("The data stored inside Hive Database  ::: ${candidate}");
    final box = Hive.lazyBox<CandidateOnBoarding>(candidateBox);
    await box.put(candidateBox, candidate);
  }


  @override
  Future<void> setProfileImage(String profileUrl) async {
    final box = await Hive.openBox(profilePhoto);
    box.put(profilePhoto, profilePhoto);
  }
}
