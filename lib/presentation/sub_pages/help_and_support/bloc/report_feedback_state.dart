import '../../../../data/models/help_support/highlite_report_feedback.dart';

class ReportFeedbackState{
  final List<HighliteReportFeedback> reportFeedback ;
  const ReportFeedbackState({
    this.reportFeedback = const []
});

  ReportFeedbackState copyWith({
    List<HighliteReportFeedback>? reportFeedback ,

    })=> ReportFeedbackState(reportFeedback:reportFeedback ?? this.reportFeedback );
}