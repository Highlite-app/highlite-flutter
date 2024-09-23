import 'package:json_annotation/json_annotation.dart';
part 'highlite_report_feedback.g.dart';

@JsonSerializable()
class HighliteReportFeedback{
  final String id ;
  final String email ;
  final String content ;
  final String type ;

  HighliteReportFeedback({
   required this.id ,
   required this.email ,
   required this.content ,
   required this.type ,
});

  factory HighliteReportFeedback.fromJson(Map<String , dynamic> json)=> _$HighliteReportFeedbackFromJson(json);

   Map<String,dynamic> toJson() => _$HighliteReportFeedbackToJson(this) ;

}