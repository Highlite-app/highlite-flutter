import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';

class SegmentedControls extends StatelessWidget {
  final TextStyle? textStyle;
  final List<String> options;
  final String initialValue;
  final Function(String) onValueChanged;
  final CustomSegmentedController<String>? controller;
  final double width;
  final double padding;
  final EdgeInsets innerPadding;

  const SegmentedControls({
    super.key,
    this.textStyle,
    required this.options,
    required this.initialValue,
    required this.onValueChanged,
    required this.controller,
    this.width = 110.0,
    this.padding = 4.0,
    this.innerPadding = const EdgeInsets.all(4.0),
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = BaseTextStyle(
      fontSize: TypographyTheme.paragraph_p4,
      color: ColorConstant.neutral800,
      fontWeight: FontWeight.w600,
    );
    if (this.textStyle != null) {
      textStyle = this.textStyle!;
    }
    Map<String, Widget> widgets = {};
    for (var option in options) {
      widgets[option] = Text(
        option,
        style: textStyle,
      );
    }
    return CustomSlidingSegmentedControl<String>(
      initialValue: "All",
      children: widgets,
      fixedWidth: width,
      innerPadding: innerPadding,
      padding: padding,
      decoration: BoxDecoration(
        color: ColorConstant.neutral50,
        borderRadius: BorderRadius.circular(100.0),
      ),
      thumbDecoration: BoxDecoration(
        color: ColorConstant.neutral100,
        borderRadius: BorderRadius.circular(100.0),
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      controller: controller,
      onValueChanged: onValueChanged,
    );
  }
}
