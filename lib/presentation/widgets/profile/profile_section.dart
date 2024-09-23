import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import 'edit_button.dart';

class ProfileSection extends StatelessWidget {
  final Widget widget;
  final bool includePadding;
  final VoidCallback? onEdit;
  final String? header;
  final bool addPadding;
  const ProfileSection({
    super.key,
    required this.widget,
    this.onEdit,
    this.header,
    this.includePadding = true,
    this.addPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget widgetContainer = Padding(
      padding: EdgeInsets.all(includePadding ? 16.0 : 0),
      child: widget,
    );

    return SliverPadding(
      padding: const EdgeInsets.only(top: 8.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: EdgeInsets.all(addPadding ? 0.0 : 0),
            child: Column(
              children: [
                if (header != null || onEdit != null) _headerWidget(),
                widgetContainer,
              ],
            ),
          ),
          childCount: 1,
        ),
      ),
    );
  }

  Padding _headerWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (header != null)
            Text(
              header!,
              style:  BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p4,
                color: ColorConstant.neutral800,
                fontWeight: FontWeight.w600,
              ),
            ),
          const Spacer(),
          if (onEdit != null)
            EditButtonProfile(
              onTap: onEdit,
            ),
        ],
      ),
    );
  }
}
