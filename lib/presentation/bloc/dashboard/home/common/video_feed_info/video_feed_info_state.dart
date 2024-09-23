import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/bookmark/response/bookmark_collection.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/bookmark/response/bookmark_infos.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';

import '../../../../../../data/models/apis/dashboard/common/highlite_video_feed_info.dart';
import '../../../../../../data/models/apis/dashboard/common/lookup/lookup.dart';
import '../../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';

class VideoFeedInfoState {
  VideoFeedInfoState({
    this.info,
    this.candidate,
    this.company,
    this.jobPost,
    this.infos,
    this.jobPosts,
    this.lookups = const [],
    this.isLoading = true,
    this.initialized = false,
    this.disposed = false,
    this.bookmarkCollections = const [],
    this.bookmarkInfos = const [],
    this.isProfileBookmark = false,
    this.isAdded = false,
  });

  final HighliteVideoFeedInfo? info;
  final CandidateOnBoarding? candidate;
  final CompanyOnboarding? company;
  final CompanyJobPost? jobPost;
  final List<HighliteVideoFeedInfo>? infos;
  final List<CompanyJobPost>? jobPosts;
  final List<HighliteLookup> lookups;
  final bool isLoading;
  final bool initialized;
  final bool disposed;
  final List<BookmarkCollection> bookmarkCollections;
  final List<BookmarkInfo> bookmarkInfos;
  final bool isProfileBookmark;
  final bool isAdded;

  VideoFeedInfoState copyWith({
    HighliteVideoFeedInfo? info,
    List<HighliteVideoFeedInfo>? infos,
    CandidateOnBoarding? candidate,
    CompanyOnboarding? company,
    CompanyJobPost? jobPost,
    List<CompanyJobPost>? jobPosts,
    List<HighliteLookup>? lookups,
    bool? isLoading,
    bool? initialized,
    bool? disposed,
    List<BookmarkCollection>? bookmarkCollections,
    List<BookmarkInfo>? bookmarkInfos,
    bool? isProfileBookmark,
    bool? isAdded,
  }) =>
      VideoFeedInfoState(
        info: info ?? this.info,
        infos: infos ?? this.infos,
        candidate: candidate ?? this.candidate,
        company: company ?? this.company,
        jobPost: jobPost ?? this.jobPost,
        jobPosts: jobPosts ?? this.jobPosts,
        lookups: lookups ?? this.lookups,
        isLoading: isLoading ?? this.isLoading,
        initialized: initialized ?? this.initialized,
        disposed: disposed ?? this.disposed,
        bookmarkCollections: bookmarkCollections ?? this.bookmarkCollections,
        bookmarkInfos: bookmarkInfos ?? this.bookmarkInfos,
        isProfileBookmark: isProfileBookmark ?? this.isProfileBookmark,
        isAdded: isAdded ?? this.isAdded,
      );
}
