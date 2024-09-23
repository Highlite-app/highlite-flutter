import 'package:flutter/cupertino.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/home/candidate_feed.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/home/candidate_feed_item_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/profile/next_token_request.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/candidate/home/candidate_feed_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/platform/network_info.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../../presentation/widgets/utils/logger.dart';
import '../../../../datasources/local_datasource.dart';
import '../../../../datasources/remote_datasources.dart';

final candidateFeedService =  sl<CandidateFeedRepository>() ;

@Injectable(as: CandidateFeedRepository)
class CandidateFeedRepositoryImpl extends CandidateFeedRepository{
  final LocalDataSource localDataSource ;
  final RemoteDataSources remoteDataSources ;
  final NetworkInfo networkInfo ;
  final bool isRemoteAvailable ;

  CandidateFeedRepositoryImpl({
    required this.localDataSource ,
    required this.remoteDataSources ,
    required this.networkInfo,
    this.isRemoteAvailable  = false ,
  });


  @override
  Future<CandidateFeedItemResponse> fetchCandidate(NextTokenRequest nextToken) async{

    if(await networkInfo.isConnected() ){
    try{
    final response  = remoteDataSources.fetchCandidate(nextToken);
    debugPrint("The Candidate Feed response is ::: $response");
    return response ;
    }catch(e){
    throw Exception('Local Datasource not found ::$e');
    }
    }else {
    logger.logEvent('Remote Data Source not avaialble');
    throw Exception();
    }
  }


}