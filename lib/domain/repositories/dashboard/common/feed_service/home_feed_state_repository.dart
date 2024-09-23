import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/bookmark/response/bookmark_collection.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/bookmark/response/bookmark_infos.dart';
import 'package:highlite_flutter_mvp/data/models/services/mux/mux_asset.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../../data/models/apis/dashboard/cadidate/home/candidate_feed.dart';
import '../../../../../data/models/apis/dashboard/company/home/company_job_feed.dart';

final homeFeedState = sl.get<HomeFeedStateRepository>();

abstract class HomeFeedStateRepository {
  late String? nextTokenForYouFeed;
  late String? nextTokenForCandidateFeed ;
  late bool? isCandidate;

  late String? nextTokenForFollowingFeed;
  late PageController? pageController;

  late List<CompanyJobFeed> companyJobFeeds;

  late List<CandidateFeed> candidateFeed ;

  late List<CompanyJobFeed> companyFeed ;
  late List<CompanyJobFeed> companyForYouFeed ;

  late List<CompanyJobFeed> followingFeed ;


  late List<CandidateFeed> candidateVideoFeeds;
  late MuxAsset? muxAsset;

  // Candidate
  late Map<String, ImageProvider> candidateThumbnails;
  late Map<String, VideoPlayerController> candidateController;

  // For You
  late Map<int , VideoPlayerController> forYouController ;
  late Map<int , ImageProvider> forYouThumbnails ;

  // Company
  late Map<String , VideoPlayerController> jobsController ;
  late Map<String , ImageProvider> jobsThumbnails ;

  // Following
  late List<String> followingIds;
  late List<CompanyJobFeed> followingJobFeeds;

  late Map<String, ImageProvider> followingThumbnails;
  late Map<String, VideoPlayerController> followingControllers;


  late String? tempFollowingId;



  late ValueNotifier<List<CompanyJobPost>> jobPosts;

  late List<BookmarkCollection> currentUserBookmarkCollectionList;
  late List<BookmarkInfo> currentUserBookmarkInfoList;

  Future<void> videoControllerList();

  Future<void> fetch();

  Future<void> reset();

  Future<void> fetchByUserType(String userType);

  Future<void> clearState();

  Future<void> fetchFollowing();

  Future<void> populateFollowing(List<CompanyJobPost> list);

  //Future<void> populateForCompanyFollowing(List<HighliteFollowingCandidateVideoFeed> list);
  Future<void> removeAllByCompanyId(String companyId);

  // Future<void> addUpdateFeeds(HighliteFollowingCandidateVideoFeed item);
  //Future<void> deleteUpdateFeeds(HighliteFollowingCandidateVideoFeed item);
  // Future<HighliteFollowingForCompanyItemsResponse> getFollowingCount(String id);
  // Future<HighliteFollowingForCompanyItemsResponse> getFollowerCount(String id);
  // Future<List<HighliteFollowingForCompany>> getFollowerCountPaginated(
  //     String id);
  // Future<List<HighliteFollowingForCompany>> getFollowingCountPaginated(
  //     String id);
  Future<String> createCompanyFollowing(
      String currentUserCompanyID, String ownerCandidateFeedID, bool status);

  Future<String> deleteCompanyFollowing(String id);

  Future<void> listCompanyJobPosting();

  Future<void> getCurrentUserBookmarkList(String id);
}
