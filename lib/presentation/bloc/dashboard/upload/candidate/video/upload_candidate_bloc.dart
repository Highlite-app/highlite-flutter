import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/constants/video_feed_constants.dart';
import 'package:highlite_flutter_mvp/data/models/apis/authentication/persisted_user.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/video/mux_response.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/persistent/persistent_repository.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/auth/authentication_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate/candidate_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/video/upload_candidate_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/upload/candidate/video/upload_candidate_state.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/search/candidate/initial_filter_search.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

import '../../../../../../app.dart';
import '../../../../../../core/resources/asset_constants.dart';
import '../../../../../../core/services/injection_container.dart';
import '../../../../../../data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import '../../../../../../data/models/onboarding/file_model.dart';
import '../../../../../../domain/repositories/dashboard/candidate/upload/upload_video_repository.dart';
import '../../../../../pages/dashboard/candidate_dashboard.dart';
import '../../../../../widgets/indicator/upload_indicator.dart';
import '../../../../../widgets/toaster/toast_alert.dart';
import '../../../../../widgets/utils/file.dart';
import '../../../../../widgets/utils/thumnail_generator.dart';
import '../../../../toast/toast_bloc.dart';
import '../../../../toast/toast_event.dart';
import '../../../auth/authentication_event.dart';

//  uploadCandidateBloc = sl<UploadCandidateBloc>();

