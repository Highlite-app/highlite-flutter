import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post_video_feed.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/company/profile/company_profile_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/resources/l10n/translation_key.dart';
import '../../../../../core/services/firebase_service.dart';
import '../../../../../data/models/apis/dashboard/cadidate/profile/id_request.dart';
import '../../../../../data/models/s3_bucket/presigner/get_presigned_url_without_client.dart';
import '../../../../../data/models/toast/progress_indicator.dart';
import '../../../../../data/repositories/s3_bucket/presigner_types.dart';
import '../../../../../domain/repositories/auth/auth_repository.dart';
import '../../../../../domain/repositories/dashboard/common/feed_service/home_feed_state_repository.dart';
import '../../../../../domain/repositories/dashboard/common/feed_service/video_feed_integrated_repository.dart';
import '../../../../../domain/repositories/dashboard/company/home/company_job_post_repository.dart';
import '../../../../../domain/repositories/dashboard/company/home/company_job_post_video_feed_repository.dart';
import '../../../../../domain/repositories/integrated_uploader/http_uploader_repository.dart';
import '../../../../../domain/repositories/integrated_uploader/integrated_uploader_repository.dart';
import '../../../../../domain/repositories/persistent/persistent_repository.dart';
import '../../../../../domain/repositories/s3_bucket/presigned_respository.dart';
import '../../../../widgets/toaster/toast_alert.dart';
import '../../../../widgets/utils/file.dart';
import '../../../toast/toast_bloc.dart';
import '../../../toast/toast_event.dart';
import '../../../upload_handler/upload_handler_builder.dart';
import '../../../upload_handler/upload_handler_event.dart';
import '../../auth/authentication_bloc.dart';
import '../../auth/authentication_event.dart';
import 'company_editor_event.dart';
import 'company_editor_state.dart';

@injectable
class CompanyEditorBloc extends Bloc<CompanyEditorEvent, CompanyEditorState> {
  CompanyEditorBloc({
    required CompanyOnboarding companyOnboarding,
    required List<CompanyJobPost> companyJobPosts,
    required List<CompanyJobPostVideoFeed> companyJobPostVideoFeed,
  }) : super(CompanyEditorState(
      companyProfile: companyOnboarding,
      companyJobPosts: companyJobPosts,
      companyJobPostVideoFeed: companyJobPostVideoFeed)) {
    on<UpdateCompanyEvent>(_handleUpdateCompany);
    on<ChangeCompanyProfilePictureEvent>(_handleUpdateCompanyProfile);
  }

  Future<void> _handleUpdateCompany(UpdateCompanyEvent event,
      Emitter<CompanyEditorState> emit,) async {
    final persisted = await persistenceService.get();
    final id = persisted?.id;
    final updatedCompanyProfile = await companyProfileService
        .updateCompanyOnboarding(event.companyProfile, id ?? '');
    emit(state.copyWith(companyProfile: event.companyProfile));
    authentication.add(const AuthenticateCompanyEvent());

    authService.companyOnboarding = updatedCompanyProfile;
    //
    // authentication
    //     .add(AuthenticateOnboardingEvent(id ?? '', userType ?? ''));
    authentication.add(const AuthenticateCompanyEvent());

    emit(state.copyWith(companyProfile: updatedCompanyProfile));
  }


