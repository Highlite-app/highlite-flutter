import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../gallery/preview_gallery.dart';
import '../../utils/radius.dart';

extension PreviewsBubbleCounter on PreviewGalleryCounter {
  static PreviewGalleryCounter autoMap(List<PreviewModel> previews) {
    return PreviewGalleryCounter(
      crossAxisCount: previews.length,
      pattern: previews.map((_) => const QuiltedGridTile(2, 1)).toList(),
      direction: Axis.vertical,
    );
  }
}

class PreviewsBubble extends StatelessWidget {
  final Widget Function(Widget, PreviewModel, int)? childBuilder;
  final List<PreviewModel> previews;
  final double borderRadius;
  const PreviewsBubble({
    super.key,
    required this.previews,
    this.borderRadius = 12.0,
    this.childBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final CircularRadiusContent radius = CircularRadiusContent(borderRadius);
    final PreviewsBubbleSize sizes = PreviewsBubbleSize.from(previews);
    return Container(
      constraints: BoxConstraints(
        minWidth: sizes.width,
        maxWidth: sizes.width,
        minHeight: sizes.height,
        maxHeight: sizes.height + sizes.spacing,
      ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: PreviewsBubbleWidget(
        previews: previews,
        radius: radius,
        sizes: sizes,
        childBuilder: childBuilder,
      ),
    );
  }
}

class PreviewsBubbleSize {
  final double width;
  final double height;
  final double spacing;
  const PreviewsBubbleSize(
      {required this.width, required this.height, required this.spacing});
  factory PreviewsBubbleSize.from(List<PreviewModel> previews) {
    double width = 249;
    double height = 140;
    double spacing = 0;
    if (previews.length == 3) {
      width = 244;
      height = 80;
    }
    if (previews.length == 4) {
      width = 162;
      height = 162;
      spacing = 2;
    }

    if (previews.length == 5) {
      width = 244;
      height = 162;
      spacing = 2;
    }
    if (previews.length == 6) {
      width = 244;
      height = 162;
      spacing = 2;
    }

    if (previews.length >= 7) {
      width = 244;
      height = 244;
      spacing = 4;
    }
    return PreviewsBubbleSize(height: height, width: width, spacing: spacing);
  }
}

class PreviewsBubbleWidget extends StatelessWidget {
  final Widget Function(Widget, PreviewModel, int)? childBuilder;
  final List<PreviewModel> previews;
  final CircularRadiusContent radius;
  final PreviewsBubbleSize sizes;
  const PreviewsBubbleWidget({
    super.key,
    required this.previews,
    required this.radius,
    required this.sizes,
    this.childBuilder,
  });

  @override
  Widget build(BuildContext context) {
    double width = sizes.width;
    double height = sizes.height;
    final counter = PreviewsBubbleCounter.autoMap(previews);
    Widget gridLayout = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(radius.all),
      ),
      child: NestedQuilterGrid(
        counter: counter,
        previews: previews,
        height: height,
        childBuilder: childBuilder,
      ),
    );
    if (previews.length == 4) {
      gridLayout = SimpleQuilterWrap(
        children: [
          SizedQuilterGrid(
            size: height / 2,
            items: previews.getRange(0, 2).toList(),
            crossAxis: 2,
            mainAxis: 1,
            childBuilder: childBuilder,
          ),
          SizedQuilterGrid(
            size: height / 2,
            items: previews.getRange(2, 4).toList(),
            crossAxis: 2,
            mainAxis: 1,
            childBuilder: childBuilder,
          ),
        ],
      );
    }

    if (previews.length == 5) {
      gridLayout = SimpleQuilterWrap(
        children: [
          SizedQuilterGrid(
            size: height / 2,
            items: previews.getRange(0, 2).toList(),
            crossAxis: 2,
            mainAxis: 2,
            childBuilder: childBuilder,
          ),
          SizedQuilterGrid(
            size: height / 2,
            items: previews.getRange(2, 5).toList(),
            crossAxis: 3,
            mainAxis: 2,
            childBuilder: childBuilder,
          ),
        ],
      );
    }
    if (previews.length == 6) {
      gridLayout = SimpleQuilterWrap(
        children: [
          SizedQuilterGrid(
            size: height / 2,
            items: previews.getRange(0, 3).toList(),
            crossAxis: 3,
            mainAxis: 2,
            childBuilder: childBuilder,
          ),
          SizedQuilterGrid(
            size: height / 2,
            items: previews.getRange(3, 6).toList(),
            crossAxis: 3,
            mainAxis: 2,
            childBuilder: childBuilder,
          ),
        ],
      );
    }

    if (previews.length >= 7) {
      final remainingItems =
          previews.getRange(6, 6 + (previews.length - 6)).toList();
      gridLayout = SimpleQuilterWrap(
        children: [
          SizedQuilterGrid(
            size: height / 3,
            items: previews.getRange(0, 3).toList(),
            crossAxis: 3,
            mainAxis: 2,
            childBuilder: childBuilder,
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: previews.length != 9
                  ? BorderRadius.only(bottomLeft: radius.bottomLeft)
                  : null,
            ),
            child: SizedQuilterGrid(
              size: height / 3,
              items: previews.getRange(3, 6).toList(),
              crossAxis: 3,
              mainAxis: 2,
              childBuilder: childBuilder,
            ),
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: radius.bottomLeft),
            ),
            child: SizedQuilterGrid(
              size: height / 3,
              width: (width / 3) * remainingItems.length,
              items: remainingItems,
              crossAxis: remainingItems.length,
              mainAxis: 1,
              childBuilder: childBuilder,
            ),
          ),
        ],
      );
    }
    return gridLayout;
  }
}
