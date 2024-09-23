
class CandidateVideoFeedResponse {
  int status;
  String candidateVideoId;

  CandidateVideoFeedResponse({required this.status, required this.candidateVideoId});

  // From JSON
  factory CandidateVideoFeedResponse.fromJson(Map<String, dynamic> json) {
    return CandidateVideoFeedResponse(
      status: json['status'],
      candidateVideoId: json['candidateVideoId'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'candidateVideoId': candidateVideoId,
    };
  }
}