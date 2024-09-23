import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/services/injection_container.dart';
import 'comapany_upload_info_state.dart';
import 'company_about_event.dart';


final companyUploadInfoBloc   = sl.get<CompanyUploadInfoBloc>();

class CompanyUploadInfoBloc
    extends Bloc<CompanyUploadInfoEvent, CompanyUploadInfoState> {
  CompanyUploadInfoBloc() : super(CompanyUploadInfoState()) {
    on<UploadAboutStartEvent>(_handleUploadAboutStartEvent);
    on<SubmitCompanyAboutFormEvent>(_handleSubmitAboutFormEvent);
    on<LanguagesSelectionCompanyEvent>(_handleLanguageSelectionEvent);
  }

  Future<void> _handleUploadAboutStartEvent(
    UploadAboutStartEvent event,
    Emitter<CompanyUploadInfoState> emit,
  ) async {}

  Future<void> _handleSubmitAboutFormEvent(
      SubmitCompanyAboutFormEvent event,
    Emitter<CompanyUploadInfoState> emit,
  ) async {
    emit(state.copyWith(onNextAbout: true));
  }

  Future<void> _handleLanguageSelectionEvent(LanguagesSelectionCompanyEvent event,
      Emitter<CompanyUploadInfoState> emit) async {
    state.copyWith(selectedLanguages: event.selectedLanguage);
  }
}
