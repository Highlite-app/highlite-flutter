import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/sub_pages/help_and_support/bloc/report_feedback_event.dart';
import 'package:highlite_flutter_mvp/presentation/sub_pages/help_and_support/bloc/report_feedback_state.dart';


enum ReportFeedbackType{ problem , feedback}

class ReportFeedbackBloc extends Bloc<ReportFeedbackEvent , ReportFeedbackState>{
  ReportFeedbackBloc():super(const ReportFeedbackState()){
    on<ReportFeedbackEvent>(_handleReportFeedback);
  }

  Future<void> _handleReportFeedback(
    ReportFeedbackEvent event ,
    Emitter<ReportFeedbackState> emit)async{


  }
}