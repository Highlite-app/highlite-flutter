import 'package:flutter/cupertino.dart';
import 'package:highlite_flutter_mvp/core/constants/video_feed_constants.dart';
import 'package:highlite_flutter_mvp/core/services/mux_video_client.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/home/candidate_feed.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/bookmark/response/bookmark_collection.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/bookmark/response/bookmark_infos.dart';
import 'package:highlite_flutter_mvp/data/models/services/mux/mux_asset.dart';
import 'package:highlite_flutter_mvp/data/repositories/dashboard/common/bookmark/bookmark_repository_impl.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/common/feed_service/home_feed_state_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/common/video_player/video_player_queue_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/constants/user_types.dart';
import '../../../../../presentation/widgets/utils/logger.dart';
import '../../../../../presentation/widgets/utils/video_player_utils.dart';
import '../../../../models/apis/dashboard/cadidate/profile/next_token_request.dart';
import '../../../../models/apis/dashboard/company/home/company_job_feed.dart';
import '../../candidate/home/candidate_feed_repository_impl.dart';
import '../../candidate/home/job_post_video_feed_repository_impl.dart';

@Injectable(as: HomeFeedStateRepository)
class HomeFeedStateRepositoryImpl implements HomeFeedStateRepository {
  @override
  MuxAsset? muxAsset;

  @override
  bool? isCandidate = false;



  @override
  PageController? pageController;



  @override
  List<CandidateFeed> candidateVideoFeeds = [];

  @override
  String? nextTokenForYouFeed = "";

  @override
  String? nextTokenForCandidateFeed = "";


  @override
  String? nextTokenForFollowingFeed;
  @override
  List<CompanyJobFeed> companyJobFeeds = [];

  @override
  List<CandidateFeed> candidateFeed = [];

  @override
  List<CompanyJobFeed> companyFeed = [];

  @override
  List<CompanyJobFeed> companyForYouFeed = [];

  @override
  List<CompanyJobFeed> followingFeed =[];


  @override
  Map<String, VideoPlayerController> candidateController ={};

  @override
  Map<String, ImageProvider<Object>> candidateThumbnails ={};

  @override
  Map<String, VideoPlayerController> jobsController ={};

  @override
  Map<int, VideoPlayerController> forYouController ={};

  @override
  Map<int, ImageProvider<Object>> forYouThumbnails ={};

  @override
  Map<String, ImageProvider<Object>> jobsThumbnails ={};



  @override
  List<String> followingIds = [];
  @override
  List<CompanyJobFeed> followingJobFeeds = [];

  @override
  List<BookmarkCollection> currentUserBookmarkCollectionList = [];

  @override
  List<BookmarkInfo> currentUserBookmarkInfoList = [];

  @override
  Map<String, ImageProvider> followingThumbnails = {};
  @override
  Map<String, VideoPlayerController> followingControllers = {};

  @override
  String? tempFollowingId;

  @override
  ValueNotifier<List<CompanyJobPost>> jobPosts = ValueNotifier([]);


  // @override
  // List<HighliteCompanyJobPost> jobPosts = [];

  @override
  Future<void> clearState() async {
    companyJobFeeds = [];
    followingJobFeeds = [];
    followingThumbnails = {};
    followingControllers = {};
  }

  @override
  Future<void> fetch() async {
    final userType = authService.persistedUser?.userType;
    await videoControllerList();
    await fetchByUserType(userType!);
  }

