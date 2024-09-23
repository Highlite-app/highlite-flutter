import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';
class HeadingText extends StatelessWidget {
  final String headingText ;
  final String? subHeading ;
  const HeadingText({
    required this.headingText ,
    this.subHeading = "" ,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(headingText , style: BaseTextStyle(
          fontSize: TypographyTheme.heading_H5,
          color:  ColorConstant.shade100 ,
          fontWeight: FontWeight.w700 ,

        ),),
        const SizedBox(height: 8.0,) ,
        if(subHeading !=null || subHeading!="")
          Text(subHeading ?? '' , style: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p4,
            color:  ColorConstant.neutral600 ,
            fontWeight: FontWeight.w500 ,

          ),)

      ],
    );
  }
}
