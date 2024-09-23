import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

abstract class VideoPLayerQueueRepository {
  late Map<String , ImageProvider> thumbnails ;
  late Map<String, VideoPlayerController>  controllers  ;
  late VideoPlayerController? currentRunningVideo ;
  Future<void> reset() ;
  Future<void> enqueue(String playbackId) ;
  VideoPlayerController? getControllerBy(String playbackId) ;
  ImageProvider? getThumbnailBy(String playbackId) ;
  Future<void> play(VideoPlayerController controller);

}