import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/navigation/navigated_page.dart';

class ResumeNavigation extends StatelessWidget {
  final List<Widget> children ;
  const ResumeNavigation({
    required this.children,
    super.key});

  @override
  Widget build(BuildContext context) {
    return NavigatedPage(
        includesBorder: false,
        backgroundColor: ColorConstant.shade00,
        child: SingleChildScrollView(
         child: Wrap(
           spacing: 20.0,
           runSpacing: 20.0,
           children: children,
         ),
        )

    );
  }
}
