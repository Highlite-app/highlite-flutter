import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/data/models/onboarding/file_model.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/bubble/previews_bubble.dart';

import '../../gallery/preview_gallery.dart';

class UploadingBubble extends StatelessWidget {
  final List<FileModel> uploadingPreviews;
  const UploadingBubble({super.key, required this.uploadingPreviews});

  @override
  Widget build(BuildContext context) {
    return  PreviewsBubble(
          previews: uploadingPreviews
              .map(
                (preview) => PreviewModel(
                  url: "",
                  file: preview.file,
                  fileType: preview.fileType,
                  uploading: false,
                ),
              )
              .toList(),
          //TODO: ADD LOGIC USING BLOC
          childBuilder: (child, model, index) => Container()

    );
  }
}
