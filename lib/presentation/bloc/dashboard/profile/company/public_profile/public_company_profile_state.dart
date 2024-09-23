

import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';

import '../../../../../../data/models/apis/dashboard/company/home/company_job_feed.dart';

class PublicCompanyProfileState {
  PublicCompanyProfileState({
    this.jobFeeds = const [],
    this.jobPosts = const [],
    this.followers = const [],
    this.following = const [],
    this.isLoading = true,
    this.id = "",
    this.followingCount = 0,
  });
  final List<CompanyJobFeed> jobFeeds;
  final List<CompanyJobPost> jobPosts;
  final List<String> followers;
  final List<String> following;
  final bool isLoading;
  final String id;
  final int followingCount;
  PublicCompanyProfileState copyWith({
    List<CompanyJobFeed>? jobFeeds,
    List<CompanyJobPost>? jobPosts,
    List<String>? followers,
    List<String>? following,
    bool? isLoading,
    String? id,
    int? followingCount,
  }) =>
      PublicCompanyProfileState(
        jobFeeds: jobFeeds ?? this.jobFeeds,
        jobPosts: jobPosts ?? this.jobPosts,
        followers: followers ?? this.followers,
        following: following ?? this.following,
        isLoading: isLoading ?? this.isLoading,
        id: id ?? this.id,
        followingCount: followingCount ?? this.followingCount,
      );
}
