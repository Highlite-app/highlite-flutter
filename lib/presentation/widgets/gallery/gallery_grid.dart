import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/gallery/plus_tile.dart';
import '../../../data/models/onboarding/file_model.dart';
import '../buttons/rippler.dart';
import 'gallery_tile.dart';
import 'generic_grid.dart';

class GalleryGridItem {
  final String url;
  final FileModel? file;
  final GalleryTileType type;
  final Widget? footerChild;
  final bool blurred;
  GalleryGridItem({
    required this.url,
    required this.type,
    this.file,
    this.footerChild,
    this.blurred = false,
  });
}

class GalleryGrid extends StatelessWidget {
  final bool isAddEnabled;
  final String addText;
  final double horizontalPadding;
  final double verticalPadding;
  final double spacing;
  final int perColumn;
  final List<GalleryGridItem> items;
  final VoidCallback? onAdd;
  final Function(int)? onTapItem;
  const GalleryGrid({
    super.key,
    this.isAddEnabled = false,
    this.addText = "",
    this.horizontalPadding = 4.0,
    this.verticalPadding = 0,
    this.spacing = 5.0,
    this.perColumn = 3,
    required this.items,
    this.onAdd,
    this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return GenericGrid(
      isAddEnabled: isAddEnabled,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      spacing: spacing,
      perColumn: perColumn,
      addWidget: PlusTile(
        title: addText,
        onTap: onAdd ?? () {},
      ),
      items: items,
      itemBuilder: (context, item, index) => AnimatedOpacity(
        opacity: item.blurred ? 0.2 : 1,
        duration: const Duration(milliseconds: 300),
        child: Rippler(
          onTap: onTapItem != null ? () => onTapItem!(index) : null,
          child: GalleryTile(
            type: item.type,
            url: item.url,
            file: item.file,
            footerChild: item.footerChild,
          ),
        ),
      ),
    );
  }
}
