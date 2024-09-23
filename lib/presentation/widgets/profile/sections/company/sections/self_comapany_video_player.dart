import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/company/upload/company_job_post_video_feed.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/company/company_onboarding.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/video_feed/self_video_feed.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../domain/repositories/dashboard/common/video_player/video_player_queue_repository.dart';

class SelfCompanyVideoPlayer extends StatefulWidget {
  CompanyOnboarding companyOnboarding;

  List<CompanyJobPostVideoFeed> companyJobPostVideoFeed;

  final int index;

  SelfCompanyVideoPlayer(
      {required this.companyOnboarding,
      required this.companyJobPostVideoFeed,
      required this.index,
      super.key});

  @override
  _SelfCompanyVideoPlayerState createState() => _SelfCompanyVideoPlayerState();
}

class _SelfCompanyVideoPlayerState extends State<SelfCompanyVideoPlayer> {
  Map<String, VideoPlayerController> selfVideoPlayerController = {};

  @override
  void initState() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: PageView.builder(
        //    controller: _pageController,
        itemCount: widget.companyJobPostVideoFeed.length,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          for (CompanyJobPostVideoFeed companyVideoVideoFeed
              in widget.companyJobPostVideoFeed) {
            videoQueue.enqueue(companyVideoVideoFeed.playbackId);
            setState(() {
              selfVideoPlayerController[
                      widget.companyJobPostVideoFeed[index].playbackId] =
                  videoQueue.getControllerBy(
                      widget.companyJobPostVideoFeed[index].playbackId)!;
            });
          }
          SelfVideoFeed(
            controller: selfVideoPlayerController[
                widget.companyJobPostVideoFeed[index].playbackId]!,
            imageProvider: NetworkImage(''),
            contents: SelfVideoFeedContents(
              title: widget.companyOnboarding.companyName,
              name: widget.companyOnboarding.website,
              description: widget.companyJobPostVideoFeed[index].jobStatus,
            ),
            state: SelfVideoFeedContentState(
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
}
