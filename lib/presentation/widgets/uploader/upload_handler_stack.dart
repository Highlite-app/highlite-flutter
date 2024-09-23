import 'package:flutter/material.dart';
import '../../bloc/upload_handler/upload_handler_builder.dart';
import '../../bloc/upload_handler/upload_handler_event.dart';
import 'overlaying_upload_toast.dart';

class UploadHandlerToast extends StatelessWidget {
  const UploadHandlerToast({super.key});

  @override
  Widget build(BuildContext context) {
    return UploadHandlerBuilderWidget(
      builder: (context, state) {
        if (state.disposed) {
          return Container();
        }
        return UploadingToastStack(
          children: state.progressIndications,
          visible: state.visible,
          onClose: (key) {
            uploadHandler.add(RemoveIndicationEvent(key));
          },
        );
      },
    );
  }
}
