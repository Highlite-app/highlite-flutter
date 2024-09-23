import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/data/models/services/mux/mux_asset.dart';
import 'package:video_player/video_player.dart';

import '../../../../../data/models/apis/dashboard/company/home/company_job_feed.dart';
import '../../../../../data/models/apis/onboarding/bookmark/response/bookmark_collection.dart';
import '../../../../../data/models/apis/onboarding/bookmark/response/bookmark_infos.dart';


class CandidateHomeFeedState {
  CandidateHomeFeedState({
    this.jobFeeds = const [],
    this.controllers = const {},
    this.thumbnails = const {},
    this.followingFeeds = const [],
    this.followingControllers = const {},
    this.followingThumbnails = const {},
    this.initialized = false,
    this.videoPlayerController = const []  ,
    this.imageProvider = const [] ,
    this.pageController ,
    this.pageNumber = 0,
    this.pageNumberFollowing = 0,
    this.muxAsset ,
    this.bookmarkCollections = const [],
    this.bookmarkInfos = const [],

    this.lastPlayedForYouIndex = 0,
    this.lastPlayedCandidateIndex = 0,
    this.lastPlayedJobsIndex = 0,
    this.lastPlayedFollowingIndex = 0,
  });
  final List<CompanyJobFeed> jobFeeds;
  final Map<String, VideoPlayerController> controllers;
  final MuxAsset? muxAsset ;

  final PageController? pageController ;
  final List<VideoPlayerController>? videoPlayerController ;
  final List<ImageProvider>? imageProvider  ;
  final Map<String, ImageProvider> thumbnails;
  final List<CompanyJobFeed> followingFeeds;
  final Map<String, VideoPlayerController> followingControllers;
  final Map<String, ImageProvider> followingThumbnails;
  final bool initialized;
  final int pageNumber;
  final int pageNumberFollowing;
  final List<BookmarkCollection> bookmarkCollections;
  final List<BookmarkInfo> bookmarkInfos;

  final int lastPlayedForYouIndex;
  final int lastPlayedCandidateIndex;
  final int lastPlayedJobsIndex;
  final int lastPlayedFollowingIndex;

  CandidateHomeFeedState copyWith({
    bool? initialized,
    MuxAsset? muxAsset ,
    List<VideoPlayerController>? videoPlayerController ,
    List<ImageProvider>? imageProvider ,
    PageController? pageController ,
    List<CompanyJobFeed>? jobFeeds,
    Map<String, VideoPlayerController>? controllers,
    Map<String, ImageProvider>? thumbnails,
    List<CompanyJobFeed>? followingFeeds,
    Map<String, VideoPlayerController>? followingControllers,
    Map<String, ImageProvider>? followingThumbnails,
    int? pageNumber,
    int? pageNumberFollowing,
    List<BookmarkCollection>? bookmarkCollections,
    List<BookmarkInfo>? bookmarkInfos,

    int? lastPlayedForYouIndex,
    int? lastPlayedCandidateIndex,
    int? lastPlayedJobsIndex,
    int? lastPlayedFollowingIndex,
  
  }) =>
      CandidateHomeFeedState(
        jobFeeds: jobFeeds ?? this.jobFeeds,
        initialized: initialized ?? this.initialized,
        controllers: controllers ?? this.controllers,
        muxAsset:  muxAsset?? this.muxAsset,
        videoPlayerController:  videoPlayerController?? this.videoPlayerController,
        imageProvider:  imageProvider ?? this.imageProvider,
        pageController: pageController ?? this.pageController,
        thumbnails: thumbnails ?? this.thumbnails,
        followingFeeds: followingFeeds ?? this.followingFeeds,
        followingControllers: followingControllers ?? this.followingControllers,
        followingThumbnails: followingThumbnails ?? this.followingThumbnails,
        pageNumber: pageNumber ?? this.pageNumber,
        pageNumberFollowing: pageNumberFollowing ?? this.pageNumberFollowing,
        bookmarkCollections: bookmarkCollections ?? this.bookmarkCollections,
        bookmarkInfos: bookmarkInfos ?? this.bookmarkInfos,

        lastPlayedForYouIndex: lastPlayedForYouIndex ?? this.lastPlayedForYouIndex,
        lastPlayedCandidateIndex: lastPlayedCandidateIndex ?? this.lastPlayedCandidateIndex,
        lastPlayedJobsIndex: lastPlayedJobsIndex ?? this.lastPlayedJobsIndex,
        lastPlayedFollowingIndex: lastPlayedFollowingIndex ?? this.lastPlayedFollowingIndex,
      );
}
