import 'package:highlite_flutter_mvp/data/datasources/remote_datasources.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/home/candidate_feed.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';

class CandidateFeedItemResponse{
  final List<CandidateFeed> items;
  final String? nextToken;



  CandidateFeedItemResponse({
    required this.items,
    this.nextToken,
  });



  factory CandidateFeedItemResponse.fromJson(Map<String, dynamic> json) {

    var itemList  = json['items']  as List<dynamic>? ?? [] ;

    return CandidateFeedItemResponse(
      items: itemList.map((item) => CandidateFeed.fromJson(item)).toList() ,
      nextToken: json['nextToken'],
    );
  }
}