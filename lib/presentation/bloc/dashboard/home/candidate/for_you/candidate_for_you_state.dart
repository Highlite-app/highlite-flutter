import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../data/models/apis/dashboard/company/home/company_home_feed_details.dart';
import '../../../../../../data/models/apis/dashboard/company/home/company_job_feed.dart';
import '../../../../../../data/models/apis/onboarding/bookmark/response/bookmark_collection.dart';
import '../../../../../../data/models/apis/onboarding/bookmark/response/bookmark_infos.dart';


class CandidateForYouState {
  final List<CompanyJobFeed> forYouFeed;
  final Map<int, VideoPlayerController> controller;
  final Map<int, ImageProvider> thumbnail;
  final CompanyHomeFeedDetails? homeFeedDetails;
  final List<BookmarkCollection> bookmarkCollection;
  final List<BookmarkInfo> bookmarkInfo;
  final int lastPlayedForYouIndex;
  final PageController pageController;
  final bool isInitialized;
  final int pageNumber;

  CandidateForYouState({
    this.forYouFeed = const [],
    this.controller = const {},
    this.thumbnail = const {},
    PageController? pageController,
    this.homeFeedDetails ,
    this.bookmarkCollection = const [],
    this.bookmarkInfo = const [],
    this.lastPlayedForYouIndex = 0 ,
    this.isInitialized = false,
    this.pageNumber = 0,
  }): pageController = pageController ?? PageController();

  CandidateForYouState copyWith({
    List<CompanyJobFeed>? forYouFeed,
    Map<int, VideoPlayerController>? controller,
    Map<int, ImageProvider>? thumbnail,
    CompanyHomeFeedDetails? homeFeedDetails,
    List<BookmarkCollection>? bookmarkCollection,
    List<BookmarkInfo>? bookmarkInfo,
    PageController? pageController,
    int? lastPlayedForYouIndex,
    bool? isInitialized,
    int? pageNumber,
  }) {
    return CandidateForYouState(
      forYouFeed: forYouFeed ?? this.forYouFeed,
      controller: controller ?? this.controller,
      thumbnail: thumbnail ?? this.thumbnail,
      homeFeedDetails: homeFeedDetails ?? this.homeFeedDetails,
      bookmarkCollection: bookmarkCollection ?? this.bookmarkCollection,
      bookmarkInfo: bookmarkInfo ?? this.bookmarkInfo,
      lastPlayedForYouIndex: lastPlayedForYouIndex ?? this.lastPlayedForYouIndex,
      isInitialized: isInitialized ?? this.isInitialized,
      pageNumber: pageNumber ?? this.pageNumber,
      pageController: pageController ?? this.pageController,
    );
  }
}
