class CandidateEmployment {
  final String employmentId;
  final String candidateId;
  final String employmentStatus;
  final String employmentType;
  final String employmentTitle;
  final String companyName;
  final String startDate;
  final String endDate;

  CandidateEmployment({
    required this.employmentId,
    required this.candidateId,
    required this.employmentStatus,
    required this.employmentType,
    required this.employmentTitle,
    required this.companyName,
    required this.startDate,
    required this.endDate,
  });

  // Factory constructor to create an instance from a map
  factory CandidateEmployment.fromJson(Map<String, dynamic> json) {
    return CandidateEmployment(
      employmentId: json['employmentId'],
      candidateId: json['candidateId'],
      employmentStatus: json['employmentStatus'],
      employmentType: json['employmentType'],
      employmentTitle: json['employmentTitle'],
      companyName: json['companyName'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toJson() {
    return {
      'employmentId': employmentId,
      'candidateId': candidateId,
      'employmentStatus': employmentStatus,
      'employmentType': employmentType,
      'employmentTitle': employmentTitle,
      'companyName': companyName,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CandidateEmployment &&
        other.employmentId == employmentId &&
        other.candidateId == candidateId &&
        other.employmentStatus == employmentStatus &&
        other.employmentType == employmentType &&
        other.employmentTitle == employmentTitle &&
        other.companyName == companyName &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return employmentId.hashCode ^
    candidateId.hashCode ^
    employmentStatus.hashCode ^
    employmentType.hashCode ^
    employmentTitle.hashCode ^
    companyName.hashCode ^
    startDate.hashCode ^
    endDate.hashCode;
  }

  @override
  String toString() {
    return 'CandidateEmployment(employmentId: $employmentId, candidateId: $candidateId, employmentStatus: $employmentStatus, employmentType: $employmentType, employmentTitle: $employmentTitle, companyName: $companyName, startDate: $startDate, endDate: $endDate)';
  }


  static List<CandidateEmployment> createDummyEmploymentList() {
    return [
      CandidateEmployment(
        employmentId: '1',
        candidateId: 'C001',
        employmentStatus: 'Active',
        employmentType: 'Full-time',
        employmentTitle: 'UI/UX Designer',
        companyName: '0260 LABS LLC',
        startDate: 'Mar 2024',
        endDate: 'Present',
      ),
      CandidateEmployment(
        employmentId: '2',
        candidateId: 'C001',
        employmentStatus: 'Completed',
        employmentType: 'Full-time',
        employmentTitle: 'UI/UX Designer',
        companyName: 'TATA Digital',
        startDate: 'Apr 2023',
        endDate: 'Feb 2024',
      ),
      CandidateEmployment(
        employmentId: '3',
        candidateId: 'C001',
        employmentStatus: 'Completed',
        employmentType: 'Full-time',
        employmentTitle: 'Graphics Designer',
        companyName: 'Indtubes',
        startDate: 'Jan 2022',
        endDate: 'Mar 2023',
      ),
    ];
  }
}
