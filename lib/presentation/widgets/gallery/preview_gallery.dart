import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../core/resources/asset_constants.dart';
import '../../../core/resources/color_constants.dart';
import '../utils/string.dart';
import '../../../core/services/single_uploader_service.dart';
import '../image/blurred_image.dart';
import '../svg/svg_asset.dart';

class PreviewModel {
  final String url;
  final bool isVideoPreview;
  final File? file;
  final FileType? fileType;
  final bool uploading;
  const PreviewModel({
    required this.url,
    this.isVideoPreview = false,
    this.file,
    this.fileType,
    this.uploading = false,
  });
}

class PreviewGalleryCounter {
  final int crossAxisCount;
  final List<QuiltedGridTile> pattern;
  final Axis direction;
  const PreviewGalleryCounter({
    required this.crossAxisCount,
    required this.pattern,
    required this.direction,
  });

  factory PreviewGalleryCounter.fromCount(List<PreviewModel> previews) {
    if (previews.length % 2 == 0) {
      return PreviewGalleryCounter(
        crossAxisCount: previews.length ~/ 2,
        pattern: previews.map((_) => const QuiltedGridTile(1, 1)).toList(),
        direction: Axis.vertical,
      );
    }
    if (previews.length == 1) {
      return PreviewGalleryCounter(
        crossAxisCount: previews.length,
        pattern: previews.map((_) => const QuiltedGridTile(1, 1)).toList(),
        direction: Axis.horizontal,
      );
    } else if (previews.length == 3) {
      return const PreviewGalleryCounter(
        crossAxisCount: 2,
        pattern: [
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 2),
        ],
        direction: Axis.vertical,
      );
    }
    return PreviewGalleryCounter(
      crossAxisCount: 3,
      pattern: previews.map((_) => const QuiltedGridTile(1, 1)).toList(),
      direction: Axis.vertical,
    );
  }
  factory PreviewGalleryCounter.withCrossAxisOf(
          int crossAxis, List<PreviewModel> previews, int mainAxis) =>
      PreviewGalleryCounter(
        crossAxisCount: crossAxis,
        pattern: previews.map((_) => QuiltedGridTile(mainAxis, 1)).toList(),
        direction: Axis.vertical,
      );
}

class PreviewGallery extends StatelessWidget {
  final double size;
  final List<PreviewModel> previews;
  final double borderRadius;
  final double spacing;
  const PreviewGallery({
    super.key,
    required this.previews,
    required this.size,
    this.spacing = 2,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    if (previews.isEmpty) {
      return Container(
        constraints: BoxConstraints(
            minWidth: size, maxWidth: size, minHeight: size, maxHeight: size),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: ColorConstant.neutral500,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );
    }
    return Container(
      constraints: BoxConstraints(
          minWidth: size, maxWidth: size, minHeight: size, maxHeight: size),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: PreviewGalleryWidget(
        previews: previews,
        size: size,
        spacing: spacing,
      ),
    );
  }
}

class PreviewGalleryWidget extends StatelessWidget {
  final double size;
  final List<PreviewModel> previews;
  final double spacing;
  const PreviewGalleryWidget(
      {super.key,
      required this.size,
      required this.previews,
      this.spacing = 2});

