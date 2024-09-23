class CandidateEducation {
  final String educationId;
  final String candidateId;
  final String school;
  final String degree;
  final String specialization;
  final String startDate;
  final String endDate;

  CandidateEducation({
    required this.educationId,
    required this.candidateId,
    required this.school,
    required this.degree,
    required this.specialization,
    required this.startDate,
    required this.endDate,
  });

  // Factory constructor to create an instance from a map
  factory CandidateEducation.fromJson(Map<String, dynamic> json) {
    return CandidateEducation(
      educationId: json['educationId'],
      candidateId: json['candidateId'],
      school: json['school'],
      degree: json['degree'],
      specialization: json['specialization'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toJson() {
    return {
      'educationId': educationId,
      'candidateId': candidateId,
      'school': school,
      'degree': degree,
      'specialization': specialization,
      'startDate': startDate,
      'endDate': endDate,
    };
  }



  CandidateEducation copyWith({
     String? educationId ,
     String? candidateId ,
     String? school ,
     String? degree ,
     String? specialization ,
     String? startDate ,
     String? endDate ,
}) => CandidateEducation(educationId: educationId ?? this.educationId,
      candidateId:candidateId ?? this.educationId ,
      school: school ?? this.school,
      degree: degree ?? this.degree,
      specialization: specialization ?? this.specialization,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate) ;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CandidateEducation &&
        other.educationId == educationId &&
        other.candidateId == candidateId &&
        other.school == school &&
        other.degree == degree &&
        other.specialization == specialization &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return educationId.hashCode ^
    candidateId.hashCode ^
    school.hashCode ^
    degree.hashCode ^
    specialization.hashCode ^
    startDate.hashCode ^
    endDate.hashCode;
  }

  @override
  String toString() {
    return 'CandidateEducation(educationId: $educationId, candidateId: $candidateId, school: $school, degree: $degree, specialization: $specialization, startDate: $startDate, endDate: $endDate)';
  }

  static List<CandidateEducation> dummyCandidateEducationList = [
    CandidateEducation(
      educationId: '1',
      candidateId: '101',
      school: 'Harvard University',
      degree: 'Bachelor of Science',
      specialization: 'Computer Science',
      startDate: '2010-09-01',
      endDate: '2014-05-30',
    ),
    CandidateEducation(
      educationId: '2',
      candidateId: '102',
      school: 'Stanford University',
      degree: 'Master of Science',
      specialization: 'Artificial Intelligence',
      startDate: '2015-09-01',
      endDate: '2017-06-15',
    ),
    CandidateEducation(
      educationId: '3',
      candidateId: '103',
      school: 'MIT',
      degree: 'Ph.D. in Robotics',
      specialization: 'Robotics and Automation',
      startDate: '2018-09-01',
      endDate: '2022-06-15',
    ),
    CandidateEducation(
      educationId: '4',
      candidateId: '104',
      school: 'University of California, Berkeley',
      degree: 'Bachelor of Arts',
      specialization: 'Economics',
      startDate: '2012-09-01',
      endDate: '2016-05-30',
    ),
    CandidateEducation(
      educationId: '5',
      candidateId: '105',
      school: 'University of Oxford',
      degree: 'Master of Business Administration',
      specialization: 'Business Management',
      startDate: '2017-09-01',
      endDate: '2019-06-15',
    ),
  ];
}
