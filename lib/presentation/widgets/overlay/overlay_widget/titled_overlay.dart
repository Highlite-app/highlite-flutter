import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/svg_button.dart';

import '../../../../core/resources/spacing_theme.dart';
import '../../../../core/resources/typography_theme.dart';
import '../../appBar/titled_appbar.dart';
import '../../constants/text_style.dart';
import '../../modal/top_notch.dart';

class TitledOverlay extends StatelessWidget {
  final double height;
  final String title;
  final Widget child;
  final List<Widget> action ;
  final bool shouldIncludeTopNotch;
  final VoidCallback? onTapPlusIcon ;
  const TitledOverlay({
    super.key,
    this.height = 378,
    required this.title,
    required this.child,
    this.action =const  <Widget>[] ,
    this.shouldIncludeTopNotch = true,
     this.onTapPlusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: height,
            padding: const EdgeInsets.only(
              left: 5.0,
              right: 5.0,
              top: 24,
            ),
            decoration: const BoxDecoration(
              color: ColorConstant.shade00,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Spacing.spacing_big),
                topRight: Radius.circular(Spacing.spacing_big),
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Scaffold(
                      backgroundColor: ColorConstant.shade00,
                      appBar: TitledAppBar(
                        title: title,
                        actions: action,
                        style:  BaseTextStyle(
                          fontSize: TypographyTheme.paragraph_p1,
                          color: ColorConstant.neutral800,
                          fontWeight: FontWeight.w600,
                        ),
                        includesBorder: false,
                      ),
                      body: child,
                    ),
                  ),
                  if (shouldIncludeTopNotch)
                    const Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: TopNotch(),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
