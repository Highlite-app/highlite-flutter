class CompanyJobPost {
  final String jobPostId;
  final String companyId;
  final String jobVideoFeedId;
  final String jobDescription;
  final String location;
  final String position;
  final List<String> skills;
  final List<String> tools;
  final String workType;
  final String jobDuration;
  final String salary;
  final String status;

  CompanyJobPost({
    required this.jobPostId,
    required this.companyId,
    required this.jobVideoFeedId,
    required this.jobDescription,
    required this.location,
    required this.position,
    required this.skills,
    required this.tools,
    required this.workType,
    required this.jobDuration,
    required this.salary,
    required this.status,
  });

  factory CompanyJobPost.fromJson(Map<String, dynamic> json) {
    return CompanyJobPost(
      jobPostId: json['jobPostId'],
      companyId: json['companyId'],
      jobVideoFeedId: json['jobVideoFeedId'],
      jobDescription: json['jobDescription'],
      location: json['location'],
      position: json['position'],
      skills: List<String>.from(json['skills']),
      tools: List<String>.from(json['tools']),
      workType: json['workType'],
      jobDuration: json['jobDuration'],
      salary: json['salary'],
      status: json['status'],
    );
  }

  static CompanyJobPost getDefault()=> CompanyJobPost(
    jobPostId: '',
    companyId:'',
    jobVideoFeedId: '',
    jobDescription: 'json[''',
    location:'json[''',
    position:'json[''',
    skills:[],
    tools:[],
    workType: "json['workType']",
    jobDuration:" json['jobDuration']",
    salary:" json['salary']",
    status: "json['status']",
  );

  Map<String, dynamic> toJson() {
    return {
      'jobId': jobPostId,
      'companyId': companyId,
      'jobVideoFeedID': jobVideoFeedId,
      'jobDescription': jobDescription,
      'location': location,
      'position': position,
      'skills': skills,
      'tools': tools,
      'workType': workType,
      'jobDuration': jobDuration,
      'salary': salary,
      'status': status,
    };
  }

  CompanyJobPost copyWith({
    String? jobId,
    String? companyId,
    String? jobVideoFeedID,
    String? jobDescription,
    String? location,
    String? position,
    List<String>? skills,
    List<String>? tools,
    String? workType,
    String? jobDuration,
    String? salary,
    String? status,
  }) {
    return CompanyJobPost(
      jobPostId: jobId ?? this.jobPostId,
      companyId: companyId ?? this.companyId,
      jobVideoFeedId: jobVideoFeedID ?? this.jobVideoFeedId,
      jobDescription: jobDescription ?? this.jobDescription,
      location: location ?? this.location,
      position: position ?? this.position,
      skills: skills ?? this.skills,
      tools: tools ?? this.tools,
      workType: workType ?? this.workType,
      jobDuration: jobDuration ?? this.jobDuration,
      salary: salary ?? this.salary,
      status: status ?? this.status,
    );
  }
}
