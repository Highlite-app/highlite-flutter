import 'package:flutter/src/painting/image_provider.dart';
import 'package:highlite_flutter_mvp/core/local_storage/highlite_candidate_storage_service.dart';
import 'package:highlite_flutter_mvp/core/platform/network_info.dart';
import 'package:highlite_flutter_mvp/data/datasources/local_datasource.dart';
import 'package:highlite_flutter_mvp/data/datasources/remote_datasources.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/profile/candidate_profile_repository.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/common/video_player/video_player_queue_repository.dart';
import 'package:video_player/video_player.dart';

import '../../../../models/apis/onboarding/candidate/candidate_onboarding.dart';

class CandidateProfileRepositoryImpl implements  CandidateProfileRepository{
  final  LocalDataSource localDataSource  ;
  final RemoteDataSources remoteDataSources ;
  final NetworkInfo networkInfo ;

  CandidateProfileRepositoryImpl({
    required this.localDataSource ,
    required this.remoteDataSources ,
    required this.networkInfo ,
});

  @override
  Map<String, VideoPlayerController> selfVideoPlayerController = {} ;

  @override
  Map<String, ImageProvider<Object>> selfVideoPlayerThumbnail = {};

  @override
  List<CandidateVideoFeed> candidateVideoFeed = [] ;




  @override
  Future<CandidateOnBoarding> getCandidateOnBoarding(String id) async {
    final CandidateOnBoarding candidate ;
    if(await networkInfo.isConnected()){
      candidate  = await remoteDataSources.getCandidateOnBoarding(id);
      await hiveStorage.setCandidateToStorage(candidate);
      return candidate;
    }else {
       throw  Exception("Internet is Not Connected") ;
    }
  }

  @override
  Future<void> ping(String id) {
    // TODO: implement ping
    throw UnimplementedError();
  }

  @override
  Future<CandidateOnBoarding> updateCandidateProfile(CandidateOnBoarding request, String id) async{
    final CandidateOnBoarding candidate ;
    if(await networkInfo.isConnected()){

      candidate = await remoteDataSources.updateCandidateOnBoarding(id, request);
      return candidate ;
    }else {
      throw Exception("Internet is Not Connected");
    }
  }

  @override
  Future<List<CandidateVideoFeed>> getCandidateVideoFeed(String candidateId) async{

    if(await networkInfo.isConnected()) {
      final response  = await remoteDataSources.getCandidateVideoFeed(candidateId) ;
      await setSelfController(response) ;
      return response ;


    }else{
      throw Exception("Internet is Not Connected");
    }
  }

  Future<void> setSelfController(List<CandidateVideoFeed> response) async{
    candidateVideoFeed.addAll(response) ;
    for (var videFeed in candidateVideoFeed){

      await videoQueue.enqueue(videFeed.playbackId) ;
      final controller  = videoQueue.getControllerBy(videFeed.playbackId) ;
      final thumbnail  = videoQueue.getThumbnailBy(videFeed.playbackId) ;

      if(controller != null || thumbnail !=null){
        selfVideoPlayerController[videFeed.playbackId] = controller! ;
        selfVideoPlayerThumbnail[videFeed.playbackId] = thumbnail! ;
      }
    }

  }






}