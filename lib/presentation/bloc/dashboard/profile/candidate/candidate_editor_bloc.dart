import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/domain/repositories/persistent/persistent_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/firebase_service.dart';
import '../../../../../data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import '../../../../../data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import '../../../../../domain/repositories/auth/auth_repository.dart';
import '../../../../../domain/repositories/dashboard/candidate/profile/candidate_profile_repository.dart';
import '../../../../widgets/utils/file.dart';
import '../../auth/authentication_bloc.dart';
import '../../auth/authentication_event.dart';
import 'candidate_editor_event.dart';
import 'candidate_editor_state.dart';

@injectable
class CandidateEditorBloc
    extends Bloc<CandidateEditorEvent, CandidateEditorState> {
  CandidateEditorBloc({
    required CandidateOnBoarding? candidate,
    List<CandidateVideoFeed>? videoFeed,
  }) : super(
          CandidateEditorState(
              candidateOnBoarding:
                  candidate ?? CandidateOnBoarding.defaultOnboarding(),
              candidateVideFeed: videoFeed ?? []),
        ) {
    on<CandidateEditorStartEvent>(
      (event, emit) async {
        emit(state.copyWith(
            selfVideoPlayerController:
                candidateProfileService.selfVideoPlayerController,
            selfThumbnail: candidateProfileService.selfVideoPlayerThumbnail));

        // if (state.videoUrl != null) {
        //   emit(state.copyWith(
        //     videoForUrl: await VideoFeedConstants.getPlaybackVideo(
        //       playbackUrl: videoFeed!.playbackId,
        //     ),
        //   ));
        // }
      },
    );
    on<UpdateCandidateEvent>(_handleUpdateCandidate);
    on<ChangeProfilePictureEvent>(_handleUpdateProfile);
    // on<AttachVideoEvent>(_handleAttachVideo);

    // Feature: WORK SCREEN EDITOR
  }

  Future<void> _handleUpdateCandidate(
    UpdateCandidateEvent event,
    Emitter<CandidateEditorState> emit,
  ) async {
    final persisted = await persistenceService.get();
    final id = persisted?.id;
    final userType = persisted?.userType;
    final updatedCandidate = await candidateProfileService
        .updateCandidateProfile(event.candidate, id ?? '');

    authService.candidateOnBoarding = updatedCandidate;
    //
    // authentication
    //     .add(AuthenticateOnboardingEvent(id ?? '', userType ?? ''));
    authentication.add(const AuthenticateCandidateEvent());

    emit(state.copyWith(candidateOnBoarding: updatedCandidate));
  }

  Future<void> _handleUpdateProfile(
    ChangeProfilePictureEvent event,
    Emitter<CandidateEditorState> emit,
  ) async {
    FileImage? profileImage =
        await FileManager().takePhotoAndPreview(ImageSource.gallery);

    if (profileImage != null) {
      final file = File(profileImage.file.path);
      var url = await FirebaseService.storeImageInFirebaseStorage(file);

      final persisted = await persistenceService.get();

      authService.candidateOnBoarding =
          authService.candidateOnBoarding?.copyWith(
        profilePicture: url,
      );
      authentication.add(const AuthenticateCandidateEvent());
      add(UpdateCandidateEvent(
          candidate: state.candidateOnBoarding.copyWith(profilePicture: url)));
    }
  }
}
