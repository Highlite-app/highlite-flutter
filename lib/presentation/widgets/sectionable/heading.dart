import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';

class Heading extends StatelessWidget {
  final String title;
  final double spacing ;
  final TextStyle? textStyle ;
  final Widget? child;

  const Heading({
    this.spacing = 4.0 ,
    this.textStyle ,
    this.child ,
    required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textStyle ?? BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p3,
            fontWeight: FontWeight.w500,
            color: ColorConstant.shade100,
          ),
        ),
         SizedBox(height: spacing),
        if(child !=null  ) child ?? const SizedBox.shrink()
      ],
    );
  }
}
