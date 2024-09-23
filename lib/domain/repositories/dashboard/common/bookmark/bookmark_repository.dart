import 'package:highlite_flutter_mvp/data/models/apis/default/api_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/bookmark/request/bookmark_model.dart';

import '../../../../../data/models/apis/dashboard/cadidate/profile/next_token_request.dart';
import '../../../../../data/models/apis/onboarding/bookmark/response/bookmark_collection_item_response.dart';

abstract class BookmarkRepository {


  Future<ApiResponse> createBookmark( BookmarkModel bookmarkModel);

  Future<BookmarkCollectionItemResponse> getBookmark(String userId , {NextTokenRequest? request} );
}