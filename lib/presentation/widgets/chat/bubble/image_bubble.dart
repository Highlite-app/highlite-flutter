import 'package:flutter/material.dart';
import '../../../../core/resources/color_constants.dart';
import 'previews_bubble.dart';
import 'uploading_bubble.dart';
import '../../../../core/resources/typography_theme.dart';
import '../../animated/sized_opacity.dart';
import '../../constants/text_style.dart';
import '../chat_bubble.dart';

class ImageThumbnail extends StatelessWidget {
  final ImageProvider image;
  const ImageThumbnail({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      margin: const EdgeInsets.only(
        top: 0,
        left: 0,
        right: 10,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(
          width: 250,
          height: 250,
          child: Image(image: image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class ImageBubble extends StatelessWidget {
  final ChatMessage chatMessage;
  final bool showTimestamp;
  const ImageBubble({
    super.key,
    required this.chatMessage,
    required this.showTimestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        chatMessage.previews != null
            ? PreviewsBubble(
                previews: chatMessage.previews!,
              )
            : chatMessage.uploadingPreviews != null
                ? UploadingBubble(
                    uploadingPreviews: chatMessage.uploadingPreviews!,
                  )
                : ImageThumbnail(
                    image: chatMessage.image!,
                  ),
        if (chatMessage.timestamp != null)
          SizedOpacity(
            height: 20,
            width: 45,
            visible: chatMessage.timestamp != null && showTimestamp,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 4.0),
              child: Text(
                chatMessage.timestamp!,
                textAlign: TextAlign.end,
                style:  BaseTextStyle(
                  color: ColorConstant.neutral600,
                  fontSize: TypographyTheme.paragraph_p5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
