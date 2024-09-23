import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/company/upload_video/upload_company_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/company/upload_video/upload_company_state.dart';

class UploadCompanyBloc extends Bloc<UploadCompanyEvent , UploadCompanyState>{
  UploadCompanyBloc():super(UploadCompanyState()){
    on<PickVideoEvent>(_handlePickVideo) ;
  }

  Future<void> _handlePickVideo(PickVideoEvent event , Emitter<UploadCompanyState> emit) async{

  }
}