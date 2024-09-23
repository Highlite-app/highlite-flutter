import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../layout/dim.dart';
import '../svg/svg_asset.dart';
import '../video_feed/video_widget.dart';

class VideoPreview extends StatefulWidget {
  final Size size;
  final double radius;
  final bool hasDim;
  const VideoPreview({
    super.key,
    required this.controller,
    required this.size,
    this.radius = 8.0,
    this.hasDim = false,
  });
  final VideoPlayerController controller;

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  bool onTap = false ;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
      child: SizedBox(
        width: widget.size.width,
        height: widget.size.height,
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (widget.controller.value.isPlaying) {
                widget.controller.pause();
                setState(() {
                  onTap = !onTap ;
                });
              } else {
                widget.controller.play();
              }
            });
          },
          child: Stack(
            children: [
              VideoWidget(
                controller: widget.controller,
                onlyOverflow: true,
              ),
              if (widget.hasDim)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Dim(
                    height: 100.h,
                    opacityTop: 0.0,
                    opacityBottom: 0.4,
                  ),
                ),
              if (onTap)
                const Center(
                  child: SvgAsset(
                    asset: AssetConstant.playIcon2,
                    size: 44,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
