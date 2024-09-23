class CandidateEmploymentResponse {
  final int status;
  final String employmentId;
  final String candidateId;
  final String message;

  CandidateEmploymentResponse({
    required this.status,
    required this.employmentId,
    required this.candidateId,
    required this.message,
  });

  // Factory constructor to create an instance from a map
  factory CandidateEmploymentResponse.fromJson(Map<String, dynamic> json) {
    return CandidateEmploymentResponse(
      status: json['status'],
      employmentId: json['employmentId'],
      candidateId: json['candidateId'],
      message: json['message'],
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'employmentId': employmentId,
      'candidateId': candidateId,
      'message': message,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CandidateEmploymentResponse &&
        other.status == status &&
        other.employmentId == employmentId &&
        other.candidateId == candidateId &&
        other.message == message;
  }

  @override
  int get hashCode {
    return status.hashCode ^
    employmentId.hashCode ^
    candidateId.hashCode ^
    message.hashCode;
  }

  @override
  String toString() {
    return 'CandidateEmploymentResponse(status: $status, employmentId: $employmentId, candidateId: $candidateId, message: $message)';
  }
}
