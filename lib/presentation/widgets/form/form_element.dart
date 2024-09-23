import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';

class FormElement extends StatelessWidget {
  final String? title;
  final String? captionText;
  final Widget child;
  final Widget? footer;
  final bool hasErrors;
  final Axis axis;
  final String? errorText;
  final Color titleColor;
  final FontWeight titleWeight;
  final EdgeInsets titlePadding;
  const FormElement({
    super.key,
    this.title,
    this.captionText,
    required this.child,
    this.footer,
    required this.hasErrors,
    this.axis = Axis.horizontal,
    this.errorText,
    this.titleColor = ColorConstant.neutral500,
    this.titleWeight = FontWeight.w500,
    this.titlePadding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Wrap(
        direction: axis,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 8.0,
        runSpacing: 2.0,
        children: [
          if (title != null)
            Padding(
              padding: titlePadding,
              child: Text(
                title!,
                style: BaseTextStyle(
                  fontSize: TypographyTheme.paragraph_p3,
                  color: titleColor,
                  fontWeight: titleWeight,
                ),
              ),
            ),
          child,
          if (captionText != null)
            Text(
              captionText!,
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p3,
                color: hasErrors
                    ? ColorConstant.destructive400
                    : ColorConstant.neutral500,
                fontWeight: FontWeight.w500,
              ),
            ),
          if (footer != null) footer!,
          if (errorText != null)
            Text(
              errorText!,
              style: BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p3,
                color: hasErrors
                    ? ColorConstant.destructive400
                    : ColorConstant.neutral500,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}

class FormContainer extends StatelessWidget {
  final Widget child;
  const FormContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      decoration: BoxDecoration(
        color: ColorConstant.neutral50,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: child,
      ),
    );
  }
}
