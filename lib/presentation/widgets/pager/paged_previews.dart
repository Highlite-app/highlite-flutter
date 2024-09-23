import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/pager/pageview_indicator.dart';

import '../chip/paged_chip.dart';
import '../indicator/page_indicator.dart';

class PagedPreviews extends StatefulWidget {
  final List<String> previews;
  final double height;
  const PagedPreviews({
    super.key,
    required this.previews,
    required this.height,
  });

  @override
  State<PagedPreviews> createState() => _PagedPreviewsState();
}

class _PagedPreviewsState extends State<PagedPreviews> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    final widgets = widget.previews
        .map(
          (e) => SizedBox(
            width: double.infinity,
            height: widget.height,
            child: Image.network(e, fit: BoxFit.cover),
          ),
        )
        .toList();
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: widget.height,
          child: Stack(
            children: [
              PageView(
                controller: controller,
                onPageChanged: (int page) {
                  setState(() {
                    selectedIndex = page;
                  });
                },
                children: widgets,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: PagedChip(
                  length: widget.previews.length,
                  selectedIndex: selectedIndex,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        PageViewIndicator(
          selectedIndex: selectedIndex,
          pages: widgets,
          lightThemed: true,
          size: PageIndicatorSize.small,
          activeColor: ColorConstant.primary400,
          inactiveColor: ColorConstant.neutral100,
          paddedBottom: false,
        )
      ],
    );
  }
}
