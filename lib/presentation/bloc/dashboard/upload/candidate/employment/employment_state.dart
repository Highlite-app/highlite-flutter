import 'package:flutter/material.dart';

class EmploymentState {
  final bool onCurrentEmploymentNext;
  final bool isCurrentEmployedButtonEnabled;
  final bool employmentTypeNext;
  final bool employmentTypeButtonEnabled;
  final bool onJobTitleNext;
  final bool isJobTitleButtonEnabled;
  final bool onCompanyNext;
  final bool isCompanyButtonEnabled;
  final bool onTotalExperienceNext;
  final bool isTotalExperienceButtonEnabled;

  final TextEditingController currentJobTitleController;
  final TextEditingController currentCompanyController;
  final TextEditingController workedFromController;
  final TextEditingController workedTillController;
  final String employmentStatus ;
  final String employmentType ;

  final List<String> setEmploymentType;

  EmploymentState({
    this.onCurrentEmploymentNext = false,
    this.isCurrentEmployedButtonEnabled = true,
    this.employmentTypeNext = false,
    this.employmentTypeButtonEnabled = true,
    this.onJobTitleNext = false,
    this.isJobTitleButtonEnabled = true,
    this.onCompanyNext = false,
    this.isCompanyButtonEnabled = true,
    this.onTotalExperienceNext = false,
    this.isTotalExperienceButtonEnabled = true,
    TextEditingController? currentJobTitleController,
    TextEditingController? currentCompanyController,
    TextEditingController? workedFromController,
    TextEditingController? workedTillController,
    this.employmentStatus = '' ,
     this.employmentType = '',
    this.setEmploymentType = const ["Full-time", "Part-time", 'Hybrid'],
  })  : currentJobTitleController = currentJobTitleController ?? TextEditingController(),
        currentCompanyController = currentCompanyController ?? TextEditingController(),
        workedFromController = workedFromController ?? TextEditingController(),
        workedTillController = workedTillController ?? TextEditingController();

  EmploymentState copyWith({
    bool? isCurrentEmployed,
    bool? onCurrentEmploymentNext,
    bool? isCurrentEmployedButtonEnabled,
    bool? employmentTypeNext,
    bool? employmentTypeButtonEnabled,
    bool? onJobTitleNext,
    bool? isJobTitleButtonEnabled,
    bool? onCompanyNext,
    bool? isCompanyButtonEnabled,
    bool? onTotalExperienceNext,
    bool? isTotalExperienceButtonEnabled,
    TextEditingController? currentJobTitleController,
    TextEditingController? currentCompanyController,
    TextEditingController? workedFromController,
    TextEditingController? workedTillController,
    String? employmentStatus ,
    String? employmentType ,
    List<String>? setEmploymentType,
  }) {
    return EmploymentState(
      onCurrentEmploymentNext: onCurrentEmploymentNext ?? this.onCurrentEmploymentNext,
      isCurrentEmployedButtonEnabled: isCurrentEmployedButtonEnabled ?? this.isCurrentEmployedButtonEnabled,
      employmentTypeNext: employmentTypeNext ?? this.employmentTypeNext,
      employmentTypeButtonEnabled: employmentTypeButtonEnabled ?? this.employmentTypeButtonEnabled,
      onJobTitleNext: onJobTitleNext ?? this.onJobTitleNext,
      isJobTitleButtonEnabled: isJobTitleButtonEnabled ?? this.isJobTitleButtonEnabled,
      onCompanyNext: onCompanyNext ?? this.onCompanyNext,
      isCompanyButtonEnabled: isCompanyButtonEnabled ?? this.isCompanyButtonEnabled,
      onTotalExperienceNext: onTotalExperienceNext ?? this.onTotalExperienceNext,
      isTotalExperienceButtonEnabled: isTotalExperienceButtonEnabled ?? this.isTotalExperienceButtonEnabled,
      currentJobTitleController: currentJobTitleController ?? this.currentJobTitleController,
      currentCompanyController: currentCompanyController ?? this.currentCompanyController,
      workedFromController: workedFromController ?? this.workedFromController,
      workedTillController: workedTillController ?? this.workedTillController,
      employmentStatus:  employmentStatus ?? this.employmentStatus,
      employmentType:  employmentType ?? this.employmentType,
      setEmploymentType: setEmploymentType ?? this.setEmploymentType,
    );
  }
}
