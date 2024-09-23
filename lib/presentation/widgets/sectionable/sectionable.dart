import 'package:flutter/material.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';

class Sectionable extends StatelessWidget {
  final List<Widget> sections;
  final EdgeInsets padding;
  const Sectionable({
    super.key,
    required this.sections,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: CustomScrollView(
        slivers: sections,
      ),
    );
  }
}

class Section extends StatelessWidget {
  final Widget child;
  final String? title;
  final EdgeInsets padding;
  const Section({
    super.key,
    required this.child,
    this.title,
    this.padding = const EdgeInsets.only(bottom: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) SectionTitle(title: title!),
              child,
            ],
          ),
          childCount: 1,
        ),
      ),
    );
  }
}

class RowSection extends StatelessWidget {
  final List<Widget> children;
  final String? title;
  final EdgeInsets padding;
  const RowSection({
    super.key,
    required this.children,
    this.title,
    this.padding = const EdgeInsets.only(bottom: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
          childCount: 1,
        ),
      ),
    );
  }
}

class CustomSection extends StatelessWidget {
  final Widget child;
  final String? title;
  final EdgeInsets padding;
  const CustomSection({
    super.key,
    required this.child,
    this.title,
    this.padding = const EdgeInsets.only(bottom: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => child,
          childCount: 1,
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style:  BaseTextStyle(
        fontSize: TypographyTheme.paragraph_p3,
        color: ColorConstant.neutral500,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class SectionSpacer extends StatelessWidget {
  final double space;
  const SectionSpacer({
    super.key,
    this.space = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: space),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Container(),
          childCount: 1,
        ),
      ),
    );
  }
}
