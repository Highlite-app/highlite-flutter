import 'package:highlite_flutter_mvp/data/models/apis/onboarding/bookmark/request/bookmark_model.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/bookmark/response/bookmark_collection.dart';

import '../../../data/models/apis/onboarding/bookmark/response/bookmark_infos.dart';

class BookmarkState {
  final List<BookmarkCollection> bookmarkCollection;
  final List<BookmarkModel> bookmarkModel ;
  final List<BookmarkInfo> bookmarkInfo;

  BookmarkState({
    this.bookmarkCollection = const [],
    this.bookmarkModel = const [] ,
    this.bookmarkInfo = const [],
  });

  BookmarkState copyWith(
          {List<BookmarkCollection>? bookmarkCollection,
            List<BookmarkModel>? bookmarkModel ,
          List<BookmarkInfo>? bookmarkInfo}) =>
      BookmarkState(
          bookmarkCollection: bookmarkCollection ?? this.bookmarkCollection,
          bookmarkModel:  bookmarkModel ?? this.bookmarkModel,
          bookmarkInfo: bookmarkInfo ?? this.bookmarkInfo);
}