  @override
  Future<void> fetchByUserType(String userType) async {
    if (userType == UserTypes.candidate) {
      print("Called") ;
      final response = await jobPostingFeedService
          .fetch(NextTokenRequest(nextToken: nextTokenForYouFeed));
      final candidateFeedResponse  = await candidateFeedService.fetchCandidate(NextTokenRequest(nextToken: nextTokenForCandidateFeed)) ;
      logger.logEvent("The response in HomeFeedStateRepository :: $response", isJson: true);
      logger.logEvent("The response in CandidateFeed :: $candidateFeedResponse", isJson: true);
      candidateFeed.addAll(candidateFeedResponse.items) ;
      companyJobFeeds.addAll(response.items);
      companyForYouFeed.addAll(response.items) ;
      for(var candidateFeedItem in candidateFeedResponse.items){
        await videoQueue.enqueue(candidateFeedItem.playbackId) ;
        final controller = videoQueue.getControllerBy(candidateFeedItem.playbackId) ;
        final thumbnail = videoQueue.getThumbnailBy(candidateFeedItem.playbackId) ;
        if(controller!=null && thumbnail !=null){
         candidateController[candidateFeedItem.playbackId] = controller ;
         candidateThumbnails[candidateFeedItem.playbackId] = thumbnail ;
        }
      }
      nextTokenForYouFeed = response.nextToken;
      nextTokenForCandidateFeed = response.nextToken ;

    } else {
      /*   final response = await candidateInfoVideoFeedService
          .fetch(NextTokenRequest(nextToken: nextTokenForHomeFeed));
      candidateVideoFeeds.addAll(response.items);
      nextTokenForHomeFeed = response.nextToken;
      for (var feedItem in response.items) {
        final followingIds = await candidateFollowingService
            .fetchAllPaginatedByUserID(feedItem.user.id);
        int followingCount = followingIds.isNotEmpty ? followingIds.length : 0;
        candidateVideoFeeds[
        candidateVideoFeeds.indexWhere((e) => e.id == feedItem.id)]
            .followingCount = followingCount;

        final responseFollowerList =
        await getFollowerCountPaginated(feedItem.id);

        int followerCount =
        responseFollowerList.isNotEmpty ? responseFollowerList.length : 0;
        candidateVideoFeeds[
        candidateVideoFeeds.indexWhere((e) => e.id == feedItem.id)]
            .followerCount = followerCount;

        String followingId = responseFollowerList.isNotEmpty
            ? responseFollowerList
            .firstWhere((e) => e.ownerCandidateFeedID == feedItem.id)
            .id
            : "";
        candidateVideoFeeds[
        candidateVideoFeeds.indexWhere((e) => e.id == feedItem.id)]
            .followingId = followingId;

        await videoQueue.enqueue(feedItem.playbackId);
        final controller = videoQueue.getControllerBy(feedItem.playbackId);
        final thumbnail = videoQueue.getThumbnailBy(feedItem.playbackId);
        if (controller != null && thumbnail != null) {
          controllers[feedItem.playbackId] = controller;
          thumbnails[feedItem.playbackId] = thumbnail;
        }
      }*/
    }
  }

  @override
  Future<void> fetchFollowing() async {
/*    final userType = authService.persistedUser!.userType;
    final userID = authService.persistedUser!.id;
    if (userType == UserTypes.candidate) {
      final followingIds =
      await candidateFollowingService.fetchAllPaginatedByUserID(userID);
      this.followingIds = followingIds.map((e) => e.companyId).toList();
      if (this.followingIds.isNotEmpty) {
        final response = await candidateFollowingFeedService.getFollowing(
          NextTokenRequest(nextToken: nextTokenForFollowingFeed),
          this.followingIds,
        );
        final jobFeeds = response.items.map((e) => e).toList();
        await populateFollowing(jobFeeds);
        dashboardNavKey.currentContext!
            .read<CandidateHomeFeedBloc>()
            .add(const PopulateFollowingFeedEvent());
      } else {
        await populateFollowing([]);
        dashboardNavKey.currentContext!
            .read<CandidateHomeFeedBloc>()
            .add(const PopulateFollowingFeedEvent());
      }
    } else {
      final currentUserID = authService.companyProfile?.id;
      final response = await companyFollowingFeedService.getFollowing(
          NextTokenRequest(nextToken: nextTokenForFollowingFeed),
          currentUserID!,
          true);
      final followingFeeds =
      response.items.map((e) => e.ownerCandidateFeed).toList();
      await populateForCompanyFollowing(followingFeeds);
      dashboardNavKey.currentContext!
          .read<CompanyHomeFeedBloc>()
          .add(const PopulateFollowingFeedInfoEvent());
    }*/
  }

