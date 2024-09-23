import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate/candidate_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate/candidate_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/for_you/candidate_for_you_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/logger.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/environment/base_environment.dart';
import '../../../../../data/models/apis/onboarding/bookmark/response/bookmark_collection.dart';
import '../../../../../data/models/apis/onboarding/bookmark/response/bookmark_infos.dart';
import '../../../../../data/models/onboarding/login_with_email_otp_model.dart';
import '../../../../../domain/repositories/dashboard/common/feed_service/home_feed_state_repository.dart';
import '../../../../../domain/repositories/dashboard/common/video_player/video_player_queue_repository.dart';
import '../../../../widgets/utils/video_player_utils.dart';
import 'candidate_home_feed_event.dart';
import 'candidate_home_feed_state.dart';
import 'for_you/candidate_for_you_event.dart';

class CandidateHomeFeedBloc
    extends Bloc<CandidateHomeFeedEvent, CandidateHomeFeedState> {
  CandidateHomeFeedBloc(
      {
        required CandidateForYouBloc candidateForYouBloc,
        required CandidateBloc candidateBloc
} )
      : super(CandidateHomeFeedState()) {
    on<BottomNavTabChanged>(_handleNavigationChange);
    on<HomeFeedTabChange>(_handleHomeFeedTabChange);
  }

  Future<void> _handleNavigationChange(BottomNavTabChanged event,
      Emitter<CandidateHomeFeedState> emit) async {
    List<VideoPlayerController> videoPlayerController;
    List<VideoPlayerController> candidateController;
    print("called BottomNavTabChanged 1");

    videoPlayerController = homeFeedState.forYouController.values.toList();
    candidateController = homeFeedState.candidateController.values.toList();

    if (event.index != 0) {

      for (var controller in videoPlayerController) {
        print("called BottomNavTabChanged 2");
        if (controller.value.isPlaying) {
          controller.pause();
        }
      }

      for (var controller in candidateController) {
        print("called BottomNavTabChanged 0");
        if (controller.value.isPlaying) {
          controller.pause();
        }
      }
    }
  }


  Future<void> _handleHomeFeedTabChange(HomeFeedTabChange event, Emitter<CandidateHomeFeedState> emit) async {
    final candidateForYouState = candidateForYouBloc.state;
    // final candidateJobsState = candidateJobsBloc.state;
    // final candidateFollowingState = candidateFollowingBloc.state;
    final candidateState = candidateBloc.state;

    // Pause all controllers first
    for (var controller in homeFeedState.forYouController.values) {
      if (controller.value.isPlaying) {
        controller.pause();
      }
    }
    for (var controller in homeFeedState.candidateController.values) {
      if (controller.value.isPlaying) {
        controller.pause();
      }
    }
    for (var controller in  homeFeedState.jobsController.values) {
      if (controller.value.isPlaying) {
        controller.pause();
      }
    }
    for (var controller in  homeFeedState.followingControllers.values) {
      if (controller.value.isPlaying) {
        controller.pause();
      }
    }

    // Now play the controllers for the current index
    switch (event.index) {
      case 0:
        candidateBloc.add(StartCandidateEvent()) ;
        var candidateControllers = homeFeedState.candidateController.values.toList();
        var lastPlayedIndex = candidateState.lastPlayedCandidateIndex;
        if (candidateControllers.isNotEmpty) {
          candidateControllers[lastPlayedIndex].play();
        }

        break;
      case 1:
        var jobsControllers =  homeFeedState.jobsController.values.toList();
        var lastPlayedIndex = state.lastPlayedJobsIndex;
        if (jobsControllers.isNotEmpty) {
          jobsControllers[lastPlayedIndex].play();
        }
        break;
      case 2:
       candidateForYouBloc.add(StartCandidateForYouEvent());
       var forYouControllers =  homeFeedState.forYouController.values.toList();
       var lastPlayedIndex = candidateForYouState.lastPlayedForYouIndex ;
       if (forYouControllers.isNotEmpty) {
         forYouControllers[lastPlayedIndex].play();
       }

        break;
      case 3:
        var followingControllers =  homeFeedState.followingControllers.values.toList();
        var lastPlayedIndex = state.lastPlayedFollowingIndex;
        if (followingControllers.isNotEmpty) {
          followingControllers[lastPlayedIndex].play();
        }
        break;
    }

  }
}

