class CandidateAboutResponse {
  final int status;
  final String aboutId;
  final String candidateId;
  final String message;

  CandidateAboutResponse({
    required this.status,
    required this.aboutId,
    required this.candidateId,
    required this.message,
  });

  // Factory constructor to create an instance from a map
  factory CandidateAboutResponse.fromJson(Map<String, dynamic> json) {
    return CandidateAboutResponse(
      status: json['status'],
      aboutId: json['aboutId'],
      candidateId: json['candidateId'],
      message: json['message'],
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'aboutId': aboutId,
      'candidateId': candidateId,
      'message': message,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CandidateAboutResponse &&
        other.status == status &&
        other.aboutId == aboutId &&
        other.candidateId == candidateId &&
        other.message == message;
  }

  @override
  int get hashCode {
    return status.hashCode ^
    aboutId.hashCode ^
    candidateId.hashCode ^
    message.hashCode;
  }

  @override
  String toString() {
    return 'CandidateAboutResponse(status: $status, aboutId: $aboutId, candidateId: $candidateId, message: $message)';
  }
}
