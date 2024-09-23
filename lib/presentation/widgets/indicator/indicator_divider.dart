import 'package:flutter/material.dart';

class IndicatorDivider extends StatelessWidget {
  const IndicatorDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(height: 1),
    );
  }
}
