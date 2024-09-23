import 'package:video_player/video_player.dart';

class VideoFeedConstants {
  static String getPlaybackUrl({required String playbackId}) {
    return "https://stream.mux.com/$playbackId.m3u8" ;
  }


  static String getThumbnailForHomeFeed({required String playbackId , String? width , String? height})  {
   return  'https://image.mux.com/$playbackId/thumbnail.png?fit_mode=preserve' ;
  }


  static String getThumbnailForProfile({required String playbackId , String? width , String? height})  {
    return  'https://image.mux.com/$playbackId/thumbnail.png?fit_mode=preserve&width=${width ??125 }&height=${height ??150}' ;
  }

  static Future<VideoPlayerController> getPlaybackVideo(
      {required String playbackUrl}) async {
    VideoPlayerController controller =
        VideoPlayerController.network(playbackUrl, formatHint: VideoFormat.hls);

    await controller.setLooping(true);
    await controller.initialize();
    return controller;
  }
}
