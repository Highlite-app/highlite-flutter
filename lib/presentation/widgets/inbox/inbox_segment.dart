import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../segment/segmented_controls.dart';

class InboxSegment extends StatelessWidget {
  final List<String> options;
  final Function(String) onChangeSegment;
  final CustomSegmentedController<String>? controller;
  const InboxSegment({
    super.key,
    required this.onChangeSegment,
    required this.options,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (options.isNotEmpty) SegmentedControls(
            options: options,
            initialValue: options.first,
            onValueChanged: onChangeSegment,
            controller: controller,
            innerPadding: const EdgeInsets.all(6.0),
            padding: 8.0,
            width: 30.w,
          ),
        ],
      ),
    );
  }
}
