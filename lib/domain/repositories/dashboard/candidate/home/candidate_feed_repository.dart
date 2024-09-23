import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/profile/next_token_request.dart';

import '../../../../../data/models/apis/dashboard/cadidate/home/candidate_feed_item_response.dart';



abstract class CandidateFeedRepository{


  Future<CandidateFeedItemResponse>  fetchCandidate(NextTokenRequest nextToken) ;
}