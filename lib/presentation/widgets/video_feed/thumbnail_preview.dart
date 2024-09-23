import 'package:flutter/material.dart';

import '../layout/dim.dart';

class ThumbnailPreview extends StatelessWidget {
  final ImageProvider provider;
  final bool hasDim;

  const ThumbnailPreview({
    super.key,
    required this.provider,
    this.hasDim = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: provider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (hasDim)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Dim(
              height: 100,
              opacityTop: 0.0,
              opacityBottom: 0.4,
            ),
          ),
      ],
    );
  }
}
