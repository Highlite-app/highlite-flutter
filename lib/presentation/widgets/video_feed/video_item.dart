import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/video_feed/thumbnail_preview.dart';
import 'package:video_player/video_player.dart';

import '../video/video_preview.dart';

class VideoItem extends StatefulWidget {
  final VideoPlayerController controller;
  final ImageProvider thumbnail;
  const VideoItem({
    super.key,
    required this.controller,
    required this.thumbnail,
  });

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  void onChange() {
    if (mounted) {
      if (widget.controller.value.isInitialized) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        !widget.controller.value.isInitialized
            ? ThumbnailPreview(
                provider: widget.thumbnail,
                hasDim: true,
              )
            : VideoPreview(
                controller: widget.controller,
                size: const Size(double.infinity, double.infinity),
                radius: 0,
                hasDim: true,
              ),
      ],
    );
  }
}
