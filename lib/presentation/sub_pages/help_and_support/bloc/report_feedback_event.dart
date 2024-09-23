import 'report_feedback_bloc.dart';

abstract class ReportFeedbackEvent{
  const ReportFeedbackEvent();
}

class CreateReportFeedbackEvent extends ReportFeedbackEvent{
  final String email ;
  final String content ;
  final ReportFeedbackType type ;

  CreateReportFeedbackEvent( this.email ,  this.content , this.type);

}