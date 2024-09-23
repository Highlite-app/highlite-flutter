import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';

import '../indicator/page_indicator.dart';


class PageViewIndicator extends StatelessWidget {
  final int selectedIndex;
  final List<Widget> pages;
  final bool lightThemed;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool paddedBottom;
  final PageIndicatorSize size;
  const PageViewIndicator({
    super.key,
    required this.selectedIndex,
    required this.pages,
    required this.lightThemed,
    this.paddedBottom = true,
    this.activeColor,
    this.inactiveColor,
    this.size = PageIndicatorSize.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: paddedBottom
              ? const EdgeInsets.only(bottom: 36.0)
              : const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: pages
                .mapIndexed(
                  (page, index) => PageIndicator(
                    lightThemed: lightThemed,
                    isActive: index == selectedIndex,
                    size: size,
                    activeColor: activeColor,
                    inactiveColor: inactiveColor,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

