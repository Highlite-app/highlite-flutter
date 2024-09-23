import 'dart:io';

import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../../data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed_response.dart';
import '../../../../../data/models/apis/dashboard/cadidate/upload/video/mux_response.dart';

final candidateVideoService = sl<UploadVideoRepository>() ;

abstract class UploadVideoRepository{


  Future<CandidateVideoFeedResponse>  uploadCandidateVideoFeed(CandidateVideoFeed candidateVideoFeed) ;

  Future<MuxResponse> uploadCandidateVideoToMux(File videoFile) ;

}