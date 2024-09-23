import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/education/candidate_education.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/upload/upload_resume_repository.dart';

import '../../../../../../domain/repositories/persistent/persistent_repository.dart';
import 'education_event.dart';
import 'education_state.dart';

class EducationBloc extends Bloc<EducationEvent, EducationState> {
  EducationBloc() : super(EducationState()) {
    on<UpdateSchoolEvent>(_handleUpdateSchool);
    on<UpdateDegreeEvent>(_handleUpdateDegree);
    on<UpdateSpecializationEvent>(_handleUpdateSpecialization);
    // Handling events to set lists from API
    on<SetDegreeEvent>(_handleSetDegree);
    on<SetSpecializationsEvent>(_handleSetSpecializations);
    on<SaveEmploymentDetails>(_handleSaveEmployment)  ;
    on<UpdateCourseDurationEvent>(_handleUpdateCourseDuration) ;
  }




  Future<void> _handleUpdateSchool(
      UpdateSchoolEvent event ,
      Emitter<EducationState> emit
      )async{
    emit(state.copyWith(schoolNext:  event.isNext ,
     schoolButtonEnabled: !event.isNext
    )) ;
  }


  Future<void> _handleSaveEmployment(
      SaveEmploymentDetails event ,
      Emitter<EducationState> emit
      )  async{

    final persisted = await persistenceService.get();
    final candidateId = persisted?.id ;
    Map<String , dynamic> candidateEducation = {
      'educationId': '',
      'candidateId': authService.getUserID(),
      'school': state.schoolController.text,
      'degree': state.degree.first,
      'specialization': state.specializations.first,
      'startDate': state.startingYearController.text,
      'endDate': state.endingYearController.text,
    } ;


    uploadResumeService.candidateEducation(CandidateEducation.fromJson(candidateEducation)) ;

  }


  Future<void> _handleUpdateDegree(
      UpdateDegreeEvent event, Emitter<EducationState> emit) async {
    emit(state.copyWith(
      degreeNext: event.isNext,
      degreeButtonEnabled: !event.isNext,
    ));
  }

  Future<void> _handleUpdateSpecialization(   UpdateSpecializationEvent event ,
      Emitter<EducationState> emit ) async{
     emit(state.copyWith(specializationNext:  event.isNext ,
      specializationButtonEnabled:  !event.isNext
     )) ;
  }

  Future<void> _handleSetDegree(
      SetDegreeEvent event, Emitter<EducationState> emit) async {
    emit(state.copyWith(
      degree: event.degree,
    ));
  }

  Future<void> _handleSetSpecializations(
      SetSpecializationsEvent event, Emitter<EducationState> emit) async {
    emit(state.copyWith(
      specializations: event.specializations,
    ));
  }

  Future<void> _handleUpdateCourseDuration (
      UpdateCourseDurationEvent event ,
      Emitter<EducationState> emit
      ) async{
     if(event.courseStartingYear.isNotEmpty && event.courseEndingYear.isNotEmpty ){
       emit(state.copyWith(startingYearController: TextEditingController(text: event.courseStartingYear) ,
       endingYearController: TextEditingController(text: event.courseEndingYear) ,
         courseDurationNext: event.onNext
       )) ;
     }else if(event.courseStartingYear.isNotEmpty){
       emit(state.copyWith(startingYearController: TextEditingController(text:  event.courseStartingYear)));
     }
  }

}
