import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../core/resources/typography_theme.dart';
import '../constants/text_style.dart';

class CustomSegmentedControls extends StatelessWidget {
  final List<String> options;
  final String currentValue;
  final Function(String) onValueChanged;
  final CustomSegmentedController<String>? controller;

  const CustomSegmentedControls({
    super.key,
    required this.options,
    required this.currentValue,
    required this.onValueChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =  BaseTextStyle(
      fontSize: TypographyTheme.paragraph_p3,
      color: ColorConstant.neutral800,
      fontWeight: FontWeight.w600,
    );
    TextStyle selectedStyle =  BaseTextStyle(
      fontSize: TypographyTheme.paragraph_p3,
      color: ColorConstant.shade00,
      fontWeight: FontWeight.w600,
    );
    Map<String, Widget> widgets = {};
    for (var option in options) {
      widgets[option] = Text(
        option,
        style: option == currentValue ? selectedStyle : textStyle,
      );
    }
    return CustomSlidingSegmentedControl<String>(
      initialValue: currentValue,
      children: widgets,
      fixedWidth: 90.0,
      innerPadding: const EdgeInsets.all(8.0),
      padding: 0.0,
      decoration: BoxDecoration(
        color: ColorConstant.primary50,
        borderRadius: BorderRadius.circular(100.0),
      ),
      thumbDecoration: BoxDecoration(
        color: ColorConstant.primary500,
        borderRadius: BorderRadius.circular(100.0),
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      controller: controller,
      onValueChanged: onValueChanged,
    );
  }
}
