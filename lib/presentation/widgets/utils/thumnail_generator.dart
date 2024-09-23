

import 'dart:io';

import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

class ThumbnailGenerator{


  Future<String> generateThumbnail(File videoFile) async {
    String thumbnail = '' ;
   try{
     final thumbnailPath = await VideoThumbnail.thumbnailFile(
       video: videoFile.path,
       thumbnailPath: (await syspaths.getTemporaryDirectory()).path,
       imageFormat: ImageFormat.PNG,
       maxHeight: 100,
       quality: 75,
     );
     if(thumbnailPath!=null && thumbnailPath!='') {
       thumbnail =  thumbnailPath  ;
     }
     return thumbnail ;
   }catch(e){
     throw Exception("Thumbnail Generation issue $e");
   }








  }
}