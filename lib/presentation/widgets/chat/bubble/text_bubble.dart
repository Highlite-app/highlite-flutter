
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';

import '../../../../core/resources/typography_theme.dart';
import '../../animated/sized_opacity.dart';
import '../../buttons/tiny_button.dart';
import '../../constants/text_style.dart';
import '../chat_bubble.dart';


class TextChatBubble extends StatelessWidget {
  final Color bubbleColor;
  final BorderRadius borderRadius;
  final bool isMe;
  final ChatMessage chatMessage;
  final bool visible;
  final VoidCallback onEdit;
  final bool showTimestamp;

  const TextChatBubble({
    super.key,
    required this.bubbleColor,
    required this.borderRadius,
    required this.isMe,
    required this.chatMessage,
    required this.visible,
    required this.onEdit,
    required this.showTimestamp,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:chatMessage.editable? onEdit: (){},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: borderRadius,
            ),
            constraints: const BoxConstraints(maxWidth: 250),
            padding:
                const EdgeInsets.only(top: 6, bottom: 8, left: 16, right: 16),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (chatMessage.message != null)
                  TextBubble(
                    isMe: isMe,
                    chatMessage: chatMessage,
                    visible: visible,
                    showTimestamp: showTimestamp,
                  ),
              ],
            ),
          ),
          if (isMe && chatMessage.editable)
            Positioned(
              bottom: -10,
              left: -20,
              width: 28,
              height: 28,
              child: InkWell(
                onTap: onEdit,
                child: TinyButton(
                  color: ColorConstant.neutral200,
                  splashColor: ColorConstant.neutral400,
                  onTap: onEdit,
                  icon: AssetConstant.pencilIcon,
                  iconColor: ColorConstant.neutral800,
                  size: 25,
                  iconPadding: 8.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TextBubble extends StatelessWidget {
  final bool isMe;
  final ChatMessage chatMessage;
  final bool visible;
  final bool showTimestamp;
  const TextBubble({
    super.key,
    required this.isMe,
    required this.chatMessage,
    required this.visible,
    required this.showTimestamp,
  });

  @override
  Widget build(BuildContext context) {
    var bubbleTextColor = ColorConstant.shade100;
    var timestampTextColor = ColorConstant.neutral700;
    if (isMe) {
      bubbleTextColor = ColorConstant.shade00;
      timestampTextColor = ColorConstant.primary100;
    }
    if (chatMessage.status == BubbleStatus.error) {
      bubbleTextColor = Colors.white;
    } else if (chatMessage.status == BubbleStatus.success) {
      bubbleTextColor = ColorConstant.success900;
    } else if (chatMessage.status == BubbleStatus.undeterminedError) {
      bubbleTextColor = ColorConstant.destructive500;
    } else if (chatMessage.status == BubbleStatus.warningError) {
      bubbleTextColor = ColorConstant.warning600;
    }
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Column(
        crossAxisAlignment:
            !isMe ? CrossAxisAlignment.end : CrossAxisAlignment.end,
        children: [
          EasyRichText(
            chatMessage.message!,
            defaultStyle: BaseTextStyle(
              color: bubbleTextColor,
              fontSize: TypographyTheme.paragraph_p3,
              height: 1.5,
            ),
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
          if (chatMessage.timestamp != null)
            SizedOpacity(
              height: 16,
              width: chatMessage.edited ? 80 : 45,
              visible: chatMessage.timestamp != null && showTimestamp,
              child: Row(
                children: [
                  if (chatMessage.edited)
                    Text(
                      "(Edited)",
                      textAlign: TextAlign.end,
                      style: BaseTextStyle(
                        color: timestampTextColor,
                        fontSize: TypographyTheme.paragraph_p5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  Text(
                    chatMessage.timestamp!,
                    textAlign: TextAlign.end,
                    style: BaseTextStyle(
                      color: timestampTextColor,
                      fontSize: TypographyTheme.paragraph_p5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
