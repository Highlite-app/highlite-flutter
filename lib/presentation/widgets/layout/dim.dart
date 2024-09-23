import 'package:flutter/material.dart';

class Dim extends StatelessWidget {
  final double opacityTop;
  final double opacityBottom;
  final double? height;
  const Dim({
    super.key,
    required this.opacityTop,
    required this.opacityBottom,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(opacityTop),
            Colors.black.withOpacity(opacityBottom),
          ],
        ),
      ),
    );
  }
}
