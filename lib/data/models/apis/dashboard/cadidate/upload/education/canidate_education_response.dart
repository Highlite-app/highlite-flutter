class CandidateEducationResponse {
  final int status;
  final String educationId;
  final String candidateId;
  final String message;

  CandidateEducationResponse({
    required this.status,
    required this.educationId,
    required this.candidateId,
    required this.message,
  });

  // Factory constructor to create an instance from a map
  factory CandidateEducationResponse.fromJson(Map<String, dynamic> json) {
    return CandidateEducationResponse(
      status: json['status'],
      educationId: json['educationId'],
      candidateId: json['candidateId'],
      message: json['message'],
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'educationId': educationId,
      'candidateId': candidateId,
      'message': message,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CandidateEducationResponse &&
        other.status == status &&
        other.educationId == educationId &&
        other.candidateId == candidateId &&
        other.message == message;
  }

  @override
  int get hashCode {
    return status.hashCode ^
    educationId.hashCode ^
    candidateId.hashCode ^
    message.hashCode;
  }

  @override
  String toString() {
    return 'CandidateEducationResponse(status: $status, educationId: $educationId, candidateId: $candidateId, message: $message)';
  }
}
