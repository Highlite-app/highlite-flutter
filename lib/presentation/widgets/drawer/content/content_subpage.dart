import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../../core/resources/typography_theme.dart';
import '../../constants/text_style.dart';
import '../../navigation/navigated_page.dart';

class ContentSubpage extends StatelessWidget {
  final String title;
  final String content;
  const ContentSubpage({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return NavigatedPage(
      title: title,
      includesBorder: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: EasyRichText(
            content,
            defaultStyle:  BaseTextStyle(
              color: ColorConstant.neutral800,
              fontSize: TypographyTheme.paragraph_p3,
            ),
          ),
        ),
      ),
    );
  }
}

class ContentContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Color backgroundColor;
  const ContentContainer({
    super.key,
    required this.title,
    required this.children,
    this.backgroundColor = ColorConstant.shade00,
  });

  @override
  Widget build(BuildContext context) {
    return NavigatedPage(
      title: title,
      includesBorder: true,
      backgroundColor: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  }
}

class ContentSubcontainer extends StatelessWidget {
  final String title;
  final Widget child;
  final Color backgroundColor;
   const ContentSubcontainer({
    super.key,
    required this.title,
    required this.child,
    this.backgroundColor = ColorConstant.shade00,
  }) ;

  @override
  Widget build(BuildContext context) {
    return NavigatedPage(
      title: title,
      includesBorder: true,
      backgroundColor: backgroundColor,
      child: child,
    );
  }
}
