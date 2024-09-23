import 'dart:io';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import '../../svg/svg_asset.dart';

class VideoThumbnail extends StatelessWidget {
  final File file;
  const VideoThumbnail({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorConstant.previewBg,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SvgAsset(
          asset: AssetConstant.playCircleIcon,
          size: 50,
        ),
      ],
    );
  }
}
