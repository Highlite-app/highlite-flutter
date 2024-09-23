// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlite_report_feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HighliteReportFeedback _$HighliteReportFeedbackFromJson(
        Map<String, dynamic> json) =>
    HighliteReportFeedback(
      id: json['id'] as String,
      email: json['email'] as String,
      content: json['content'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$HighliteReportFeedbackToJson(
        HighliteReportFeedback instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'content': instance.content,
      'type': instance.type,
    };
