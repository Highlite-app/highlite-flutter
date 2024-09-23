import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/bookmark/request/bookmark_model.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/bookmark/response/bookmark_collection.dart';
import 'package:highlite_flutter_mvp/data/repositories/dashboard/common/bookmark/bookmark_repository_impl.dart';
import 'package:highlite_flutter_mvp/domain/repositories/auth/auth_repository.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/bookmark/bookmark_event.dart';
import 'package:highlite_flutter_mvp/presentation/bloc/bookmark/bookmark_state.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/logger.dart';

import '../../../data/models/apis/onboarding/bookmark/response/bookmark_infos.dart';

class BookmarkBloc extends Bloc<BookmarkEvent , BookmarkState> {
  BookmarkBloc(): super(BookmarkState()) {
    on<GetBookmarkEvent>(_handleGetBookmarkEvent) ;
    on<CreateBookmarkCollectionEvent>(_handleCreateBookmark) ;
  }

  Future<void> _handleGetBookmarkEvent(
      GetBookmarkEvent event ,
      Emitter<BookmarkState> emit
      ) async{

    debugPrint("now called inside profile") ;

    var result  =await  bookmarkService.getBookmark( authService.persistedUser?.id ?? '') ;


   List<BookmarkCollection> bookmarkCollections = result.items ?? [] ;


   List<BookmarkInfo> bookmarkInfoList = [] ;

   for(var bookmarkCollection in bookmarkCollections){
     bookmarkInfoList.addAll(bookmarkCollection.bookmarkInfo ) ;
   }

   if(bookmarkInfoList.isNotEmpty && bookmarkCollections.isNotEmpty){
     emit(
     state.copyWith(bookmarkCollection: bookmarkCollections ,
     bookmarkInfo:  bookmarkInfoList
     ));

   }

   debugPrint("state of bookmarkCollection ${state.bookmarkCollection.first.title}" ) ;
   debugPrint("state of bookmarkInfo ${state.bookmarkCollection.first.bookmarkInfo.first.referenceId}" ) ;

  }

  Future<void> _handleCreateBookmark(
      CreateBookmarkCollectionEvent event ,
      Emitter<BookmarkState> emit
      )async {

   BookmarkModelInfo bookmarkModelInfo = BookmarkModelInfo(
     type: 'feed',
     referenceId: event.videoFeedId,
     candidateId: event.candidateId
   ) ;

   List<BookmarkModelInfo> bookmarkInfo = [] ;
   bookmarkInfo.add(bookmarkModelInfo) ;

   await  bookmarkService.createBookmark(BookmarkModel(
        bookmarkId: '',
        userId: authService.persistedUser?.id ?? '',
        title:  event.title,
        isDeleted:  false ,
        bookmarkInfo: bookmarkInfo
    )) ;

    add(GetBookmarkEvent()) ;


  }
}