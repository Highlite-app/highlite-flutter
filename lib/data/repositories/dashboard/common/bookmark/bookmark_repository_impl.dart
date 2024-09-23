import 'package:flutter/cupertino.dart';
import 'package:highlite_flutter_mvp/data/models/apis/dashboard/cadidate/profile/next_token_request.dart';
import 'package:highlite_flutter_mvp/data/models/apis/default/api_response.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/bookmark/request/bookmark_model.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/bookmark/response/bookmark_collection_item_response.dart';
import 'package:highlite_flutter_mvp/domain/repositories/dashboard/common/bookmark/bookmark_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/platform/network_info.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../../presentation/widgets/utils/logger.dart';
import '../../../../datasources/local_datasource.dart';
import '../../../../datasources/remote_datasources.dart';

final bookmarkService = sl<BookmarkRepository>();

@Injectable(as: BookmarkRepository)
class BookmarkRepositoryImpl extends BookmarkRepository {
  final LocalDataSource localDataSource;

  final RemoteDataSources remoteDataSources;

  final NetworkInfo networkInfo;

  final bool isRemoteAvailable;

  BookmarkRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSources,
    required this.networkInfo,
    this.isRemoteAvailable = false,
  });

  @override
  Future<ApiResponse> createBookmark(BookmarkModel bookmarkModel) async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await remoteDataSources.createBookmark(bookmarkModel);
        debugPrint("createBookmark response is ::: $response");
        return response;
      } catch (e) {
        throw Exception('Local Datasource not found ::$e');
      }
    } else {
      logger.logEvent('Remote Data Source not avaialble');
      throw Exception();
    }
  }

  @override
  Future<BookmarkCollectionItemResponse> getBookmark(
      String userId , {NextTokenRequest? request}) async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await remoteDataSources.fetchBookmark(request, userId);
        logger.logEvent("The getBookmark response is ::: ${response.items}" , isJson: true);
        return response ;
      } catch (e) {
        throw Exception('Something went in api :$e');
      }
    } else {
      logger.logEvent('Check you internet connection');
      throw Exception();
    }
  }
}
