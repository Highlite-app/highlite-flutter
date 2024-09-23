import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/constants/text_style.dart';

import '../../../../core/resources/color_constants.dart';
import '../../../../core/resources/typography_theme.dart';
import '../../svg/bordered_svg.dart';
import '../chat_bubble.dart';

class FileChatBubble extends StatelessWidget {
  final ChatMessage chatMessage;
  final FileMessage fileMessage;
  final BorderRadius borderRadius;
  final bool isMe;
  final bool visible;
  final bool uploading;
  const FileChatBubble({
    super.key,
    required this.fileMessage,
    required this.chatMessage,
    required this.borderRadius,
    required this.isMe,
    required this.visible,
    this.uploading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: uploading ? ColorConstant.neutral300 : ColorConstant.neutral100,
            borderRadius: borderRadius,
          ),
          constraints: const BoxConstraints(maxWidth: 280),
          padding:
              const EdgeInsets.only(top: 6, bottom: 8, left: 16, right: 16),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              FileBubble(
                isMe: isMe,
                fileMessage: fileMessage,
                chatMessage: chatMessage,
                visible: visible,
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
  final bool isMe;
  final FileMessage fileMessage;
  final ChatMessage chatMessage;
  final bool visible;
  final bool uploading;
  const FileBubble({
    super.key,
    required this.isMe,
    required this.fileMessage,
    required this.chatMessage,
    required this.visible,
    this.uploading = false,
  });

  @override
  Widget build(BuildContext context) {
    var bubbleTextColor = ColorConstant.neutral900;
    var timestampTextColor = ColorConstant.neutral700;
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: FileMessageContents(
        fileMessage: fileMessage,
        titleColor: bubbleTextColor,
        subtitleColor: timestampTextColor,
        uploading: uploading,
        child: (chatMessage.timestamp != null)
            ? Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      chatMessage.timestamp!,
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
      ),
    );
  }
}

class FileMessageContents extends StatelessWidget {
  final Widget? child;
  final FileMessage fileMessage;
  final Color titleColor;
  final Color subtitleColor;
  final bool uploading;
  const FileMessageContents({
    super.key,
    this.child,
    required this.fileMessage,
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
                fileMessage.fileName,
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
                    fileMessage.bytes,
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
