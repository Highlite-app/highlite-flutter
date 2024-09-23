import 'package:video_player/video_player.dart';

class VideoPlayerUtil{
   static void _handleVideoPlyingOnPageChange(List<VideoPlayerController> controller , int pageIndex ){

    for( int i = 0 ; i<controller.length ; i++){
      if(i == pageIndex){
        controller[i].play();
      }
      else  {
        controller[i].pause() ;
      }
    }
  }

   static  handleVideoPlyingOnPageChange(
       {required List<VideoPlayerController> videoPlayerController,
         required int pageIndex}) => _handleVideoPlyingOnPageChange(videoPlayerController, pageIndex);
}