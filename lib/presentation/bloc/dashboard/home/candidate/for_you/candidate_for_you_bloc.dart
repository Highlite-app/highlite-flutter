import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/environment/base_environment.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/common/feed_service/home_feed_state_repository.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/for_you/candidate_for_you_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/home/candidate/for_you/candidate_for_you_state.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../core/services/injection_container.dart';
import '../../../../../widgets/utils/video_player_utils.dart';

final candidateForYouBloc = sl<CandidateForYouBloc>() ;


@Injectable()
class CandidateForYouBloc  extends Bloc<CandidateForYouEvent , CandidateForYouState>{
  CandidateForYouBloc(): super(CandidateForYouState()) {
    on<StartCandidateForYouEvent>(_handleStartCandidateForYou)  ;
    on<PageChangedEvent>(_handlePageChanged)  ;
  }

  Future<void> _handleStartCandidateForYou(
      StartCandidateForYouEvent event ,
      Emitter<CandidateForYouState> emit
      ) async {
    if (!state.isInitialized) {
      emit(state.copyWith(
        forYouFeed: homeFeedState.companyForYouFeed,
        thumbnail: homeFeedState.forYouThumbnails,
        controller: homeFeedState.forYouController,
        isInitialized: true
      ));

    }
        logger.logEvent('StartCandidateForYouEvent');

    if (state.controller.isNotEmpty) {
      var lastPlayedController = state.controller.values.elementAt(state.lastPlayedForYouIndex);
      lastPlayedController.play();
    }

      if (state.controller.isNotEmpty ) {
        List<VideoPlayerController> controller = state.controller.values.toList() ;
        for(int i =0 ;  i < controller.length ;i++){
          var currentIndex = state.lastPlayedForYouIndex ;
          if(i == currentIndex){
            print("Inside start for you event");
            controller[i].play() ;
          }else {
            controller[i].pause() ;
          }
        }
        // var firstController = state.controller.values.first;
        // firstController.play();
        // emit(state.copyWith(lastPlayedForYouIndex: 0));
      }
      state.pageController.addListener(() {
        final pageIndex = state.pageController.page?.round();
        if (pageIndex != null) {
          print("Inside pageController for you event");

          VideoPlayerUtil.handleVideoPlyingOnPageChange(videoPlayerController: state.controller.values.toList(), pageIndex: pageIndex) ;
        }
      });
    }

  Future<void>  _handlePageChanged(
      PageChangedEvent event,
      Emitter<CandidateForYouState> emit,
      ) async {
    final currentPage = event.pageIndex;

    emit(state.copyWith(pageNumber: currentPage));
    emit(state.copyWith(lastPlayedForYouIndex: currentPage));
  }




  }


