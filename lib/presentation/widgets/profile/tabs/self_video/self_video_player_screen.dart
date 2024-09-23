import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_bloc.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/dashboard/profile/candidate/candidate_editor_state.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/video_feed/self_video_feed.dart';

import '../../../../../data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import '../../../../pages/navigation/profile/appbar/profile_appbar.dart';

class SelfVideoPlayerScreen extends StatelessWidget {
  final CandidateOnBoarding candidateOnBoarding ;
  final List<CandidateVideoFeed>  candidateVideoFeed ;
  final int index;

   const SelfVideoPlayerScreen({
     required this.candidateOnBoarding ,
    required this.candidateVideoFeed ,
    required this.index, super.key});

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<CandidateEditorBloc , CandidateEditorState>(
      builder: (context , state) {
        return Scaffold(
          appBar:ProfileAppBar(
            username: state.candidateOnBoarding?.username ?? '',
            title: state.candidateOnBoarding?.fullName,
            navigator: context.navigator,
            isPreview: false,
            onPop: (){
              state.selfVideoPlayerController[candidateVideoFeed[index].playbackId]?.pause() ;
            },
            selectedProfileId: "",
          ),
          body: PageView.builder(
             controller: state.profilePageController,
            itemCount: candidateVideoFeed.length,
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            onPageChanged: (page){

            },
            itemBuilder: (context, index) {
              return  SelfVideoFeed(
                controller: state.selfVideoPlayerController[candidateVideoFeed[index].playbackId]!,
                imageProvider: state.selfThumbnail[candidateVideoFeed[index].playbackId]!,
                contents: SelfVideoFeedContents(
                  title: candidateOnBoarding.position ?? '' ,
                  name:  candidateOnBoarding.fullName,
                  description: candidateVideoFeed[index].description,
                ),
                state: const SelfVideoFeedContentState(
                  isFollowing: false,
                  enabledFollowButton: true,
                  enabledActionButtons: true,
                  isSuperMessaged: false,
                  isBookmarked: false,
                  isLiked: true,
                  isDisliked: false,
                  isShared: false,
                ),
              );

            },
          ),
        );
      }
    );
  }
}

