import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:photo_view/photo_view.dart';

import '../layout/overflowing_box.dart';

class ZoomableImage extends StatefulWidget {
  final ImageProvider image;
  final double size;
  final BoxDecoration decoration;
  final Function(GlobalKey) screenshotHandler;

  const ZoomableImage({
    super.key,
    required this.image,
    required this.size,
    required this.decoration,
    required this.screenshotHandler,
  });

  @override
  State<ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  final globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    widget.screenshotHandler(globalKey);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: widget.size,
      width: widget.size,
      decoration: widget.decoration,
      child: Stack(
        children: [
          OverflowingBox(
            size: const Size(350, 350),
            child: RepaintBoundary(
              key: globalKey,
              child: PhotoView(
                imageProvider: widget.image,
                minScale: 0.7,
                maxScale: 2.5,
                initialScale: PhotoViewComputedScale.contained,
              ),
            ),
          ),
          IgnorePointer(
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 5,
              crossAxisSpacing: 0.1,
              mainAxisSpacing: 0.1,
              children: List.generate(
                100,
                (index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: ColorConstant.transparent,
                      border: Border.all(
                        color: ColorConstant.shade00.withOpacity(0.5),
                        width: 0.4,
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
