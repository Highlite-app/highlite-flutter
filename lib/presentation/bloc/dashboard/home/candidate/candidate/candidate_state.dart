import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/home/candidate_feed.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../data/models/apis/dashboard/company/home/company_home_feed_details.dart';
import '../../../../../../data/models/apis/onboarding/bookmark/response/bookmark_collection.dart';
import '../../../../../../data/models/apis/onboarding/bookmark/response/bookmark_infos.dart';


class CandidateState {
  final List<CandidateFeed> candidateFeed;
  final Map<String, VideoPlayerController> controller;
  final Map<String, ImageProvider> thumbnail;
  final CompanyHomeFeedDetails? homeFeedDetails;
  final List<BookmarkCollection> bookmarkCollection;
  final List<BookmarkInfo> bookmarkInfo;
  final int lastPlayedCandidateIndex;
  final PageController pageController;
  final bool isInitialized;
  final int pageNumber;

  CandidateState({
    this.candidateFeed = const [],
    this.controller = const {},
    this.thumbnail = const {},
    PageController? pageController,
    this.homeFeedDetails ,
    this.bookmarkCollection = const [],
    this.bookmarkInfo = const [],
    this.lastPlayedCandidateIndex = 0 ,
    this.isInitialized = false,
    this.pageNumber = 0,
  }): pageController = pageController ?? PageController();

  CandidateState copyWith({
    List<CandidateFeed>? candidateFeed,
    Map<String, VideoPlayerController>? controller,
    Map<String, ImageProvider>? thumbnail,
    CompanyHomeFeedDetails? homeFeedDetails,
    List<BookmarkCollection>? bookmarkCollection,
    List<BookmarkInfo>? bookmarkInfo,
    PageController? pageController,
    int? lastPlayedCandidateIndex,
    bool? isInitialized,
    int? pageNumber,
  }) {
    return CandidateState(
      candidateFeed: candidateFeed ?? this.candidateFeed,
      controller: controller ?? this.controller,
      thumbnail: thumbnail ?? this.thumbnail,
      homeFeedDetails: homeFeedDetails ?? this.homeFeedDetails,
      bookmarkCollection: bookmarkCollection ?? this.bookmarkCollection,
      bookmarkInfo: bookmarkInfo ?? this.bookmarkInfo,
      lastPlayedCandidateIndex: lastPlayedCandidateIndex ?? this.lastPlayedCandidateIndex,
      isInitialized: isInitialized ?? this.isInitialized,
      pageNumber: pageNumber ?? this.pageNumber,
      pageController: pageController ?? this.pageController,
    );
  }
}
