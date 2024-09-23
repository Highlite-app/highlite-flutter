

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/data/models/apis/onboarding/candidate/candidate_onboarding.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
import '../../../data/models/apis/dashboard/cadidate/upload/video/candidate_video_feed.dart';
import '../../../data/models/apis/onboarding/bookmark/response/bookmark_collection.dart';
import '../../../data/models/apis/onboarding/bookmark/response/bookmark_infos.dart';
import '../profile/tabs/self_video/self_video_player_screen.dart';

class BookmarkPage extends StatelessWidget {
  final List<BookmarkCollection> collections;

  const BookmarkPage({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    List<CandidateVideoFeed> allVideoFeeds = [];

    for (var collection in collections) {
      for (var info in collection.bookmarkInfo) {
        if (info.candidateVideoFeed != null) {
          allVideoFeeds.add(info.candidateVideoFeed!);
        }
      }
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,

        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 9/11,
            crossAxisSpacing: 8,
            crossAxisCount: 2),
        itemCount: collections.length,
        itemBuilder: (context, index) {
       return   GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelfVideoPlayerScreen(
                      index: index,
                      candidateOnBoarding: collections[index].bookmarkInfo[index].candidateOnBoarding ?? CandidateOnBoarding.defaultOnboarding(),
                      candidateVideoFeed:allVideoFeeds ,),
                  ));
            },
              child: BookmarkCollectionWidget(collection: collections[index]));
        }
      ),
    );
  }
}

class BookmarkCollectionWidget extends StatelessWidget {
  final BookmarkCollection collection;

  const BookmarkCollectionWidget({required this.collection});

  @override
  Widget build(BuildContext context) {
    // Get the first 4 thumbnails if available, otherwise get all available thumbnails
    // List<BookmarkInfo> items = collection.bookmarkInfo.length > 4
    //     ? collection.bookmarkInfo.sublist(0, 4)
    //     : collection.bookmarkInfo;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(child: BookmarkItem(bookmarkInfoList: collection.bookmarkInfo)),
        SizedBox(height: 8.0),
        SectionTitle(title: collection.title),

      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: BaseTextStyle(
        color: ColorConstant.shade100,
        fontWeight: FontWeight.w400,
        fontSize: TypographyTheme.paragraph_p3,
      ),
    );
  }
}

class BookmarkItem extends StatelessWidget {
  final List<BookmarkInfo> bookmarkInfoList;

  const BookmarkItem({required this.bookmarkInfoList});

  @override
  Widget build(BuildContext context) {
    final double width = (MediaQuery.of(context).size.width - 64) / 1.8;

    int itemCount(List<BookmarkInfo> items) {
      if (items.length >= 4) return 4;
      if (items.length == 3) return 2;
      return items.length; // Handles cases for 1 or 2 items
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: itemCount(bookmarkInfoList) == 4 ?  2 : 1,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 9/10,
        ),
        itemCount: itemCount(bookmarkInfoList),
        itemBuilder: (context, index) {
          return _buildThumbnail(bookmarkInfoList[index]);
        },
      ),
    );
  }

  Widget _buildThumbnail(BookmarkInfo bookmarkInfo) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(bookmarkInfo.candidateVideoFeed?.thumbnailUrl ?? ''),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  String getThumbnailUrl(BookmarkInfo bookmarkInfo) {
    if (bookmarkInfo.candidateVideoFeed != null) {
      return bookmarkInfo.candidateVideoFeed!.thumbnailUrl;
    }
    // Add more conditions based on other types if needed
    return 'https://randomuser.me/api/portraits/women/0.jpg'; // Placeholder URL
  }
}
