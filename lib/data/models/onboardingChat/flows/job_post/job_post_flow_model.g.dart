// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_post_flow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobPostFlowModel _$JobPostFlowModelFromJson(Map<String, dynamic> json) =>
    JobPostFlowModel(
      title: json['title'] as String,
      jobFlexibility: json['jobFlexibility'] as String,
      jobDuration: json['jobDuration'] as String,
      communication: json['communication'] as String,
      skills:
          (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      tools: (json['tools'] as List<dynamic>).map((e) => e as String).toList(),
      salary: json['salary'] as String,
    );

Map<String, dynamic> _$JobPostFlowModelToJson(JobPostFlowModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'jobFlexibility': instance.jobFlexibility,
      'jobDuration': instance.jobDuration,
      'communication': instance.communication,
      'skills': instance.skills,
      'tools': instance.tools,
      'salary': instance.salary,
    };
