class CandidateProjectResponse {
  final int status;
  final String projectId;
  final String candidateId;
  final String message;

  CandidateProjectResponse({
    required this.status,
    required this.projectId,
    required this.candidateId,
    required this.message,
  });

  // Factory constructor to create an instance from a map
  factory CandidateProjectResponse.fromJson(Map<String, dynamic> json) {
    return CandidateProjectResponse(
      status: json['status'],
      projectId: json['projectId'],
      candidateId: json['candidateId'],
      message: json['message'],
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'projectId': projectId,
      'candidateId': candidateId,
      'message': message,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CandidateProjectResponse &&
        other.status == status &&
        other.projectId == projectId &&
        other.candidateId == candidateId &&
        other.message == message;
  }

  @override
  int get hashCode {
    return status.hashCode ^
    projectId.hashCode ^
    candidateId.hashCode ^
    message.hashCode;
  }

  @override
  String toString() {
    return 'CandidateProjectResponse(status: $status, projectId: $projectId, candidateId: $candidateId, message: $message)';
  }
}
