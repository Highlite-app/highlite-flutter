import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

class HorizontalButtonStack extends StatelessWidget {
  final Color? backgroundColor;
  final List<Widget> children;

  const HorizontalButtonStack({
    super.key,
    this.backgroundColor,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? ColorConstant.shade00,
      width: double.infinity,
      child: Wrap(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
