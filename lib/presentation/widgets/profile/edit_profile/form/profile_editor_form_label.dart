import 'package:flutter/material.dart';
import '../../../../../core/resources/color_constants.dart';
import '../../../../../core/resources/typography_theme.dart';
import '../../../constants/text_style.dart';

class ProfileEditorFormLabel extends StatelessWidget {
  final String label;
  final bool padded;
  const ProfileEditorFormLabel({
    super.key,
    required this.label,
    this.padded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padded ? 10.0 : 2.0),
      child: Text(
        label,
        style:  BaseTextStyle(
          fontSize: TypographyTheme.paragraph_p3,
          color: ColorConstant.neutral500,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
