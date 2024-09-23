import 'package:json_annotation/json_annotation.dart';

part 'lookup.g.dart';

class LookupTypes {
  static String match = "match";
  static String unmatch = "unmatch";
  static String superMessage = "super-message";
  static String dislike = "dislike";
}

class LookupParams {
  static String methodParams = """
      \$candidateID: ID,
      \$companyID: ID,
      \$jobID: ID!,
      \$type: String
  """;

  static String queryParams = """
      candidateID: \$candidateID,
      companyID: \$companyID,
      jobID: \$jobID,
      type: \$type
  """;
  static String modelParam = """
      id
      candidateID
      companyID
      jobID
      type
  """;
}

@JsonSerializable()
class HighliteLookupItemsResponse {
  final List<HighliteLookup> items;
  final String? nextToken;
  const HighliteLookupItemsResponse({required this.items, this.nextToken});
  factory HighliteLookupItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$HighliteLookupItemsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HighliteLookupItemsResponseToJson(this);
}

@JsonSerializable()
class HighliteLookup {
  final String id;
  final String candidateID;
  final String companyID;
  final String jobID;
  final String type;
  const HighliteLookup({
    required this.id,
    required this.candidateID,
    required this.companyID,
    required this.jobID,
    required this.type,
  });
  factory HighliteLookup.fromJson(Map<String, dynamic> json) =>
      _$HighliteLookupFromJson(json);
  Map<String, dynamic> toJson() => _$HighliteLookupToJson(this);
  HighliteLookup copyWith({
    String? id,
  }) =>
      HighliteLookup(
        id: id ?? this.id,
        candidateID: candidateID,
        companyID: companyID,
        jobID: jobID,
        type: type,
      );
}
