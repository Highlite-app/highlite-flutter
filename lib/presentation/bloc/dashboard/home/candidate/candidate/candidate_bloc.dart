import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/common/video_player/video_player_queue_repository.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate/candidate_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/candidate/candidate_state.dart';
import 'package:injectable/injectable.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../core/services/injection_container.dart';
import '../../../../../../domain/repositories/dashboard/common/feed_service/home_feed_state_repository.dart';
import '../../../../../widgets/utils/logger.dart';
import '../../../../../widgets/utils/video_player_utils.dart';

final candidateBloc =  sl.get<CandidateBloc>() ;

@Injectable(as: CandidateBloc)
class CandidateBloc extends Bloc<CandidateEvent , CandidateState>{
  CandidateBloc(): super(CandidateState()){
    on<StartCandidateEvent>(_handleStartCandidate)  ;
    on<PageChangedEvent>(_handlePageChanged)  ;
    on<RetrieveBookmark>((event , emit){
      emit(state.copyWith(
        bookmarkCollection: state.bookmarkCollection,
        bookmarkInfo:state.bookmarkInfo,
      ));
    });
  }


  Future<void> _handleStartCandidate(
      StartCandidateEvent event ,
      Emitter<CandidateState> emit
      ) async {


    if (!state.isInitialized) {

      for(int i =0 ; i< homeFeedState.candidateFeed.take(10).length ; i++){
        final playbackId = homeFeedState.candidateFeed[i].playbackId;
        final controller = homeFeedState.candidateController[playbackId];
        if (controller != null && !controller.value.isInitialized) {
          await controller.initialize();
          await  videoQueue.play(controller) ;
        }
      }
      emit(state.copyWith(
          candidateFeed: homeFeedState.candidateFeed,
          thumbnail: homeFeedState.candidateThumbnails,
          controller: homeFeedState.candidateController,
          bookmarkCollection: homeFeedState.currentUserBookmarkCollectionList,
          bookmarkInfo: homeFeedState.currentUserBookmarkInfoList,
          isInitialized: true
      ));

    }
    logger.logEvent('StartCandidateEvent');

    if (state.controller.isNotEmpty) {
      var lastPlayedController = state.controller.values.elementAt(state.lastPlayedCandidateIndex);
      lastPlayedController.play();
    }

    if (state.controller.isNotEmpty  && state.candidateFeed.isNotEmpty) {
      final  controller = state.controller;
      if(controller !=null ){
      //  videoQueue.play(controller) ;
        for(int i =0 ;  i < controller.length ;i++){
          var currentIndex = state.lastPlayedCandidateIndex ;
          if(i == currentIndex){
            print("Inside start Candidate event");
            controller[state.candidateFeed[currentIndex].playbackId]?.play() ;
          }else {
            controller[state.candidateFeed[currentIndex].playbackId]?.pause() ;
          }
        }
      }

      // var firstController = state.controller.values.first;
      // firstController.play();
      // emit(state.copyWith(lastPlayedForYouIndex: 0));
    }

  }

  Future<void>  _handlePageChanged(
      PageChangedEvent event,
      Emitter<CandidateState> emit,
      ) async {
    final currentPage = event.pageIndex;

    emit(state.copyWith(pageNumber: currentPage));
    emit(state.copyWith(lastPlayedCandidateIndex: currentPage));
    if (currentPage != null) {
      print("Inside pageController Candidate event");
      final controller = state.controller;

      // Ensure the index is within the bounds of the candidate feed list
      if (currentPage >= 0 && currentPage < state.candidateFeed.length) {
        for (int i = 0; i < state.candidateFeed.length; i++) {
          final playbackId = state.candidateFeed[i].playbackId;
          if (controller.containsKey(playbackId)) {
            final videoController  = controller[playbackId] ;
            if (i == currentPage) {

              controller[playbackId]?.play();
            } else {
              controller[playbackId]?.pause();
            }
          } else {
            print("Controller for playbackId $playbackId not found");
          }
        }

        // Update the last played candidate index
      }
    }
  }

}