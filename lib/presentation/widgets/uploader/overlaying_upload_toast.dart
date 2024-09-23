import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';

import '../../../data/models/toast/progress_indicator.dart';
import '../indicator/progress_indicator_stack.dart';
import '../toaster/toast_container.dart';

class UploadingToastStack extends StatefulWidget {
  final List<ProgressIndication> children;
  final Function(String) onClose;
  final bool visible;
  const UploadingToastStack({
    super.key,
    required this.children,
    required this.onClose,
    required this.visible,
  });

  @override
  State<UploadingToastStack> createState() => _UploadingToastStackState();
}

class _UploadingToastStackState extends State<UploadingToastStack> {

  @override
  Widget build(BuildContext context) {
    return ToastContainer(
      visible: widget.visible,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: widget.children
              .mapIndexed(
                (indication, index) => ProgressIndicatorStack(
                  placeholder: indication.placeholder,
                  progress: indication.progress,
                  millis: indication.millis,
                  isDivided: widget.children.length >= 2 &&
                      index != widget.children.length - 1,
                  onClose: () => widget.onClose(
                    indication.id,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
