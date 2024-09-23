import 'company_job_feed.dart';

class CompanyJobFeedItemsResponse {
  final List<CompanyJobFeed> items;
  final String? nextToken;

  CompanyJobFeedItemsResponse({
    required this.items,
    this.nextToken,
  });

  factory CompanyJobFeedItemsResponse.fromJson(Map<String, dynamic> json) {
    return CompanyJobFeedItemsResponse(
      items: List<CompanyJobFeed>.from(json['items'].map((item) => CompanyJobFeed.fromJson(item))),
      nextToken: json['nextToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) =>CompanyJobFeed.fromJson(item as Map<String, dynamic>)).toList(),
      'nextToken': nextToken,
    };
  }

  CompanyJobFeedItemsResponse copyWith({
    List<CompanyJobFeed>? items,
    String? nextToken,
  }) {
    return CompanyJobFeedItemsResponse(
      items: items ?? this.items,
      nextToken: nextToken ?? this.nextToken,
    );
  }
}
