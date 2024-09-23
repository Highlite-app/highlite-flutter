import 'package:flutter/material.dart';

import 'indicator_contents.dart';
import 'indicator_divider.dart';

class ProgressIndicatorStack extends StatelessWidget {
  final String placeholder;
  final double progress;
  final int millis;
  final bool isDivided;
  final VoidCallback onClose;
  const ProgressIndicatorStack({
    super.key,
    required this.placeholder,
    required this.progress,
    required this.millis,
    this.isDivided = false,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: [
        IndicatorContents(
          placeholder: placeholder,
          progress: progress,
          millis: millis,
          onClose: onClose,
        ),
        if (isDivided) const IndicatorDivider(),
      ],
    );
  }
}
