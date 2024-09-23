import 'package:flutter/material.dart';
import '../../../core/resources/asset_constants.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/typography_theme.dart';
import '../../../data/models/onboarding/firebox_message.dart';
import '../buttons/tiny_button.dart';
import '../constants/text_style.dart';
import '../gallery/preview_gallery.dart';
import '../text/iconized_text.dart';

class ReplyContent {
  final String messageId;
  final String replyTo;
  final String? message;
  final List<String>? photos;
  final List<String>? previews;
  final FileboxMessage? fileMessage;
  const ReplyContent(
      {required this.messageId,
      required this.replyTo,
      this.message,
      this.photos,
      this.previews,
      this.fileMessage});
}

class ReplyHeading extends StatelessWidget {
  final ReplyContent content;
  final VoidCallback onClose;
  const ReplyHeading({
    super.key,
    required this.content,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 12, right: 16.0, left: 16.0),
      decoration:  BoxDecoration(
        color: ColorConstant.shade00,
        border: Border(top: BorderSide(width: 1, color: ColorConstant.neutral50)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Replying to ${content.replyTo}",
                  style:  BaseTextStyle(
                    color: ColorConstant.neutral800,
                    fontSize: TypographyTheme.paragraph_p4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                if (content.message != null)
                  Text(
                    content.message!,
                    overflow: TextOverflow.ellipsis,
                    style:  BaseTextStyle(
                      color: ColorConstant.neutral600,
                      fontSize: TypographyTheme.paragraph_p4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (content.photos != null)
                  IconizedText(
                    icon: AssetConstant.galleryIcon,
                    iconColor: ColorConstant.neutral800,
                    iconSize: 16,
                    text: content.photos?.length == 1
                        ? "photo"
                        : "photo",
                    textColor: ColorConstant.neutral600,
                    textSize: TypographyTheme.paragraph_p4,
                    fontWeight: FontWeight.w500,
                  ),
                if (content.previews != null)
                  IconizedText(
                    icon: "video-recorder",
                    iconColor: ColorConstant.neutral800,
                    iconSize: 16,
                    text: content.previews?.length == 1
                        ? "video"
                        : "videos",
                    textColor: ColorConstant.neutral600,
                    textSize: TypographyTheme.paragraph_p4,
                    fontWeight: FontWeight.w500,
                  ),
                if (content.fileMessage != null)
                  IconizedText(
                    icon: "file-06",
                    iconColor: ColorConstant.neutral800,
                    iconSize: 16,
                    text: "attachment",
                    textColor: ColorConstant.neutral600,
                    textSize: TypographyTheme.paragraph_p4,
                    fontWeight: FontWeight.w500,
                  ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (content.photos != null)
                  PreviewGallery(
                    size: 50,
                    previews: content.photos!
                        .map((photo) =>
                            PreviewModel(url: photo, isVideoPreview: false))
                        .toList(),
                  ),
                if (content.previews != null)
                  PreviewGallery(
                    size: 50,
                    previews: content.previews!
                        .map((photo) =>
                            PreviewModel(url: photo, isVideoPreview: true))
                        .toList(),
                  ),
                const SizedBox(
                  width: 10.0,
                ),
                TinyButton(
                  color: ColorConstant.neutral100,
                  splashColor: ColorConstant.neutral50,
                  onTap: onClose,
                  icon: "x-01",
                  iconColor: ColorConstant.neutral800,
                  size: 24,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
