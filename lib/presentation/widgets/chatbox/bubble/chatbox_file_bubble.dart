import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import '../../../../core/resources/color_constants.dart';
import '../../../../core/resources/typography_theme.dart';
import '../../constants/text_style.dart';
import '../../svg/bordered_svg.dart';
import '../chatbox_message.dart';

class FileChatboxBubble extends StatelessWidget {
  final FileboxMessage fileboxMessage;
  final BubbleDirection direction;
  final BubblePosition position;
  final bool uploading;
  const FileChatboxBubble({
    super.key,
    required this.fileboxMessage,
    required this.direction,
    required this.position,
    this.uploading = false,
  });

  BorderRadius get radius {
    const cornerActive = 16.00;
    const cornerInactive = 4.00;
    BorderRadius borderRadius;
    if (position == BubblePosition.start) {
      borderRadius = BorderRadius.only(
        topLeft: const Radius.circular(cornerActive),
        topRight: const Radius.circular(cornerActive),
        bottomLeft: Radius.circular(
            direction == BubbleDirection.left ? cornerInactive : cornerActive),
        bottomRight: Radius.circular(
            direction == BubbleDirection.left ? cornerActive : cornerInactive),
      );
    } else if (position == BubblePosition.middle) {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(
            direction == BubbleDirection.left ? cornerInactive : cornerActive),
        topRight: Radius.circular(
            direction == BubbleDirection.left ? cornerActive : cornerInactive),
        bottomLeft: Radius.circular(
            direction == BubbleDirection.left ? cornerInactive : cornerActive),
        bottomRight: Radius.circular(
            direction == BubbleDirection.left ? cornerActive : cornerInactive),
      );
    } else {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(
            direction == BubbleDirection.left ? cornerInactive : cornerActive),
        bottomLeft: const Radius.circular(cornerActive),
        topRight: Radius.circular(
            direction == BubbleDirection.left ? cornerActive : cornerInactive),
        bottomRight: const Radius.circular(cornerActive),
      );
    }
    return borderRadius;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: uploading ? ColorConstant.neutral300 : ColorConstant.neutral100,
            borderRadius: radius,
          ),
          constraints: const BoxConstraints(maxWidth: 280),
          padding:
              const EdgeInsets.only(top: 6, bottom: 8, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: direction == BubbleDirection.right
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              FileBubble(
                fileName: fileboxMessage.fileName,
                fileBytes: fileboxMessage.fileBytes,
                uploading: uploading,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FileBubble extends StatelessWidget {
  final String fileName;
  final String fileBytes;
  final String? timestamp;
  final bool uploading;
  const FileBubble({
    super.key,
    required this.fileName,
    required this.fileBytes,
    this.timestamp,
    this.uploading = false,
  });

  @override
  Widget build(BuildContext context) {
    var bubbleTextColor = ColorConstant.neutral900;
    var timestampTextColor = ColorConstant.neutral700;
    return FileMessageContents(
      fileName: fileName,
      fileBytes: fileBytes,
      titleColor: bubbleTextColor,
      subtitleColor: timestampTextColor,
      uploading: uploading,
      child: (timestamp != null)
          ? Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    timestamp!,
                    style: BaseTextStyle(
                      color: timestampTextColor,
                      fontSize: TypographyTheme.paragraph_p5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}

class FileMessageContents extends StatelessWidget {
  final Widget? child;
  final String fileName;
  final String fileBytes;
  final Color titleColor;
  final Color subtitleColor;
  final bool uploading;
  const FileMessageContents({
    super.key,
    this.child,
    required this.fileName,
    required this.fileBytes,
    required this.titleColor,
    required this.subtitleColor,
    this.uploading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         BorderedSvg(
          asset: AssetConstant.fileIcon,
          assetColor: ColorConstant.neutral800,
          assetPadding: 8,
          size: 20,
          backgroundColor: ColorConstant.neutral50,
          shape: BoxShape.circle,
        ),
        const SizedBox(
          width: 8.0,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fileName,
                textAlign: TextAlign.start,
                style: BaseTextStyle(
                  color: titleColor,
                  fontSize: TypographyTheme.paragraph_p3,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    fileBytes,
                    style: BaseTextStyle(
                      color: subtitleColor,
                      fontSize: TypographyTheme.paragraph_p5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (child != null) child!
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
