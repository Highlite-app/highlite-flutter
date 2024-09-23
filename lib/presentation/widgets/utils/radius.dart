import 'package:flutter/material.dart';

class CircularRadiusContent {
  final Radius all;
  final Radius topLeft;
  final Radius topRight;
  final Radius bottomLeft;
  final Radius bottomRight;
  CircularRadiusContent(double radius)
      : topLeft = Radius.circular(radius),
        topRight = Radius.circular(radius),
        bottomLeft = Radius.circular(radius),
        bottomRight = Radius.circular(radius),
        all = Radius.circular(radius);
}
