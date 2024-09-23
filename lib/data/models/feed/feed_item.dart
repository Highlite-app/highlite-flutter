import '../../../presentation/widgets/utils/data_type.dart';
import '../onboarding/candidate_user_model.dart';

class FeedItemOverlay {
  String icon;
  String text;

  FeedItemOverlay({required this.icon, required this.text});
}

class FeedItem {
  String id;
  String videoUrl;
  String thumbnailUrl;
  CandidateUser user;
  List<String> liked;
  List<String> seen;
  List<String> disliked;
  int likedTotal;
  int seenTotal;
  int dislikedTotal;

  FeedItem(
      {required this.id,
      required this.videoUrl,
      required this.thumbnailUrl,
      required this.user,
      required this.liked,
      required this.seen,
      required this.disliked,
      required this.likedTotal,
      required this.seenTotal,
      required this.dislikedTotal});

  factory FeedItem.mock(FeedItemOverlay? overlay) => FeedItem(
        id: "",
        videoUrl:
            "https://stream.mux.com/1WvsYGWItHVixDKcIsHmSvqz9fJOcURWx2DkYLI3Axc.m3u8",
        thumbnailUrl:
            "https://image.mux.com/1WvsYGWItHVixDKcIsHmSvqz9fJOcURWx2DkYLI3Axc/thumbnail.png?time=0&fit_mode=preserve",
        user: CandidateUser.mock(),
        liked: [],
        disliked: [],
        seen: [],
        likedTotal: 0,
        seenTotal: 0,
        dislikedTotal: 0,
      );

  factory FeedItem.from(Map<String, dynamic> playback) {
    final playbackId = playback['playBackId'];
    final videoUrl = playback['playbackEndpoint'];
    final thumbnail =
        "https://image.mux.com/$playbackId/thumbnail.jpg?time=0&fit_mode=preserve";
    CandidateUser user;
    if (playback['user'] != null) {
      user = CandidateUser.fromDocument(playback['user']);
    } else {
      user = CandidateUser.mock();
    }
    return FeedItem(
      id: playback['id'],
      videoUrl: videoUrl,
      thumbnailUrl: thumbnail,
      user: user,
      liked: List<String>.from(playback['like'] ?? []),
      disliked: List<String>.from(playback['dislike'] ?? []),
      seen: List<String>.from(playback['see'] ?? []),
      likedTotal: tryCast<int>(playback['likeTotal']) ?? 0,
      dislikedTotal: tryCast<int>(playback['dislikeTotal']) ?? 0,
      seenTotal: tryCast<int>(playback['seenTotal']) ?? 0,
    );
  }
}
