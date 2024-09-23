import 'bookmark_collection.dart';

class BookmarkCollectionItemResponse {
  final List<BookmarkCollection>? items;
  final String? nextToken;

  BookmarkCollectionItemResponse({
    required this.items,
    this.nextToken,
  });

  factory BookmarkCollectionItemResponse.fromJson(Map<String, dynamic> json) {

    final itemList= json['items'] as List<dynamic>? ?? [] ;
    return BookmarkCollectionItemResponse(
      items: itemList.isNotEmpty ? itemList.map((item)=> BookmarkCollection.fromJson(item)).toList(): [] ,
      nextToken: json['nextToken'] ?? '',
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'item': item.map((item) => item.toJson()).toList(),
  //     'nextToken': nextToken,
  //   };
  // }
}