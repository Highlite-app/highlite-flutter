import 'package:flutter/material.dart';

abstract class EducationEvent {}

  class UpdateSchoolEvent extends EducationEvent{
  final bool isNext ;
  UpdateSchoolEvent(this.isNext) ;
  }

class UpdateDegreeEvent extends EducationEvent {
  final bool isNext;

  UpdateDegreeEvent(this.isNext);
}

class UpdateSpecializationEvent extends EducationEvent {
  final bool isNext;

  UpdateSpecializationEvent(this.isNext);
}


// Events for updating lists from API
class SetDegreeEvent extends EducationEvent {
  final List<String> degree;

  SetDegreeEvent(this.degree);
}


class SetSpecializationsEvent extends EducationEvent {
  final List<String> specializations;

  SetSpecializationsEvent(this.specializations);
}



  class UpdateCourseDurationEvent extends EducationEvent{
  final String  courseStartingYear ;
  final String courseEndingYear ;
  final bool onNext ;

  UpdateCourseDurationEvent({required this.courseStartingYear , required this.courseEndingYear ,required  this.onNext}) ;
}

class SaveEmploymentDetails extends EducationEvent{
  SaveEmploymentDetails() ;
}