class UploadCandidateBloc
    extends Bloc<UploadCandidateEvent, UploadCandidateState> {
  UploadCandidateBloc() : super(UploadCandidateState()) {
   // on<StartUploadCandidate>(_handleStartUpload);
    on<PickVideoEvent>(_handlePickVideo);
    on<UpdateThumbnailEvent>(_handleUpdateThumbnail);
    on<UpdateDescriptionEvent>(_handleUpdateDescription);
    on<UploadVideoEvent>(_handleUploadVideo);
    on<UpdateTagsEvent>(_handleUpdateTags);
    on<UpdateCategoryEvent>(_handleUpdateCategory);
    on<UploadCandidateVideoFeedEvent>(_handleUploadCandidateVideoFeed);
    on<OnBackButtonEvent>(_handleOnBackButton);
    on<ResetIsVideoStateEvent>(_handleResetVideo);
  }

  Future<void> _handleStartUpload(
    StartUploadCandidate event,
    Emitter<UploadCandidateState> emit,
  ) async {

    // emit(state.copyWith(isVideo: true)) ;
    // FileModel? saveVideo = await FileManager().pickVideoWithModel(ImageSource.camera);
    // if (saveVideo != null && saveVideo.file != null) {
    //
    //   // Print the original file path for debugging
    //   print('Original video path: ${saveVideo.file?.path}');
    //
    //   File videoToUpload = saveVideo.file!; // Default to the original video file
    //
    //   try {
    //     // Attempt to compress the video
    //     final info = await VideoCompress.compressVideo(
    //       saveVideo.file!.path,
    //       quality: VideoQuality.LowQuality,
    //       deleteOrigin: false,
    //       includeAudio: true,
    //     );
    //
    //     // Check if compression was successful
    //     if (info != null && info.file != null && info.file!.existsSync()) {
    //       print('Compression successful: ${info.path}');
    //       videoToUpload = info.file!;
    //       logger.logEvent("The info is after compressed ${info.path}");
    //     } else {
    //       print('Compression failed or was cancelled. Using original video.');
    //     }
    //   } catch (e) {
    //     print('Error during video compression: $e');
    //     print('Using original video instead.');
    //   }
    //
    //   // Proceed with the selected video (compressed or original)
    //   add(PickVideoEvent(video: videoToUpload));
    //   emit(state.copyWith(isUpload: true)) ;
    //
    // } else {
    //   print('Error: No video was selected or video file is invalid.');
    // }


  }

  Future<void> _handleResetVideo(
      ResetIsVideoStateEvent event, Emitter<UploadCandidateState> emit) async {
    emit(   state.copyWith(
        isUpload: false,
        thumbnailUrl: '',
        muxResponse: null,
        salary: '',
        tags: [],
        category: [],
        descriptionController: TextEditingController(),
        pickVideo: File(''))) ;

  }

  Future<void> _handleUploadVideo(
      UploadVideoEvent event, Emitter<UploadCandidateState> emit) async {
    emit(state.copyWith(isVideo: event.isVideo));
  }

  Future<void> _handleOnBackButton(
      OnBackButtonEvent event, Emitter<UploadCandidateState> emit) async {
    emit(state.copyWith(isVideo: !state.isVideo));
  }

  Future<void> _handleUpdateTags(
      UpdateTagsEvent event, Emitter<UploadCandidateState> emit) async {
    final List<String> selectedTags = event.selectedTags;
    emit(state.copyWith(tags: selectedTags));
    logger.logEvent("Selected Candidate Tags: ${state.tags}");
  }

  Future<void> _handleUploadCandidateVideoFeed(
      UploadCandidateVideoFeedEvent event,
      Emitter<UploadCandidateState> emit) async {
    if (state.muxResponse == null ||
        state.muxResponse!.uploadId.isEmpty ||
        state.muxResponse!.assertId.isEmpty ||
        state.muxResponse!.playbackId.isEmpty) {
      toaster.add(
        const ShowToastEvent(
          text:
              "Mux response data is not ready yet. Please wait for the video to finish uploading..",
          icon: AssetConstant.xIcon,
          state: ToastState.error,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
    final persisted = await persistenceService.get();
    final candidateId = persisted?.id;
    final userType = persisted?.userType;

    if (candidateId == null && userType == null) return;

    Map<String, dynamic> candidateVideoFeed = {
      'candidateVideoFeedId': "",
      'candidateId': (authService.getUserID() == '')
          ? candidateId
          : authService.getUserID(),
      'description': state.descriptionController.text,
      'thumbnailUrl': VideoFeedConstants.getThumbnailForHomeFeed(playbackId: state.muxResponse?.playbackId ?? ''),
      'thumbnailWidth': state.thumbnailWidth,
      'thumbnailHeight': state.thumbnailHeight,
      'playbackId': state.muxResponse?.playbackId ?? '',
      'assetId': state.muxResponse?.assertId,
      'uploadId': state.muxResponse?.uploadId,
      'tag': state.tags,
      'category': state.category,
    };

    try {
      // Call your API to upload candidate video feed
      await candidateVideoService.uploadCandidateVideoFeed(
          CandidateVideoFeed.fromJson(candidateVideoFeed));

      authentication.add(AuthenticateOnboardingEvent(candidateId ?? '', userType ?? ''));

      emit(state.copyWith(isUpload: true)) ;

    } catch (e) {
      logger.logEvent("Failed to upload candidate video feed: $e");
    }
  }

  Future<void> _handleUpdateCategory(
      UpdateCategoryEvent event, Emitter<UploadCandidateState> emit) async {
    final List<String> selectedCategory = event.category;
    emit(state.copyWith(category: selectedCategory));
    logger.logEvent("Selected Candidate Category: ${state.category}");
  }

  // void _handleToggleVideo(
  //     ToggleVideoEvent event, Emitter<UploadCandidateState> emit) {
  //   emit(state.copyWith(isVideo: !state.isVideo));
  // }

  void _handlePickVideo(
      PickVideoEvent event, Emitter<UploadCandidateState> emit) async {
    emit(state.copyWith(pickVideo: event.video));
    String generatedThumbnail =
        await ThumbnailGenerator().generateThumbnail(event.video);
    emit(state.copyWith(thumbnailUrl: generatedThumbnail));
    MuxResponse muxResponse =
        await candidateVideoService.uploadCandidateVideoToMux(event.video);
    emit(state.copyWith(muxResponse: muxResponse));
    // String thumbnail  = VideoFeedConstants.getThumbnailForProfile(playbackId: muxResponse.playbackId) ;
    // emit(state.copyWith(thumbnailUrl: thumbnail)) ;
  }

  void _handleUpdateThumbnail(
      UpdateThumbnailEvent event, Emitter<UploadCandidateState> emit) {
    emit(state.copyWith(thumbnailUrl: event.thumbnailUrl));
  }

  void _handleUpdateDescription(
      UpdateDescriptionEvent event, Emitter<UploadCandidateState> emit) {
    state.descriptionController.text = event.description;
    emit(state.copyWith(descriptionController: state.descriptionController));
  }
}
