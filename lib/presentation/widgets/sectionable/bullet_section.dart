import 'package:flutter/material.dart';

import 'bullet_list.dart';
import 'sectionable.dart';

class BulletSection extends StatelessWidget {
  final List<String> bullets;
  const BulletSection({
    super.key,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Section(
      child: BulletList(
        bullets: bullets,
      ),
    );
  }
}
