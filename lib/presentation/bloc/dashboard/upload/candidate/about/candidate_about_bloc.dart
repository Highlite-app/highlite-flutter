import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/about%20/about_candidate.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/upload/upload_resume_repository.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/about/candidate_about_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/about/candidate_about_state.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../domain/repositories/persistent/persistent_repository.dart';

class CandidateUploadAboutBloc extends Bloc<CandidateUploadAboutEvent, CandidateUploadAboutState> {
  CandidateUploadAboutBloc() : super(CandidateUploadAboutState()) {
    on<UploadAboutStartEvent>(_handleUploadAboutStartEvent);
    on<SubmitAboutFormEvent>(_handleSubmitAboutFormEvent);
    on<LanguagesSelectionEvent>(_handleLanguageSelectionEvent);
    on<SubmitEvent>(_handleSubmitEvent) ;
  }

  Future<void> _handleUploadAboutStartEvent(
    CandidateUploadAboutEvent event,
    Emitter<CandidateUploadAboutState> emit,
  ) async {}

  Future<void> _handleSubmitAboutFormEvent(
    SubmitAboutFormEvent event,
    Emitter<CandidateUploadAboutState> emit,
  ) async {
    emit(state.copyWith(onNextAbout: true));

  }

  Future<void> _handleLanguageSelectionEvent(
      LanguagesSelectionEvent event, Emitter<CandidateUploadAboutState> emit) async {
    emit(state.copyWith(selectedLanguages: event.selectedLanguage));
  }

  Future<void> _handleSubmitEvent(
      SubmitEvent event , Emitter<CandidateUploadAboutState> emit
      ) async {

    final persisted = await persistenceService.get();
    final candidateId = persisted?.id ;
    String uuid = const  Uuid().toString() ;
      Map<String , dynamic> json  = {
       'aboutId':  uuid,
        'candidateId':authService.getUserID() ,
        'aboutCandidate': state.aboutController.text ,
        'languages': state.selectedLanguages
      } ;

      uploadResumeService.aboutCandidate(AboutCandidate.fromJson(json)) ;

      debugPrint("Api Called") ;
  }
}
