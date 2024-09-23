import 'bookmark_infos.dart';

class BookmarkCollection {
  final String bookmarkId;
  final String userId;
  final String title;
  final String isDeleted;
  final List<BookmarkInfo> bookmarkInfo;

  BookmarkCollection({
    required this.bookmarkId,
    required this.userId,
    required this.title,
    required this.isDeleted,
    required this.bookmarkInfo,
  });

  factory BookmarkCollection.fromJson(Map<String, dynamic> json) {
    return BookmarkCollection(
      bookmarkId: json['bookmarkId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      isDeleted: json['isDeleted'] as String? ?? '',
      bookmarkInfo: (json['bookmarkInfo'] as List<dynamic>?)
          ?.map((item) => BookmarkInfo.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': bookmarkId,
      'userId': userId,
      'title': title,
      'isDeleted': isDeleted,
      'bookmarkInfo': bookmarkInfo.map((info) => info.toJson()).toList(),
    };
  }
}
