abstract class BookmarkEvent {
  const BookmarkEvent();
}

class GetBookmarkEvent extends BookmarkEvent {
  GetBookmarkEvent();
}

class CreateBookmarkCollectionEvent extends BookmarkEvent {
  final String userId;

  final String candidateId;

  final String videoFeedId;

  final String title;

  CreateBookmarkCollectionEvent(
      {required this.userId,
      required this.title,
      required this.candidateId,
      required this.videoFeedId});
}

class DeleteBookmarkCollectionEvent extends BookmarkEvent {
  final String bookmarkCollectionId;

  DeleteBookmarkCollectionEvent({required this.bookmarkCollectionId});
}

class CreateBookmarkInfo extends BookmarkEvent {
  final String id;

  final String referenceId;

  CreateBookmarkInfo({required this.id, required this.referenceId});
}

class RetrieveBookmarkEvent extends BookmarkEvent {
  final String userId;

  RetrieveBookmarkEvent({required this.userId});
}
