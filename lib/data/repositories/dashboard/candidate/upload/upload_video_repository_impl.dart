import 'dart:io';

import 'package:highlite_flutter_mvp/core/platform/network_info.dart';
import 'package:highlite_flutter_mvp/core/services/mux_video_client.dart';
import 'package:highlite_flutter_mvp/data/datasources/local_datasource.dart';
import 'package:highlite_flutter_mvp/data/datasources/remote_datasources.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';

import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/video/mux_response.dart';

import '../../../../../domain/repositories/dashboard/candidate/upload/upload_video_repository.dart';
import '../../../../../presentation/widgets/utils/logger.dart';

class UploadVideoRepositoryImpl implements UploadVideoRepository{
  RemoteDataSources remoteDataSources ;
  LocalDataSource localDataSource ;
  NetworkInfo networkInfo ;

  UploadVideoRepositoryImpl({required this.remoteDataSources , required this.localDataSource , required this.networkInfo}) ;
  @override
  Future<CandidateVideoFeedResponse> uploadCandidateVideoFeed(CandidateVideoFeed candidateVideoFeed) async {
    if (await networkInfo.isConnected()) {
    final response = remoteDataSources.uploadCandidateVideo(candidateVideoFeed);
    return response;
    } else {
    logger.logEvent("This is no local Datastore since its a post Api");
    }
    throw Exception();
  }

  @override
  Future<MuxResponse> uploadCandidateVideoToMux(File videoFile) async{
    if(await networkInfo.isConnected()){
      final response  = await MuxVideoClient().uploadMuxAssets(videoFile: videoFile) ;
      return response ;
    }
    throw Exception("Issue while uploading candidate video");
  }


}