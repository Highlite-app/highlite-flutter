import 'package:flutter/material.dart';

TextStyle baseTextStyle(
    {required double fontSize,
      required Color color,
      FontWeight? fontWeight,
      double height = 1.6,
      double letterSpacing = -0.32}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    letterSpacing: letterSpacing,
    fontWeight: fontWeight,
    wordSpacing: 0.3,
    height: height,
  );
}

TextStyle basicTextStyle = const TextStyle(
  wordSpacing: 0.3,
  letterSpacing: -0.32,
  height: 1.6,
);

TextStyle iconStyle() {
  return const TextStyle(fontSize: 24.0);
}

class BaseTextStyle extends TextStyle {
  const BaseTextStyle({
    required Color color,
    required double fontSize,
    FontWeight? fontWeight,
    double wordSpacing = 0.3,
    double letterSpacing = -0.32,
    double height = 1.6,
  }) : super(
    fontFamily: "Inter",
    fontSize: fontSize,
    color: color,
    letterSpacing: letterSpacing,
    fontWeight: fontWeight,
    wordSpacing: 0.3,
    height: height,
  );
}
