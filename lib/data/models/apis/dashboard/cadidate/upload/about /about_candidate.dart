import 'package:flutter/foundation.dart';

class AboutCandidate {
  final String aboutId;
  final String candidateId;
  final String aboutCandidate;
  final List<String> languages;

  AboutCandidate({
    required this.aboutId,
    required this.candidateId,
    required this.aboutCandidate,
    required this.languages,
  });

  // Factory constructor to create an instance from a map
  factory AboutCandidate.fromJson(Map<String, dynamic> json) {
    return AboutCandidate(
      aboutId: json['aboutId'],
      candidateId: json['candidateId'],
      aboutCandidate: json['aboutCandidate'],
      languages: List<String>.from(json['languages']),
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toJson() {
    return {
      'aboutId': aboutId,
      'candidateId': candidateId,
      'aboutCandidate': aboutCandidate,
      'languages': languages,
    };
  }

  // CopyWith method to create a copy of the object with new values
   AboutCandidate copyWith({
    String? aboutId,
    String? candidateId,
    String? aboutCandidate,
    List<String>? languages,
  }) {
    return AboutCandidate(
      aboutId: aboutId ?? this.aboutId,
      candidateId: candidateId ?? this.candidateId,
      aboutCandidate: aboutCandidate ?? this.aboutCandidate,
      languages: languages ?? this.languages,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AboutCandidate &&
        other.aboutId == aboutId &&
        other.candidateId == candidateId &&
        other.aboutCandidate == aboutCandidate &&
        listEquals(other.languages, languages);
  }

  @override
  int get hashCode {
    return aboutId.hashCode ^
    candidateId.hashCode ^
    aboutCandidate.hashCode ^
    languages.hashCode;
  }

  @override
  String toString() {
    return 'AboutCandidate(aboutId: $aboutId, candidateId: $candidateId, aboutCandidate: $aboutCandidate, languages: $languages)';
  }
}