  @override
  Widget build(BuildContext context) {
    PreviewGalleryCounter counter = PreviewGalleryCounter.fromCount(previews);
    Widget gridLayout = NestedQuilterGrid(
      counter: counter,
      previews: previews,
      spacing: spacing,
    );
    if (previews.length == 2) {
      gridLayout = SimpleQuilterWrap(
        spacing: spacing,
        children: previews
            .map(
              (preview) => PreviewItem(preview: preview, height: size / 2),
            )
            .toList(),
      );
    }
    if (previews.length == 5) {
      gridLayout = SimpleQuilterWrap(
        spacing: spacing,
        children: [
          SizedQuilterGrid(
              spacing: spacing,
              size: size / 2,
              items: previews.getRange(0, 2).toList(),
              crossAxis: 2,
              mainAxis: 2),
          SizedQuilterGrid(
              spacing: spacing,
              size: size / 2,
              items: previews.getRange(2, 5).toList(),
              crossAxis: 3,
              mainAxis: 2),
        ],
      );
    }
    if (previews.length == 6) {
      gridLayout = SimpleQuilterWrap(
        spacing: spacing,
        children: [
          SizedQuilterGrid(
              spacing: spacing,
              size: size / 2,
              items: previews.getRange(0, 3).toList(),
              crossAxis: 3,
              mainAxis: 2),
          SizedQuilterGrid(
              spacing: spacing,
              size: size / 2,
              items: previews.getRange(3, 6).toList(),
              crossAxis: 3,
              mainAxis: 2),
        ],
      );
    }
    if (previews.length == 7) {
      gridLayout = SimpleQuilterWrap(
        spacing: spacing,
        children: [
          SizedQuilterGrid(
              spacing: spacing,
              size: size / 2,
              items: previews.getRange(0, 3).toList(),
              crossAxis: 3,
              mainAxis: 2),
          SizedQuilterGrid(
              spacing: spacing,
              size: size / 2,
              items: previews.getRange(3, 7).toList(),
              crossAxis: 4,
              mainAxis: 2),
        ],
      );
    }
    if (previews.length == 8) {
      gridLayout = SimpleQuilterWrap(
        spacing: spacing,
        children: [
          SizedQuilterGrid(
              spacing: spacing,
              size: size / 2,
              items: previews.getRange(0, 4).toList(),
              crossAxis: 4,
              mainAxis: 2),
          SizedQuilterGrid(
              spacing: spacing,
              size: size / 2,
              items: previews.getRange(4, 8).toList(),
              crossAxis: 4,
              mainAxis: 2),
        ],
      );
    }
    if (previews.length == 9) {
      gridLayout = SimpleQuilterWrap(
        spacing: spacing,
        children: [
          SizedQuilterGrid(
              spacing: spacing,
              size: size / 3,
              items: previews.getRange(0, 3).toList(),
              crossAxis: 3,
              mainAxis: 1),
          SizedQuilterGrid(
              spacing: spacing,
              size: size / 3,
              items: previews.getRange(3, 6).toList(),
              crossAxis: 3,
              mainAxis: 1),
          SizedQuilterGrid(
              spacing: spacing,
              size: size / 3,
              items: previews.getRange(6, 9).toList(),
              crossAxis: 3,
              mainAxis: 1),
        ],
      );
    }
    return gridLayout;
  }
}

class SimpleQuilterWrap extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  const SimpleQuilterWrap({
    super.key,
    required this.children,
    this.spacing = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      runSpacing: spacing,
      children: children,
    );
  }
}

class SizedQuilterGrid extends StatelessWidget {
  final Widget Function(Widget, PreviewModel, int)? childBuilder;
  final double spacing;
  const SizedQuilterGrid(
      {super.key,
      required this.size,
      required this.items,
      required this.crossAxis,
      required this.mainAxis,
      this.width = double.infinity,
      this.spacing = 2,
      this.childBuilder});

  final double size;
  final double width;
  final int crossAxis;
  final int mainAxis;
  final List<PreviewModel> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: width,
      child: NestedQuilterGrid(
        counter:
            PreviewGalleryCounter.withCrossAxisOf(crossAxis, items, mainAxis),
        previews: items,
        height: size,
        spacing: spacing,
      ),
    );
  }
}

class NestedQuilterGrid extends StatelessWidget {
  final Widget Function(Widget, PreviewModel, int)? childBuilder;
  final PreviewGalleryCounter counter;
  final List<PreviewModel> previews;
  final double height;
  final double width;
  final double spacing;
  const NestedQuilterGrid({
    super.key,
    required this.counter,
    required this.previews,
    this.height = double.infinity,
    this.width = double.infinity,
    this.spacing = 2,
    this.childBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      shrinkWrap: true,
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: counter.crossAxisCount,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: counter.pattern,
      ),
      scrollDirection: counter.direction,
      physics: const NeverScrollableScrollPhysics(),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: previews.length,
        (context, index) => childBuilder != null
            ? childBuilder!(
                PreviewItem(
                  preview: previews[index],
                  height: height,
                  width: width,
                ),
                previews[index],
                index,
              )
            : PreviewItem(
                preview: previews[index],
                height: height,
                width: width,
              ),
      ),
    );
  }
}

class PreviewItem extends StatelessWidget {
  final PreviewModel preview;
  final double height;
  final double width;
  final BoxFit fit;
  const PreviewItem(
      {super.key,
      required this.preview,
      required this.height,
      this.width = double.infinity,
      this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: height,
          width: width,
          child: (preview.file != null)
              ? (preview.uploading)
                  ? BlurredImage(
                      image: FileImage(
                        preview.file!,
                      ),
                      fit: fit,
                    )
                  : Image.file(
                      preview.file!,
                      fit: fit,
                    )
              : FutureBuilder(
                  future: preview.url.validateImage(),
                  builder: (context, result) {
                    if (result.data == false) {
                      return Container(color: ColorConstant.neutral800);
                    }
                    return Image.network(
                      preview.url,
                      fit: fit,
                    );
                  },
                ),
        ),
        if (preview.isVideoPreview)
          SizedBox(
            height: height,
            width: width,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(height > 50 ? 20.0 : 2.0),
                child: SvgAsset(
                  asset: AssetConstant.playIcon,
                  size: height > 50 ? 50 : 10,
                  color: ColorConstant.shade00,
                ),
              ),
            ),
          )
      ],
    );
  }
}
