import 'dart:convert';

import 'package:highlite_flutter_mvp/data/datasources/remote_datasources.dart';

class BookmarkModel {
  final String bookmarkId;
  final String userId;
  final String title;
  final bool isDeleted;
  final List<BookmarkModelInfo>? bookmarkInfo;

  BookmarkModel({
    required this.bookmarkId,
    required this.userId,
    required this.title,
    required this.isDeleted,
    this.bookmarkInfo,
  });

  // Factory method to create a Bookmark instance from JSON
  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      bookmarkId: json['bookmarkId'] ?? '',
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      isDeleted: json['isDeleted'] == 'false',
      bookmarkInfo: json['bookmarkInfo'].isNullOrEmpty ? []:
      (json['bookmarkInfo'] as List<dynamic>?)?.map((item) => BookmarkModelInfo.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  // Method to convert Bookmark instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'bookmarkId': bookmarkId,
      'userId': userId,
      'title': title,
      'isDeleted': isDeleted ? 'true' : 'false',
      'bookmarkInfo': bookmarkInfo?.map((info) => info.toJson()).toList() ?? [],
    };
  }
}

class BookmarkModelInfo {
  final String? bookmarkInfoId;
  final String? type;
  final String? bookmarkCollectionId;
  final String? referenceId;
  final String? candidateId;
  final String? companyId;

  BookmarkModelInfo({
    this.bookmarkInfoId,
    this.type,
    this.bookmarkCollectionId,
    this.referenceId,
    this.candidateId,
    this.companyId,
  });

  // Factory method to create a BookmarkInfo instance from JSON
  factory BookmarkModelInfo.fromJson(Map<String, dynamic> json) {
    return BookmarkModelInfo(
      bookmarkInfoId: json['bookmarkInfoId'] ?? '',
      type: json['type']  ?? '',
      bookmarkCollectionId: json['bookmarkCollectionId']  ?? '',
      referenceId: json['referenceId'] ?? '',
      candidateId: json['candidateId'] ?? '',
      companyId: json['companyId']  ?? '',
    );
  }

  // Method to convert BookmarkInfo instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'bookmarkInfoId': bookmarkInfoId ?? '',
      'type': type ?? '',
      'bookmarkCollectionId': bookmarkCollectionId ?? '',
      'referenceId': referenceId ?? '',
      'candidateId': candidateId ?? '',
      'companyId': companyId ?? '',
    };
  }
}
