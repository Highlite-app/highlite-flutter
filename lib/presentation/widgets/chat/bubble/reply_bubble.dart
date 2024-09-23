
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import '../../../../core/resources/typography_theme.dart';
import '../../constants/text_style.dart';
import '../../layout/measure_size.dart';
import '../../text/iconized_text.dart';
import '../chat_bubble.dart';
import '../reply_heading.dart';


class FloatingReplyBubble extends StatefulWidget {
  final bool isMe;
  final ChatMessage chatMessage;
  final bool visible;
  final BorderRadius borderRadius;
  final OnWidgetSizeChange onChange;
  final bool showTimestamp;
  const FloatingReplyBubble({
    super.key,
    required this.isMe,
    required this.chatMessage,
    required this.visible,
    required this.borderRadius,
    required this.onChange,
    required this.showTimestamp,
  });

  @override
  State<FloatingReplyBubble> createState() => _FloatingReplyBubbleState();
}

class _FloatingReplyBubbleState extends State<FloatingReplyBubble> {
  double replySize = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.isMe) {
      double additionPadding = 0;
      if (widget.chatMessage.previews != null) {
        additionPadding = 50;
      }
      if (widget.chatMessage.file != null) {
        additionPadding = 75;
      }
      return Positioned(
        bottom:
            (replySize) + (widget.showTimestamp ? 36 : 20) + additionPadding,
        right: -5,
        child: Row(
          mainAxisAlignment:
              widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            MeasureSize(
              onChange: (size) {
                if (size.height != replySize) {
                  setState(() {
                    replySize = size.height;
                  });
                  widget.onChange(size);
                }
              },
              child: ReplyChatBubble(
                borderRadius: widget.borderRadius,
                isMe: widget.isMe,
                content: widget.chatMessage.repliedContent!,
                visible: widget.visible,
              ),
            )
          ],
        ),
      );
    } else {
      double additionPadding = 0;
      if (widget.chatMessage.previews != null) {
        additionPadding = 60;
      }
      if (widget.chatMessage.file != null) {
        additionPadding = 75;
      }
      return Positioned(
        top: (replySize * -1) + 10 + additionPadding,
        left: 40,
        child: Row(
          mainAxisAlignment:
              widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            MeasureSize(
              onChange: (size) {
                setState(() {
                  replySize = size.height;
                });
              },
              child: ReplyChatBubble(
                  borderRadius: widget.borderRadius,
                  isMe: widget.isMe,
                  content: widget.chatMessage.repliedContent!,
                  visible: widget.visible),
            )
          ],
        ),
      );
    }
  }
}

class ReplyChatBubble extends StatelessWidget {
  final BorderRadius borderRadius;
  final bool isMe;
  final bool visible;
  final ReplyContent content;
  const ReplyChatBubble({
    super.key,
    required this.borderRadius,
    required this.isMe,
    required this.content,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    final iconized = IconizedText(
      icon: AssetConstant.shareIcon,
      iconColor: ColorConstant.neutral600,
      iconSize: 16,
      text: "You replied to ${content.replyTo}",
      textColor: ColorConstant.neutral600,
      textSize: TypographyTheme.paragraph_p4,
      fontWeight: FontWeight.w500,
    );
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (isMe) Positioned(top: -25, right: 3, child: iconized),
        if (!isMe) Positioned(top: -25, left: 0, child: iconized),
        Container(
          decoration: BoxDecoration(
            color: ColorConstant.neutral50,
            borderRadius: borderRadius,
          ),
          constraints: const BoxConstraints(maxWidth: 250),
          padding:
              const EdgeInsets.only(top: 6, bottom: 8, left: 16, right: 16),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              ReplyBubble(isMe: isMe, visible: visible, content: content)
            ],
          ),
        ),
      ],
    );
  }
}

class ReplyBubble extends StatelessWidget {
  final bool isMe;
  final ReplyContent content;
  final bool visible;
  const ReplyBubble(
      {super.key,
      required this.isMe,
      required this.visible,
      required this.content});

  @override
  Widget build(BuildContext context) {
    var bubbleTextColor = ColorConstant.neutral600;
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (content.previews != null || content.photos != null)
            EasyRichText(
              "You" ,
              // currentLocalizations
              //     .sentAttachmentConversation(isMe ? "You" : content.replyTo),
              defaultStyle: BaseTextStyle(
                color: bubbleTextColor,
                fontSize: TypographyTheme.paragraph_p3,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              patternList: [
                EasyRichTextPattern(
                  targetString: '(\\*)(.*?)(\\*)',
                  matchBuilder: (BuildContext context, RegExpMatch? match) {
                    return TextSpan(
                        text: match?[0]?.replaceAll('*', ''),
                        style: const TextStyle(fontWeight: FontWeight.bold));
                  },
                )
              ],
              textAlign: TextAlign.start,
            ),
          if (content.message != null)
            EasyRichText(
              content.message!,
              defaultStyle: BaseTextStyle(
                color: bubbleTextColor,
                fontSize: TypographyTheme.paragraph_p3,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              patternList: [
                EasyRichTextPattern(
                  targetString: '(\\*)(.*?)(\\*)',
                  matchBuilder: (BuildContext context, RegExpMatch? match) {
                    return TextSpan(
                        text: match?[0]?.replaceAll('*', ''),
                        style: const TextStyle(fontWeight: FontWeight.bold));
                  },
                )
              ],
              textAlign: TextAlign.start,
            ),
          // if (content.fileMessage != null)
          //   FileMessageContents(
          //     fileMessage: content.fileMessage!,
          //     titleColor: bubbleTextColor,
          //     subtitleColor: bubbleTextColor,
          //   ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
