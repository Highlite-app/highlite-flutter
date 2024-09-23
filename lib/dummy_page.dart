import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/typography_theme.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Coming Soon ..." ,
        style: BaseTextStyle(
            fontSize: TypographyTheme.paragraph_p4,
            color: ColorConstant.neutral700,
            fontWeight: FontWeight.w600
        ),
        ),
      ),
    );
  }
}
