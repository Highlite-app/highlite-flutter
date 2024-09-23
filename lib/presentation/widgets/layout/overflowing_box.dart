import 'package:flutter/material.dart';

class OverflowingBox extends StatelessWidget {
  final Size size;
  final Widget child;
  const OverflowingBox({
    super.key,
    required this.size,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: OverflowBox(
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.center,
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [child],
            ),
          ),
        ),
      ),
    );
  }
}
