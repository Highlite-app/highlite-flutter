import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import '../navigation/back_button.dart';
import 'base_appbar.dart';

class TitledAppBar extends StatelessWidget with BaseAppBar {
  final String title;
  final TextStyle? style;
  final bool includesBorder;
  final List<Widget> actions;
  final VoidCallback? onPop;
  final Color color;
  final Color textColor;
  TitledAppBar({
    super.key,
    required this.title,
    this.style,
    this.includesBorder = true,
    this.actions = const [],
    this.onPop,
    this.color = ColorConstant.shade00,
    this.textColor = ColorConstant.neutral800,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: includesBorder? BoxDecoration(  
          border: Border(
            bottom: BorderSide(
              color: ColorConstant.shade100.withOpacity(0.10),
              width: 1,
            ),
          ),
        ) : null,
        child: AppBar(
          toolbarHeight: 50.0,
          leading: BackNavigationButton(
            navigator: context.navigator,
            size: 24,
            padding: 0,
            onPop: onPop,
            color: textColor,
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: color,
          shape: includesBorder
              ? Border(
                  bottom: BorderSide(
                    color: ColorConstant.shade100.withOpacity(0.10),
                    width: 1,
                  ),
                )
              : null,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: Text(
              title,
              style: style ??
                   BaseTextStyle(
                    fontSize: TypographyTheme.paragraph_p3,
                    color: ColorConstant.neutral800,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          actions: actions,
        ),
      ),
    );
  }
}
