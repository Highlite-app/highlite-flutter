import 'package:flutter/material.dart';

class EducationState {
  final bool schoolNext;
  final bool schoolButtonEnabled;
  final bool degreeNext;
  final bool degreeButtonEnabled;
  final bool specializationNext;
  final bool specializationButtonEnabled;
  final bool courseDurationNext;
  final bool courseDurationButtonEnabled;
  final TextEditingController schoolController;
  final TextEditingController startingYearController;
  final TextEditingController endingYearController;
  final List<String> degree;
  final List<String> specializations;
  final bool isStartingYearNotEmpty;

  EducationState({
    this.schoolNext = false,
    this.schoolButtonEnabled = true,
    this.degreeNext = false,
    this.degreeButtonEnabled = true,
    this.specializationNext = false,
    this.specializationButtonEnabled = true,
    this.courseDurationNext = false,
    this.courseDurationButtonEnabled = true,
    TextEditingController? schoolController,
    TextEditingController? startingYearController,
    TextEditingController? endingYearController,
    this.degree = const ["Btech", "BE"],
    this.specializations = const ["Computer Sc", "Electronics"],
    this.isStartingYearNotEmpty = false,
  })  : schoolController = schoolController ?? TextEditingController(),
        startingYearController = startingYearController ?? TextEditingController(),
        endingYearController = endingYearController ?? TextEditingController();

  EducationState copyWith({
    bool? schoolNext,
    bool? schoolButtonEnabled,
    bool? degreeNext,
    bool? degreeButtonEnabled,
    bool? specializationNext,
    bool? specializationButtonEnabled,
    bool? courseDurationNext,
    bool? courseDurationButtonEnabled,
    TextEditingController? schoolController,
    TextEditingController? startingYearController,
    TextEditingController? endingYearController,
    List<String>? degree,
    List<String>? specializations,
    bool? isStartingYearNotEmpty,
  }) {
    return EducationState(
      schoolNext: schoolNext ?? this.schoolNext,
      schoolButtonEnabled: schoolButtonEnabled ?? this.schoolButtonEnabled,
      degreeNext: degreeNext ?? this.degreeNext,
      degreeButtonEnabled: degreeButtonEnabled ?? this.degreeButtonEnabled,
      specializationNext: specializationNext ?? this.specializationNext,
      specializationButtonEnabled: specializationButtonEnabled ?? this.specializationButtonEnabled,
      courseDurationNext: courseDurationNext ?? this.courseDurationNext,
      courseDurationButtonEnabled: courseDurationButtonEnabled ?? this.courseDurationButtonEnabled,
      schoolController: schoolController ?? this.schoolController,
      startingYearController: startingYearController ?? this.startingYearController,
      endingYearController: endingYearController ?? this.endingYearController,
      degree: degree ?? this.degree,
      specializations: specializations ?? this.specializations,
      isStartingYearNotEmpty: isStartingYearNotEmpty ?? this.isStartingYearNotEmpty,
    );
  }
}
