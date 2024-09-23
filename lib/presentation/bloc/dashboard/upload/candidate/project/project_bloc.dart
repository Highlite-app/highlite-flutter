import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/project/candidate_project.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/project/project_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/project/project_state.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/toast/toast_bloc.dart';

import '../../../../../../app.dart';
import '../../../../../../core/resources/asset_constants.dart';
import '../../../../../../domain/repositories/dashboard/candidate/upload/upload_resume_repository.dart';
import '../../../../../../domain/repositories/persistent/persistent_repository.dart';
import '../../../../../pages/dashboard/candidate_dashboard.dart';
import '../../../../../widgets/toaster/toast_alert.dart';
import '../../../../toast/toast_event.dart';

class UploadProjectBloc extends Bloc<UploadProjectEvent, UploadProjectState> {
  UploadProjectBloc()
      : super(UploadProjectState()) {
    on<InitializeForm>(_handleInitializeForm);
    on<DisposeForm>(_handleDisposeForm);
    on<ProjectTitleChanged>(_handleProjectTitleChanged);
    on<ClientDetailsChanged>(_handleClientDetailsChanged);
    on<SubmitProjectStatusEvent>(_handleOnSubmitProjectStatus);
    on<AddMorDetailsEvent>(_handleAddMoreDetails);
    on<SaveProjectEvent>(_handleSaveProject);


  }

  void _handleInitializeForm(InitializeForm event, Emitter<UploadProjectState> emit) {
    // Initialize form if needed
  }

  void _handleDisposeForm(DisposeForm event, Emitter<UploadProjectState> emit) {
    state.projectTitleController.dispose();
    state.clientDetailsController.dispose();
    state.projectDetailsController.dispose();
    state.startDateController.dispose();
    state.endDateController.dispose();
    state.sizeOfTeamController.dispose();
    state.roleInProjectController.dispose();
    state.roleDescriptionController.dispose();
    state.skillController.dispose();
  }

  void _handleOnSubmitProjectStatus (SubmitProjectStatusEvent event  ,  Emitter<UploadProjectState> emit){
    String projectStatus = event.projectStatus ;
    if(projectStatus == "Finished") {
      emit(state.copyWith(projectStatus: projectStatus)) ;
    }else {
      emit(state.copyWith(projectStatus: ''));
    }
  }

  void _handleProjectTitleChanged(ProjectTitleChanged event, Emitter<UploadProjectState> emit) {
    state.projectTitleController.text = event.title;
    emit(state.copyWith(projectTitleController: state.projectTitleController));
  }

  void _handleClientDetailsChanged(ClientDetailsChanged event, Emitter<UploadProjectState> emit) {
    state.clientDetailsController.text = event.clientDetails;
    emit(state.copyWith(clientDetailsController: state.clientDetailsController));
  }

  void _handleAddMoreDetails(AddMorDetailsEvent event , Emitter<UploadProjectState> emit) async{
  emit(state.copyWith(showMoreDetails: true))  ;
  }

  void _handleSaveProject(SaveProjectEvent  event , Emitter<UploadProjectState> emit) async{

    final persisted = await persistenceService.get();
    final candidateId = persisted?.id ;
    Map<String , dynamic> project  = {
      'projectId': "",
      'candidateId': authService.getUserID(),
      'projectTitle': state.projectTitleController.text,
      'projectClient': state.clientDetailsController.text,
      'projectStatus': state.projectStatus,
      'projectStart': state.startDateController.text,
      'projectFinish': state.endDateController.text,
      'projectDetails': state.projectDetailsController.text,
      'projectSkills': state.skillController.text.replaceAll('(', '').replaceAll(')', '').split(','),
      'projectTools': state.toolController.text.replaceAll('(', '').replaceAll(')', '').split(','),
    };
    
    
   try{
     uploadResumeService.candidateProject(CandidateProject.fromJson(project)) ;

     toaster.add(
       const ShowToastEvent(
         text: "Your resume has been upload successfully",
         icon: AssetConstant.checkCircleIcon,
         state: ToastState.normal,
         duration: Duration(seconds: 2),
       ),
     );

     Future.delayed(const Duration(seconds: 2), () {
       globalNavKey.currentState?.push(MaterialPageRoute(builder:(_)=> const CandidateDashboard())) ;
     });

     globalNavKey.currentState?.pop() ;

   }catch(e){
     
   }
    uploadResumeService.candidateProject(CandidateProject.fromJson(project)) ;
  }


// Define other event handlers similarly...
}
