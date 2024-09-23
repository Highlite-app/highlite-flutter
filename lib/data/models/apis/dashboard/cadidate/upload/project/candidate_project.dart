import 'package:flutter/foundation.dart';

class CandidateProject {
  final String projectId;
  final String candidateId;
  final String projectTitle;
  final String projectClient;
  final String projectStatus;
  final String projectStart;
  final String projectFinish;
  final String projectDetails;
  final List<String> projectSkills;
  final List<String> projectTools;

  CandidateProject({
    required this.projectId,
    required this.candidateId,
    required this.projectTitle,
    required this.projectClient,
    required this.projectStatus,
    required this.projectStart,
    required this.projectFinish,
    required this.projectDetails,
    required this.projectSkills,
    required this.projectTools,
  });

  // Factory constructor to create an instance from a map
  factory CandidateProject.fromJson(Map<String, dynamic> json) {
    return CandidateProject(
      projectId: json['projectId'],
      candidateId: json['candidateId'],
      projectTitle: json['projectTitle'],
      projectClient: json['projectClient'],
      projectStatus: json['projectStatus'],
      projectStart: json['projectStart'],
      projectFinish: json['projectFinish'],
      projectDetails: json['projectDetails'],
      projectSkills: List<String>.from(json['projectSkills']),
      projectTools: List<String>.from(json['projectTools']),
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'candidateId': candidateId,
      'projectTitle': projectTitle,
      'projectClient': projectClient,
      'projectStatus': projectStatus,
      'projectStart': projectStart,
      'projectFinish': projectFinish,
      'projectDetails': projectDetails,
      'projectSkills': projectSkills,
      'projectTools': projectTools,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CandidateProject &&
        other.projectId == projectId &&
        other.candidateId == candidateId &&
        other.projectTitle == projectTitle &&
        other.projectClient == projectClient &&
        other.projectStatus == projectStatus &&
        other.projectStart == projectStart &&
        other.projectFinish == projectFinish &&
        other.projectDetails == projectDetails &&
        listEquals(other.projectSkills, projectSkills) &&
        listEquals(other.projectTools, projectTools);
  }

  @override
  int get hashCode {
    return projectId.hashCode ^
    candidateId.hashCode ^
    projectTitle.hashCode ^
    projectClient.hashCode ^
    projectStatus.hashCode ^
    projectStart.hashCode ^
    projectFinish.hashCode ^
    projectDetails.hashCode ^
    projectSkills.hashCode ^
    projectTools.hashCode;
  }

  @override
  String toString() {
    return 'CandidateProject(projectId: $projectId, candidateId: $candidateId, projectTitle: $projectTitle, projectClient: $projectClient, projectStatus: $projectStatus, projectStart: $projectStart, projectFinish: $projectFinish, projectDetails: $projectDetails, projectSkills: $projectSkills, projectTools: $projectTools)';
  }
  static List<CandidateProject> dummyProjects() {
    return [
      CandidateProject(
        projectId: '1',
        candidateId: '101',
        projectTitle: 'E-commerce App Development',
        projectClient: 'ABC Corp',
        projectStatus: 'Completed',
        projectStart: '2022-01-01',
        projectFinish: '2022-06-01',
        projectDetails: 'Developed a full-featured e-commerce application for Android and iOS.',
        projectSkills: ['Flutter', 'Firebase', 'REST API'],
        projectTools: ['VS Code', 'Postman'],
      ),
      CandidateProject(
        projectId: '2',
        candidateId: '102',
        projectTitle: 'Machine Learning Model',
        projectClient: 'XYZ Ltd',
        projectStatus: 'In Progress',
        projectStart: '2023-03-01',
        projectFinish: '2023-08-01',
        projectDetails: 'Developing a machine learning model for predicting stock prices.',
        projectSkills: ['Python', 'TensorFlow', 'Pandas'],
        projectTools: ['Jupyter Notebook', 'Git'],
      ),
      CandidateProject(
        projectId: '3',
        candidateId: '103',
        projectTitle: 'Website Redesign',
        projectClient: 'Tech Solutions',
        projectStatus: 'Completed',
        projectStart: '2021-05-01',
        projectFinish: '2021-10-01',
        projectDetails: 'Redesigned the company website to improve user experience and SEO.',
        projectSkills: ['HTML', 'CSS', 'JavaScript'],
        projectTools: ['Adobe XD', 'Chrome DevTools'],
      ),
    ];
  }
}