  // @override
  // Future<void> populateForCompanyFollowing(
  //     List<HighliteFollowingCandidateVideoFeed> list) async {
  //   followingCandidateFeeds.addAll(list);
  //   // for (var feedItem in list) {
  //   //   final followingIds = await candidateFollowingService
  //   //       .fetchAllPaginatedByUserID(feedItem.user.id);
  //   //   int followingCount = followingIds.isNotEmpty ? followingIds.length : 0;
  //   //   followingCandidateFeeds[
  //   //   followingCandidateFeeds.indexWhere((e) => e.id == feedItem.id)]
  //   //       .followingCount = followingCount;
  //   //   final responseFollowerList = await getFollowerCountPaginated(feedItem.id);
  //   //
  //   //   int followerCount =
  //   //   responseFollowerList.isNotEmpty ? responseFollowerList.length : 0;
  //   //   followingCandidateFeeds[
  //   //   followingCandidateFeeds.indexWhere((e) => e.id == feedItem.id)]
  //   //       .followerCount = followerCount;
  //   //
  //   //   String followingId = responseFollowerList.isNotEmpty
  //   //       ? responseFollowerList
  //   //       .firstWhere((e) => e.ownerCandidateFeedID == feedItem.id)
  //   //       .id
  //   //       : "";
  //   //   followingCandidateFeeds[
  //   //   followingCandidateFeeds.indexWhere((e) => e.id == feedItem.id)]
  //   //       .followingId = followingId;
  //   //
  //   //   await videoQueue.enqueue(feedItem.playbackId);
  //   //   final controller = videoQueue.getControllerBy(feedItem.playbackId);
  //   //   final thumbnail = videoQueue.getThumbnailBy(feedItem.playbackId);
  //   //   if (controller != null && thumbnail != null) {
  //   //     followingControllers[feedItem.playbackId] = controller;
  //   //     followingThumbnails[feedItem.playbackId] = thumbnail;
  //   //   }
  //   throw UnimplementedError();
  // }

  // @override
  // Future<void> addUpdateFeeds(HighliteFollowingCandidateVideoFeed item) {
  //   // TODO: implement addUpdateFeeds
  //   throw UnimplementedError();
  // }

  @override
  Future<String> createCompanyFollowing(
      String currentUserCompanyID, String ownerCandidateFeedID, bool status) {
    // TODO: implement createCompanyFollowing
    throw UnimplementedError();
  }

  @override
  Future<String> deleteCompanyFollowing(String id) {
    // TODO: implement deleteCompanyFollowing
    throw UnimplementedError();
  }

  // @override
  // Future<void> deleteUpdateFeeds(HighliteFollowingCandidateVideoFeed item) {
  //   // TODO: implement deleteUpdateFeeds
  //   throw UnimplementedError();
  // }

  @override
  Future<void> getCurrentUserBookmarkList(String id) async{
    final result = await bookmarkService.getBookmark( id , request: const  NextTokenRequest(nextToken: '' ) ) ;

    currentUserBookmarkCollectionList = result.items ?? [] ;

    for(var item in currentUserBookmarkCollectionList){
      if(item.bookmarkInfo.isNotEmpty){
        currentUserBookmarkInfoList.addAll(item.bookmarkInfo) ;
      }
    }
  }

  // @override
  // Future<HighliteFollowingForCompanyItemsResponse> getFollowerCount(String id) {
  //   // TODO: implement getFollowerCount
  //   throw UnimplementedError();
  // }

