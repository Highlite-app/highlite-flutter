import 'package:flutter/material.dart';
import '../../../core/resources/color_constants.dart';
import '../../../data/models/onboarding/file_model.dart';
import '../svg/svg_asset.dart';

enum GalleryTileType {
  collection,
  videoClip,
  none;
}

class GalleryTile extends StatelessWidget {
  final GalleryTileType type;
  final String url;
  final FileModel? file;
  final Widget? footerChild;
  const GalleryTile({
    super.key,
    required this.type,
    required this.url,
    this.file,
    this.footerChild,
  });

  @override
  Widget build(BuildContext context) {
    String? icon;
    switch (type) {
      case GalleryTileType.collection:
        icon = "highlite-collection";
        break;
      case GalleryTileType.videoClip:
        icon = "play-circle-02";
        break;
      case GalleryTileType.none:
        icon = null;
        break;
    }
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.87),
      ),
      child: GridTile(
        header: icon != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgAsset(asset: icon, size: 24, color: ColorConstant.shade00),
                  ],
                ),
              )
            : Container(),
        footer: footerChild,
        child: file?.file != null
            ? Image.file(file!.file!, fit: BoxFit.cover)
            : url != ""
                ? Image.network(url, fit: BoxFit.cover)
                : Container(color: ColorConstant.neutral300),
      ),
    );
  }
}
