import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/context.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';
import 'back_button.dart';

class NavigatedPage extends StatelessWidget {
  final Widget child;
  final String? title;
  final Color appBarColor;
  final Color backgroundColor;
  final bool includesBorder;
  final bool centerTitle;
  final List<Widget> actions;
  const NavigatedPage({
    super.key,
    required this.child,
    this.appBarColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.title,
    this.includesBorder = false,
    this.centerTitle = true,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: centerTitle,
        actions: actions,
        leading: BackNavigationButton(navigator: context.navigator),
        backgroundColor: appBarColor,
        elevation: 0,
        title: (title != null)
            ? Text(
                title!,
                style:  BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p3,
                  color: ColorConstant.neutral800,
                  fontWeight: FontWeight.w600,
                ),
              )
            : null,
        shape: includesBorder
            ? Border(
                bottom: BorderSide(
                  color: ColorConstant.shade100.withOpacity(0.10),
                  width: 1,
                ),
              )
            : null,
      ),
      backgroundColor: backgroundColor,
      body: child,
    );
  }
}
