import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/employment/candidate_employment.dart';
import '../../../../../../domain/repositories/dashboard/candidate/upload/upload_resume_repository.dart';
import '../../../../../../domain/repositories/persistent/persistent_repository.dart';
import 'employment_event.dart';
import 'employment_state.dart';

enum EmploymentStatus{
  yes,
  no

}

const Map<EmploymentStatus , String> employmentStatusMap = {
  EmploymentStatus.yes : "Yes" ,
  EmploymentStatus.no : "No"

};

class EmploymentBloc extends Bloc<EmploymentEvent, EmploymentState> {
  EmploymentBloc() : super(EmploymentState())
  {
    on<UpdateCurrentEmploymentEvent>(_onUpdateCurrentEmploymentStatus);
    on<UpdateEmploymentTypeEvent>(_onUpdateEmploymentType) ;
    on<UpdateCurrentJobTitleEvent>(_onUpdateCurrentJobTitle);
    on<UpdateCurrentCompanyNameEvent>(_onUpdateCurrentCompanyName);
     on<UpdateTotalExperienceEvent>(_onUpdateTotalExperience);
    //Get from API
    on<SetEmploymentType>(_handleSetEmploymentType) ;
    on<SaveEmploymentDetails>(_handleSaveEmployment) ;

  }










  void _onUpdateCurrentEmploymentStatus(UpdateCurrentEmploymentEvent event, Emitter<EmploymentState> emit) {

    emit(state.copyWith(employmentStatus: event.employmentStatus)) ;
    debugPrint('The employmentStatus is :: ${state.employmentStatus}');
    if(event.onNext){
      if(state.employmentStatus == 'Yes'){
         debugPrint("Called");
        emit(state.copyWith(onCurrentEmploymentNext: event.onNext,
        isCurrentEmployedButtonEnabled: !event.onNext
        )) ;
      }else {
        event.onUnemployed?.call() ;
      }
    }


  }

  Future<void> _handleSaveEmployment(
      SaveEmploymentDetails event ,
      Emitter<EmploymentState> emit ,
      ) async{
    final persisted = await persistenceService.get();
    final candidateId = persisted?.id ;
    Map<String , dynamic> employment = {
      'employmentId': "employmentId",
      'candidateId': candidateId,
      'employmentStatus': state.employmentStatus,
      'employmentType': state.employmentType,
      'employmentTitle': state.currentJobTitleController.text,
      'companyName': state.currentCompanyController.text,
      'startDate': state.workedFromController.text,
      'endDate': state.workedTillController.text,
    };

    uploadResumeService.candidateEmployment(CandidateEmployment.fromJson(employment)) ;
  }

  Future<void> _onUpdateEmploymentType(UpdateEmploymentTypeEvent event ,
  Emitter<EmploymentState> emit) async{
     emit(state.copyWith(employmentType: event.employmentType));
     if(event.onNext){
       emit(state.copyWith(employmentTypeNext: event.onNext ,
       employmentTypeButtonEnabled: !event.onNext
       ));
     }

  }



  void _onUpdateCurrentJobTitle(UpdateCurrentJobTitleEvent event, Emitter<EmploymentState> emit) {
    emit(state.copyWith(currentJobTitleController: TextEditingController(text: event.jobTitle) ,
        onJobTitleNext: event.onNext , isJobTitleButtonEnabled: !event.onNext ));
  }

  void _onUpdateCurrentCompanyName(UpdateCurrentCompanyNameEvent event , Emitter<EmploymentState> emit) {
    emit(state.copyWith(currentCompanyController: TextEditingController(
        text: event.companyName),
        onCompanyNext: event.onNext,
        isCompanyButtonEnabled : !event.onNext
    ));
  }


    void _onUpdateTotalExperience(UpdateTotalExperienceEvent event , Emitter<EmploymentState> emit) {



      if(event.startDate.isNotEmpty && event.endDate.isNotEmpty){
        emit(state.copyWith(
            onTotalExperienceNext: event.onNext,
            workedTillController: TextEditingController(text: event.endDate),
            workedFromController: TextEditingController(text: event.startDate),
            isTotalExperienceButtonEnabled: !event.onNext
        ));
      }else if(event.startDate.isNotEmpty){
        emit(state.copyWith(workedFromController: TextEditingController(text:event.startDate)) );
      }

    }
      void _handleSetEmploymentType(SetEmploymentType event , Emitter<EmploymentState> emit){

      }


  }



