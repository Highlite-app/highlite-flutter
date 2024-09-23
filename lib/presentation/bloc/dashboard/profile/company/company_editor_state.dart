import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post_video_feed.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:video_player/video_player.dart';

import '../../../../../data/models/onboarding/file_model.dart';

class CompanyEditorState {
  CompanyEditorState({
    required this.companyProfile,
    required this.companyJobPosts,
    required this.companyJobPostVideoFeed,
    this.videoUrl,
    this.videoFile,
    this.videoForUrl,
    this.videoForFile,
    this.newVideoForFile,
    this.editVideoForUrl,
    this.isUploading = false,
    this.isUploadInProgress = false,
    this.isFilePickerEmpty = false,
    this.newJobVideoFeedId,
    this.fileNameToUpload,
  });

  final CompanyOnboarding companyProfile;
  final List<CompanyJobPost> companyJobPosts;
  final List<CompanyJobPostVideoFeed> companyJobPostVideoFeed;
  final String? newJobVideoFeedId;
  final String? videoUrl;
  final FileModel? videoFile;
  final VideoPlayerController? videoForUrl;
  final VideoPlayerController? videoForFile;
  final VideoPlayerController? newVideoForFile;
  final VideoPlayerController? editVideoForUrl;
  final bool isUploading;
  final bool isUploadInProgress;
  final bool isFilePickerEmpty;
  final String? fileNameToUpload;

  CompanyEditorState copyWith({
    CompanyOnboarding? companyProfile,
    List<CompanyJobPost>? companyJobPosts,
    List<CompanyJobPostVideoFeed>? companyJobPostVideoFeed,
    String? newJobVideoFeedId = "",
    String? videoUrl,
    FileModel? videoFile,
    VideoPlayerController? videoForUrl,
    VideoPlayerController? videoForFile,
    VideoPlayerController? newVideoForFile,
    VideoPlayerController? editVideoForUrl,
    bool? isUploading,
    bool? isFilePickerEmpty,
    bool? isUploadInProgress,
    String? fileNameToUpload,
  }) =>
      CompanyEditorState(
        companyProfile: companyProfile ?? this.companyProfile,
        companyJobPosts: companyJobPosts ?? this.companyJobPosts,
        companyJobPostVideoFeed:
            companyJobPostVideoFeed ?? this.companyJobPostVideoFeed,
        newJobVideoFeedId: newJobVideoFeedId,
        videoUrl: videoUrl,
        videoFile: videoFile,
        videoForUrl: videoForUrl,
        videoForFile: videoForFile,
        newVideoForFile: newVideoForFile,
        editVideoForUrl: editVideoForUrl,
        isUploading: isUploading ?? this.isUploading,
        isUploadInProgress: isUploadInProgress ?? this.isUploadInProgress,
        isFilePickerEmpty: isFilePickerEmpty ?? this.isFilePickerEmpty,
        fileNameToUpload: fileNameToUpload ?? this.fileNameToUpload,
      );
}
