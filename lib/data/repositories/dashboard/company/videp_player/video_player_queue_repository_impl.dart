import 'package:flutter/material.dart';
import 'package:flutter/src/painting/image_provider.dart';
import 'package:highlite_flutter_mvp/core/constants/video_feed_constants.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/common/video_player/video_player_queue_repository.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/logger.dart';
import 'package:video_player/video_player.dart';

import '../../../../../presentation/widgets/utils/navigation_service.dart';

class VideoPlayerQueueRepositoryImpl implements VideoPlayerQueueRepository{
  @override
  Map<String, VideoPlayerController> controllers  = {};


  @override
  Map<String, ImageProvider<Object>> thumbnails = {};


  @override
  VideoPlayerController? currentRunningVideo;



  @override
  Future<void> enqueue(String playbackId) async {
    logger.logEvent("PRELOADING $playbackId");
    if(controllers[playbackId] == null && thumbnails[playbackId] == null){
      VideoPlayerController videoPlayerController  = VideoPlayerController.networkUrl(
          Uri.parse(VideoFeedConstants.getPlaybackUrl(playbackId: playbackId)));
      NetworkImage imageProvider = NetworkImage(VideoFeedConstants.getThumbnailForHomeFeed(playbackId: playbackId));
   //  await precacheImage(imageProvider, buildContext);
       videoPlayerController.initialize().then((value){

      });
      // await videoPlayerController.initialize() ;
      await videoPlayerController.setLooping(true);
      controllers[playbackId] = videoPlayerController ;
      thumbnails[playbackId] = imageProvider ;
    }

  }

  @override
  VideoPlayerController? getControllerBy(String playbackId) {
     return controllers[playbackId];
  }

  @override
  ImageProvider<Object>? getThumbnailBy(String playbackId) {
    return thumbnails[playbackId];
  }

  @override
  Future<void> play(VideoPlayerController controller) async{
    if(currentRunningVideo !=null && currentRunningVideo != controller){
     await currentRunningVideo!.pause();
    }
    await controller.play() ;
    currentRunningVideo = controller ;

  }

  @override
  Future<void> reset()async {
   for(var keys in controllers.keys){
     logger.logEvent("DISPOSING $keys");
     await controllers[keys]?.dispose() ;
   }
  }



}