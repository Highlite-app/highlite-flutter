

import '../../data/models/services/mux/mux_asset.dart';
import '../../data/models/services/mux/mux_video.dart';
import 'mux_video_client.dart';

class VideoRepository {
  final MuxVideoClient _client;
  const VideoRepository({
    required MuxVideoClient client,
  }) : _client = client;

  Future<List<Video>> getVideos() async {
    try {
      final videos = await Future.delayed(
        const Duration(seconds: 1),
            () => Video.sampleVideos
            .map((videoJson) => Video.fromJson(videoJson))
            .toList(),
      );

      final updatedVideos = <Video>[];
      for (var video in videos) {
        final muxAssetJson = await _client.getMuxAsset(video.muxId);
        final muxAsset = MuxAsset.fromJson(muxAssetJson['data']);
        updatedVideos.add(video.copyWith(muxAsset: muxAsset));
      }
      return updatedVideos;
    } catch (err) {
      throw Exception('Failed to load videos');
    }
  }
}
