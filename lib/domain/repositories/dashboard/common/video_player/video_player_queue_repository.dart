import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/services/injection_container.dart';

final videoQueue = sl.get<VideoPlayerQueueRepository>() ;

@Injectable(as: VideoPlayerQueueRepository)
abstract class VideoPlayerQueueRepository {
  late Map<String, ImageProvider> thumbnails;
  late Map<String, VideoPlayerController> controllers;
  late VideoPlayerController? currentRunningVideo;
  Future<void> reset();
  Future<void> enqueue(String playbackId);
  VideoPlayerController? getControllerBy(String playbackId);
  ImageProvider? getThumbnailBy(String playbackId);
  Future<void>  play(VideoPlayerController controller);
}