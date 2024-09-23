import 'package:flutter/material.dart';

import '../layout/wrap_stack.dart';
import '../text/bulletted_text.dart';

class BulletList extends StatelessWidget {
  final List<String> bullets;
  const BulletList({
    super.key,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return WrappedStack(
      widgets: bullets.map((e) => BullettedText(text: e)).toList(),
      alignment: MainAxisAlignment.start,
      direction: Axis.vertical,
    );
  }
}