  // @override
  // Future<List<HighliteFollowingForCompany>> getFollowerCountPaginated(
  //     String id) {
  //   // TODO: implement getFollowerCountPaginated
  //   throw UnimplementedError();
  // }

  // @override
  // Future<HighliteFollowingForCompanyItemsResponse> getFollowingCount(
  //     String id) {
  //   // TODO: implement getFollowingCount
  //   throw UnimplementedError();
  // }

  // @override
  // Future<List<HighliteFollowingForCompany>> getFollowingCountPaginated(
  //     String id) {
  //   // TODO: implement getFollowingCountPaginated
  //   throw UnimplementedError();
  // }

  @override
  Future<void> listCompanyJobPosting() {
    // TODO: implement listCompanyJobPosting
    throw UnimplementedError();
  }

  @override
  Future<void> populateFollowing(List<CompanyJobPost> list) {
    // TODO: implement populateFollowing
    throw UnimplementedError();
  }

  @override
  Future<void> removeAllByCompanyId(String companyId) {
    // TODO: implement removeAllByCompanyId
    throw UnimplementedError();
  }

  @override
  Future<void> reset() {
    // TODO: implement reset
    throw UnimplementedError();
  }

  @override
  Future<void> videoControllerList() async {
    Map<String, dynamic> muxAssetResponse = isCandidate ?? false
        ? await MuxVideoClient()
            .getMuxAssets(muxToken: MUX_TOKEN_ID, muxSecret: MUX_SECRET_KEY)
        : await MuxVideoClient().getMuxAssets();
    muxAsset = MuxAsset.fromJson(muxAssetResponse);
    final data = muxAsset?.data ?? [];
    logger.logEvent("The _videoUrl is ::$data} ");
    debugPrint("Clicked");
    logger.logEvent("The mux Asset response is ::$muxAssetResponse",
        isJson: true);
    debugPrint("Clicked On");
    for (int i = 0 ; i< data.length ;i++) {
      await videoQueue.enqueue(data[i].playbackIds?.first.id ?? '') ;
     final  playbackIds = data[i].playbackIds?.first.id ?? '' ;
      final controller  = videoQueue.getControllerBy(playbackIds) ;
      final thumbnail = videoQueue.getThumbnailBy(playbackIds) ;

      if(controller !=null && thumbnail !=null){
        forYouController[i]= controller ;
        forYouThumbnails[i] = thumbnail ;
      }
      // VideoPlayerController controller = VideoPlayerController.networkUrl(
      //     Uri.parse((VideoFeedConstants.getPlaybackUrl(
      //         playbackId: url.playbackIds?.first.id ?? ''))));
      // ImageProvider imageProvider = NetworkImage(
      //     VideoFeedConstants.getThumbnailUrl(
      //         playbackId: url.playbackIds?.first.id ?? ''));
      // videoPlayerController.add(controller);
      // imageProviders.add(imageProvider);
      // controller.initialize().then((_) {
      //   if (videoPlayerController.indexOf(controller) == 0) {
      //     controller.play();
      //   }
      // });
      // pageController?.addListener(() {
      //   int currentIndex = pageController?.page?.round() ?? 0;
      //   VideoPlayerUtil.handleVideoPlyingOnPageChange(
      //       videoPlayerController: videoPlayerController,
      //       pageIndex: currentIndex);
      // });
    }
  }

  @override
  Future<dynamic> getFollowerCount(String id) {
    // TODO: implement getFollowerCount
    throw UnimplementedError();
  }

  @override
  Future<List<dynamic>> getFollowerCountPaginated(String id) {
    // TODO: implement getFollowerCountPaginated
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getFollowingCount(String id) {
    // TODO: implement getFollowingCount
    throw UnimplementedError();
  }

  @override
  Future<List<dynamic>> getFollowingCountPaginated(String id) {
    // TODO: implement getFollowingCountPaginated
    throw UnimplementedError();
  }














}
