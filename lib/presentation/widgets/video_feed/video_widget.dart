import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../layout/overflowing_box.dart';

class VideoWidget extends StatelessWidget {
  final bool onlyOverflow;
  const VideoWidget({
    super.key,
    required this.controller,
    this.onlyOverflow = false,
  });
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    final Size size = controller.value.size;
    return Column(
      children: [
        Expanded(
          child: onlyOverflow
              ? OverflowingBox(size: size, child: VideoPlayer(controller))
              : (size.height > size.width)
                  ? VideoPlayer(controller)
                  : OverflowingBox(size: size, child: VideoPlayer(controller)),
        ),
      ],
    );
  }
}
