import 'package:json_annotation/json_annotation.dart';

part 'job_post_flow_model.g.dart';

@JsonSerializable()
class JobPostFlowModel {
  final String title;
  final String jobFlexibility;
  final String jobDuration;
  final String communication;
  final List<String> skills;
  final List<String> tools;
  final String salary;
  const JobPostFlowModel({
    required this.title,
    required this.jobFlexibility,
    required this.jobDuration,
    required this.communication,
    required this.skills,
    required this.tools,
    required this.salary,
  });
  factory JobPostFlowModel.fromJson(Map<String, dynamic> json) =>
      _$JobPostFlowModelFromJson(json);
  Map<String, dynamic> toJson() => _$JobPostFlowModelToJson(this);
}
