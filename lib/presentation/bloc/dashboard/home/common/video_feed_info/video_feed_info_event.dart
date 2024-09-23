import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';

import '../../../../../../data/models/apis/dashboard/common/highlite_video_feed_info.dart';
import '../../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';

abstract class VideoFeedInfoEvent {
  const VideoFeedInfoEvent();
}

class FetchVideoFeedInfoEvent extends VideoFeedInfoEvent {
  const FetchVideoFeedInfoEvent({
    required this.candidate,
    required this.jobPost,
  });

  final CandidateOnBoarding candidate;
  final CompanyJobPost jobPost;
}

class FetchVideoFeedInfoForCompanyEvent extends VideoFeedInfoEvent {
  const FetchVideoFeedInfoForCompanyEvent({
    required this.candidate,
    required this.jobPost,
  });

  final CandidateOnBoarding candidate;
  final List<CompanyJobPost> jobPost;
}

class LikeVideoFeedEvent extends VideoFeedInfoEvent {
  const LikeVideoFeedEvent();
}

class DislikeVideoFeedEvent extends VideoFeedInfoEvent {
  const DislikeVideoFeedEvent();
}

class LikeVideoFeedForCompanyBatchEvent extends VideoFeedInfoEvent {
  const LikeVideoFeedForCompanyBatchEvent(this.jobPostIds);

  final List<String> jobPostIds;
}

class UnlikeVideoFeedForCompanyBatchEvent extends VideoFeedInfoEvent {
  const UnlikeVideoFeedForCompanyBatchEvent();
}

class UndislikeVideoFeedForCompanyBatchEvent extends VideoFeedInfoEvent {
  const UndislikeVideoFeedForCompanyBatchEvent();
}

class DislikeVideoFeedForCompanyBatchEvent extends VideoFeedInfoEvent {
  const DislikeVideoFeedForCompanyBatchEvent(this.jobPostIds);

  final List<String> jobPostIds;
}

class DislikeVideoFeedForCompanyEvent extends VideoFeedInfoEvent {
  const DislikeVideoFeedForCompanyEvent(this.jobPostId);

  final String jobPostId;
}

class UpdateVideoFeedInfoEvent extends VideoFeedInfoEvent {
  const UpdateVideoFeedInfoEvent(this.info);

  final HighliteVideoFeedInfo info;
}

class UpdateVideoFeedInfoForCompanyEvent extends VideoFeedInfoEvent {
  const UpdateVideoFeedInfoForCompanyEvent(this.info);

  final HighliteVideoFeedInfo info;
}

class EmitVideoFeedInfoEvent extends VideoFeedInfoEvent {
  const EmitVideoFeedInfoEvent(this.info);

  final HighliteVideoFeedInfo info;
}

class EmitVideoFeedInfoForCompanyEvent extends VideoFeedInfoEvent {
  const EmitVideoFeedInfoForCompanyEvent(this.info);

  final HighliteVideoFeedInfo info;
}

class CheckMatchEvent extends VideoFeedInfoEvent {
  const CheckMatchEvent();
}

class CheckMatchForCompanyEvent extends VideoFeedInfoEvent {
  const CheckMatchForCompanyEvent();
}

class SuperMessageEvent extends VideoFeedInfoEvent {
  const SuperMessageEvent({required this.jobPostId, required this.message});

  final String jobPostId;
  final String message;
}

class UnmarkBookmarkFeedEvent extends VideoFeedInfoEvent {
  const UnmarkBookmarkFeedEvent(this.id);

  final String id;
}

class RetrieveBookmarksEvent extends VideoFeedInfoEvent {
  const RetrieveBookmarksEvent();
}