  Future<void> _handleUpdateCompanyProfile(
      ChangeCompanyProfilePictureEvent event,
      Emitter<CompanyEditorState> emit,) async {
    FileImage? profileImage =
    await FileManager().takePhotoAndPreview(ImageSource.gallery);

    if (profileImage != null) {
      final file = File(profileImage.file.path);
      var url = await FirebaseService.storeImageInFirebaseStorage(file);


      authService.companyOnboarding =
          authService.companyOnboarding?.copyWith(
            companyLogo: url,
          );
      authentication.add(const AuthenticateCompanyEvent());
      add(UpdateCompanyEvent(
          companyProfile: state.companyProfile.copyWith(companyLogo: url)));
    }

    Future<void> _handleAttachVideo(AttachCompanyVideoEvent event,
        Emitter<CompanyEditorState> emit,) async {
      if (event.fileToUpload != null) {
        final VideoPlayerController controller = VideoPlayerController.file(
          event.fileToUpload!.file!,
        );
        await controller.setLooping(true);
        await controller.initialize();
        if (controller.value.duration.inSeconds <= 180 &&
            controller.value.duration.inSeconds >= 15) {
          emit(state.copyWith(
              videoFile: event.fileToUpload,
              videoForFile: controller,
              newVideoForFile: controller,
              isUploadInProgress: true,
              isFilePickerEmpty: true,
              newJobVideoFeedId: event.jobVideoFeedId));
          add(const UploadVideoEvent());
        } else {
          toaster.add(
            const ShowToastEvent(
              text: TranslationKeys.invalidVideoDuration,
              state: ToastState.warning,
              duration: const Duration(seconds: 5),
            ),
          );
        }
      } else {
        state.videoForFile?.dispose();
        state.videoForUrl?.dispose();
        emit(state.copyWith(
            isFilePickerEmpty: false,
            videoFile: null,
            videoForFile: null,
            videoUrl: null,
            videoForUrl: null));
      }
    }

    Future<void> _handleUploadVideo(UploadVideoEvent event,
        Emitter<CompanyEditorState> emit,) async {
      if (state.videoFile != null) {
        final response = await integratedUploader.uploadIntegratedToToast(
          key: "Video",
          file: state.videoFile!.file!,
          extension: "mov",
          bucket: PresignerTypes.video,
          startPlaceholder: TranslationKeys.uploadingVideo,
          progressPlaceholder: TranslationKeys.uploadingVideo,
          completedPlaceholder: TranslationKeys.uploadVideoCompleted,
          autoClose: true,
        );

        final VideoPlayerController controller =
        VideoPlayerController.network(response.urlFragments.first);
        await controller.setLooping(true);
        await controller.initialize();
        emit(
          state.copyWith(
            videoUrl: response.urlFragments.first,
            videoForUrl: controller,
            videoFile: null,
            videoForFile: controller,
            newVideoForFile: controller,
            isFilePickerEmpty: true,
            fileNameToUpload: response.fileName,
            isUploadInProgress: false,
          ),
        );
      }
    }

    Future<void> _handleFileVideoEmpty(FileVideoEmptyEvent event,
        Emitter<CompanyEditorState> emit,) async {
      emit(state.copyWith(isFilePickerEmpty: true));
    }

    Future<void> _handleSaveVideo(SaveVideoEvent event,
        Emitter<CompanyEditorState> emit,) async {
      int activeCount = state.companyJobPosts
          .where((element) => element.status == TranslationKeys.active)
          .toList()
          .length;

      //  final canJobPost = await userSubStorage.isValidForJobPosting(activeCount);

      // TODO: NEED TO ADD canJobPost once userSubsStorage is created
      if ((event.jobPostItem.status == TranslationKeys.active) ||
          event.jobPostItem.status == TranslationKeys.inactive ||
          event.jobPostItem.status == TranslationKeys.draft) {
        CompanyJobPost oldItem = event.jobPostItem;

        String oldStatus = event.jobPostItem.status;

        CompanyJobPost newItem =
        event.jobPostItem.copyWith(status: "Pending");

        final items = state.companyJobPosts;
        items.add(newItem);

        emit(state.copyWith(
          companyJobPosts: items,
        ));

        RetrieveJobPostListEvent(companyProfile: state.companyProfile);

        CompanyJobPostVideoFeed videoFeedItem =
        await videoFeedIntegratedService.createVideoFeedForCompanyJobPost(
            state.fileNameToUpload!, state.newJobVideoFeedId);

        if (state.newJobVideoFeedId!.isNotEmpty) {} else {
          final idResponse =
          await companyJobPostVideoFeedService.createCompanyJobPostVideoFeed(
              videoFeedItem.copyWith(companyId: event.jobPostItem.companyId));
          videoFeedItem = videoFeedItem.copyWith(id: idResponse.id);

          final videoItems = state.companyJobPostVideoFeed;

          videoItems.add(videoFeedItem.copyWith(id: idResponse.id));

          emit(state.copyWith(
            // companyJobPostVideoFeed: videoItems,
              newJobVideoFeedId: videoItems.last.jobVideoFeedId));

          CompanyJobPost newJobPostItem =
          // event.jobPostItem.copyWith(jobVideoFeedID: state.newJobVideoFeedId);
          oldItem.copyWith(
              jobVideoFeedID: state.newJobVideoFeedId, status: oldStatus);

          add(
            CreateJobPostEvent(
              // jobPostItem: newJobPostItem
              jobPostItem: newJobPostItem,
            ),
          );
          // }
          // emit(state.copyWith(newJobVideoFeedId: ""));
        }
      } else {
        toaster.add(
          ShowToastEvent(
            title: "Insufficient Job Posting",
            text: "You have 0 job post available.",
            icon: "insufficient-job-posting",
            link: "Tap here to buy more.",
            linkAction: () {
              // dashboardNavKey.currentState?.push(
              //   MaterialPageRoute(
              //     builder: (_) => const UpgradeSubscriptionPage(),
              //   ),
              // );
            },
            state: ToastState.insufficientAlert,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }

    Future<void> _handleDeleteVideo(DeleteVideoEvent event,
        Emitter<CompanyEditorState> emit,) async {
      state.videoForFile?.dispose();
      state.videoForUrl?.dispose();

      emit(state.copyWith(
          fileNameToUpload: "",
          newJobVideoFeedId: "",
          editVideoForUrl: null,
          isFilePickerEmpty: true,
          videoFile: null,
          videoForFile: null,
          videoUrl: null,
          videoForUrl: null));
    }

    Future<void> _handleRetrieveNetworkVideo(RetrieveNetworkVideoEvent event,
        Emitter<CompanyEditorState> emit,) async {
      List<CompanyJobPost> companyJobPosts = state.companyJobPosts;

      if (companyJobPosts.isNotEmpty) {
        String videoFeedId = companyJobPosts[event.itemIndex].jobVideoFeedId;
        List<CompanyJobPostVideoFeed> videoItems =
            state.companyJobPostVideoFeed;

        if (videoItems.isNotEmpty) {
          CompanyJobPostVideoFeed feed =
          videoItems.firstWhere((item) => item.jobVideoFeedId == videoFeedId);

          // ignore: unnecessary_null_comparison
          if (feed != null) {
            String playbackId = feed.playbackId;
            if (playbackId.isNotEmpty) {
              String uri = "https://stream.mux.com/$playbackId.m3u8";

              final VideoPlayerController controller =
              VideoPlayerController.network(uri);

              await controller.setLooping(true);
              await controller.initialize();
              emit(
                state.copyWith(
                  editVideoForUrl: controller,
                ),
              );
            } else {
              emit(
                state.copyWith(
                  editVideoForUrl: null,
                ),
              );
            }
          } else {
            emit(
              state.copyWith(
                editVideoForUrl: null,
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              editVideoForUrl: null,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            editVideoForUrl: null,
          ),
        );
      }
    }


    Future<void> _handleCreateJobPost(CreateJobPostEvent event,
        Emitter<CompanyEditorState> emit,) async {
      final idResponse =
      await companyJobPostService.createCompanyJobPosting(event.jobPostItem);
      final items = state.companyJobPosts;
      // items.add(event.jobPostItem.copyWith(id: idResponse.id));
      items.last = event.jobPostItem
          .copyWith(companyId: idResponse.id, status: event.jobPostItem.status);

      // await userSubStorage.consumeJobPosting();

      final videoItems = state.companyJobPostVideoFeed;

      CompanyJobPostVideoFeed videoFeedItem =
      videoItems.last.copyWith(companyId: event.jobPostItem.companyId);
      videoItems.last = videoFeedItem;

      await videoFeedIntegratedService.updateLastVideoFeedForCompanyJobPost(
          videoItems.last.copyWith(companyId: event.jobPostItem.companyId));

      // emit(state.copyWith(companyJobPosts: items, newJobVideoFeedId: ""));
      await homeFeedState.listCompanyJobPosting();

      state.videoForFile?.dispose();
      state.videoForUrl?.dispose();

      emit(state.copyWith(
          companyJobPosts: items,
          companyJobPostVideoFeed: videoItems,
          fileNameToUpload: "",
          newJobVideoFeedId: "",
          isFilePickerEmpty: true,
          videoFile: null,
          videoForFile: null,
          videoUrl: null,
          videoForUrl: null));
      RetrieveJobPostListEvent(companyProfile: state.companyProfile);
    }


    Future<void> _handleUpdateJobPost(UpdateJobPostEvent event,
        Emitter<CompanyEditorState> emit,) async {
      int activeCount = state.companyJobPosts
          .where((element) => element.status == TranslationKeys.active)
          .toList()
          .length;

      // final canJobPost = await userSubStorage.isValidForJobPosting(activeCount);

      if ((event.jobPostItem.status == TranslationKeys.active) ||
          event.jobPostItem.status == TranslationKeys.inactive ||
          event.jobPostItem.status == TranslationKeys.draft) {
        final items = state.companyJobPosts;
        final index =
        items.indexWhere((element) =>
        element.jobPostId == event.jobPostItem.jobVideoFeedId);
        items[index] = event.jobPostItem;
        emit(
          state.copyWith(
            companyJobPosts: items,
          ),
        );
        final result = await companyJobPostService
            .updateCompanyJobPosting(event.jobPostItem);
        items[index] = result;
        await homeFeedState.listCompanyJobPosting();
        emit(
          state.copyWith(
            companyJobPosts: items,
          ),
        );
      } else {
        toaster.add(
          ShowToastEvent(
            title: "Insufficient Job Posting",
            text: "You have 0 job post available.",
            icon: "insufficient-job-posting",
            link: "Tap here to buy more.",
            linkAction: () {
              // dashboardNavKey.currentState?.push(
              //   MaterialPageRoute(
              //     builder: (_) => const UpgradeSubscriptionPage(),
              //   ),
              // );
            },
            state: ToastState.insufficientAlert,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }

    Future<void> _handleCancelJobPost(CancelJobPostEvent event,
        Emitter<CompanyEditorState> emit,) async {
      emit(state.copyWith(newJobVideoFeedId: ""));
    }

    Future<void> _handleAttachEditVideo(AttachEditCompanyVideoEvent event,
        Emitter<CompanyEditorState> emit,) async {
      if (event.fileToUpload != null) {
        List<CompanyJobPost> companyJobPosts = state.companyJobPosts;
        List<CompanyJobPostVideoFeed> videoItems = [];
        CompanyJobPostVideoFeed? existingVideo;

        if (companyJobPosts.isNotEmpty) {
          String videoFeedId = companyJobPosts[event.itemIndex].jobVideoFeedId;

          videoItems = state.companyJobPostVideoFeed;
          existingVideo = videoItems.firstWhere((item) =>
          item.jobVideoFeedId ==
              videoFeedId);
        }

        final VideoPlayerController controller = VideoPlayerController.file(
          event.fileToUpload!.file!,
        );
        await controller.setLooping(true);
        await controller.initialize();
        if (controller.value.duration.inSeconds <= 180 &&
            controller.value.duration.inSeconds >= 15) {
          emit(state.copyWith(
            videoFile: event.fileToUpload,
            editVideoForUrl: controller,
            isUploadInProgress: true,
          ));
          add(UploadhEditCompanyVideoEvent(jobPostVideoItem: existingVideo!));
        } else {
          toaster.add(
            const ShowToastEvent(
              text: TranslationKeys.invalidVideoDuration,
              state: ToastState.warning,
              duration: Duration(seconds: 5),
            ),
          );
        }
      } else {
        state.videoForFile?.dispose();
        state.videoForUrl?.dispose();
        emit(state.copyWith(
            editVideoForUrl: null,
            videoFile: null,
            videoForFile: null,
            videoUrl: null,
            videoForUrl: null));
      }
    }

    Future<void> _handleUploadEditVideo(UploadhEditCompanyVideoEvent event,
        Emitter<CompanyEditorState> emit,) async {
      if (state.videoFile != null) {
        final response = await integratedUploader.uploadIntegratedToToast(
          key: "Video",
          file: state.videoFile!.file!,
          extension: "mov",
          bucket: PresignerTypes.video,
          startPlaceholder: TranslationKeys.uploadingVideo,
          progressPlaceholder: TranslationKeys.uploadingVideo,
          completedPlaceholder: TranslationKeys.uploadVideoCompleted,
          autoClose: true,
        );

        final VideoPlayerController controller =
        VideoPlayerController.network(response.urlFragments.first);

        add(SaveVideoEditEvent(
            jobPostVideoItem: event.jobPostVideoItem,
            controller: controller,
            fileNameToUpload: response.fileName));
      }
    }

    Future<void> _handleSaveEditVideo(SaveVideoEditEvent event,
        Emitter<CompanyEditorState> emit,) async {
      toaster.add(
        const ShowToastEvent(
          text: "We're processing this video. Please wait..",
          state: ToastState.warning,
          duration: Duration(seconds: 35),
        ),
      );

      CompanyJobPostVideoFeed videoFeedItem =
      await videoFeedIntegratedService.createEditVideoFeedForCompanyJobPost(
          event.fileNameToUpload, event.jobPostVideoItem);
      CompanyJobPostVideoFeed updateFeed =
      await companyJobPostVideoFeedService
          .updateCompanyJobPostVideoFeed(videoFeedItem);

      await event.controller.setLooping(true);
      await event.controller.initialize();

      final videoItems = state.companyJobPostVideoFeed;

      videoItems[videoItems.indexWhere((item) =>
      item.jobVideoFeedId == updateFeed.jobVideoFeedId)] =
          updateFeed;
      await homeFeedState.listCompanyJobPosting();
      emit(state.copyWith(
        editVideoForUrl: event.controller,
        videoFile: null,
        companyJobPostVideoFeed: videoItems,
        isUploadInProgress: false,
      ));
    }

    Future<void> _handleDeleteEditVideo(DeleteVideoEditEvent event,
        Emitter<CompanyEditorState> emit,) async {
      toaster.add(
        const ShowToastEvent(
          text: "We're deleting this video. Please wait..",
          state: ToastState.warning,
          duration: Duration(seconds: 5),
        ),
      );

      List<CompanyJobPost> companyJobPosts = state.companyJobPosts;
      List<CompanyJobPostVideoFeed> videoItems = [];
      CompanyJobPostVideoFeed? existingVideo;

      if (companyJobPosts.isNotEmpty) {
        String videoFeedId = companyJobPosts[event.itemIndex].jobVideoFeedId;

        videoItems = state.companyJobPostVideoFeed;
        existingVideo =
            videoItems.firstWhere((item) => item.jobVideoFeedId == videoFeedId);
      }

      CompanyJobPostVideoFeed updateFeed =
      await companyJobPostVideoFeedService.updateCompanyJobPostVideoFeed(
          existingVideo!.copyWith(
              assetId: "",
              playbackId: "",
              uploadId: "",
              jobStatus: "Inactive"));

      CompanyJobPostVideoFeed result = await videoFeedIntegratedService
          .updateLastVideoFeedForCompanyJobPost(updateFeed);

      CompanyJobPost post = companyJobPosts[companyJobPosts
          .indexWhere((item) =>
      item.jobVideoFeedId == updateFeed.jobVideoFeedId)]
          .copyWith(status: "Inactive");

      CompanyJobPost resultPost =
      await companyJobPostService.updateCompanyJobPosting(post);

      companyJobPosts[companyJobPosts.indexWhere(
              (item) => item.jobVideoFeedId == updateFeed.jobVideoFeedId)] =
          resultPost;

      videoItems[videoItems.indexWhere((item) =>
      item.jobVideoFeedId == updateFeed.jobVideoFeedId)] =
          result;

      await homeFeedState.listCompanyJobPosting();
      state.videoForFile?.dispose();
      state.videoForUrl?.dispose();

      emit(state.copyWith(
          companyJobPostVideoFeed: videoItems,
          companyJobPosts: companyJobPosts,
          fileNameToUpload: "",
          newJobVideoFeedId: "",
          editVideoForUrl: null,
          isFilePickerEmpty: true,
          videoFile: null,
          isUploadInProgress: false,
          videoForFile: null,
          videoUrl: null,
          videoForUrl: null));
    }
  }
}
