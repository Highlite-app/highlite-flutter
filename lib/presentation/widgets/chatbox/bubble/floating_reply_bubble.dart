import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/color_constants.dart';
import '../../../../core/resources/typography_theme.dart';
import '../../constants/text_style.dart';
import '../../layout/measure_size.dart';
import '../../text/iconized_text.dart';
import '../chatbox_message.dart';
import 'chatbox_file_bubble.dart';

class FloatingReplyBubble extends StatelessWidget {
  final BubbleDirection direction;
  final double bubbleSize;
  final double replyBubbleSize;
  final Function(double) repliedBubbleSize;
  final ChatboxMessage message;

  const FloatingReplyBubble(
      {super.key,
      required this.direction,
      required this.bubbleSize,
      required this.repliedBubbleSize,
      required this.replyBubbleSize,
      required this.message});

  @override
  Widget build(BuildContext context) {
    if (direction == BubbleDirection.right) {
      return Positioned(
        top: message.repliedMessage!.fileboxMessage != null
            ? ((bubbleSize) * -1) + 10
            : ((bubbleSize) * -1) + replyBubbleSize,
        right: -5,
        child: MeasureSize(
          onChange: (size) {
            repliedBubbleSize(size.height);
          },
          child: ReplyChatBubble(
            repliedMessage: message.repliedMessage!,
            direction: message.direction,
            position: message.position,
          ),
        ),
      );
    } else {
      return Positioned(
        top: message.repliedMessage!.fileboxMessage != null
            ? ((bubbleSize) * -1) + 10
            : ((bubbleSize) * -1) + replyBubbleSize,
        left: 3,
        child: MeasureSize(
          onChange: (size) {
            repliedBubbleSize(size.height);
          },
          child: ReplyChatBubble(
            repliedMessage: message.repliedMessage!,
            direction: message.direction,
            position: message.position,
          ),
        ),
      );
    }
  }
}

class ReplyChatBubble extends StatelessWidget {
  final BubbleDirection direction;
  final BubblePosition position;
  final RepliedMessage repliedMessage;

  const ReplyChatBubble({
    super.key,
    required this.repliedMessage,
    required this.direction,
    required this.position,
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
    final iconized = IconizedText(
      icon: "share-06",
      iconColor: ColorConstant.neutral600,
      iconSize: 16,
      text: repliedMessage.repliedTo,
      textColor: ColorConstant.neutral600,
      textSize: TypographyTheme.paragraph_p4,
      fontWeight: FontWeight.w500,
    );
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (direction == BubbleDirection.right)
          Positioned(top: -25, right: 3, child: iconized),
        if (direction == BubbleDirection.left)
          Positioned(top: -25, left: 0, child: iconized),
        Container(
          decoration: BoxDecoration(
            color: ColorConstant.neutral50,
            borderRadius: radius,
          ),
          constraints: BoxConstraints(
              maxWidth: repliedMessage.fileboxMessage != null ? 300 : 250),
          padding:
              const EdgeInsets.only(top: 6, bottom: 8, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: direction == BubbleDirection.right
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              ReplyBubble(
                repliedMessage: repliedMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReplyBubble extends StatelessWidget {
  final RepliedMessage repliedMessage;

  const ReplyBubble({super.key, required this.repliedMessage});

  @override
  Widget build(BuildContext context) {
    var bubbleTextColor = ColorConstant.neutral600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (repliedMessage.message != null)
          EasyRichText(
            repliedMessage.message!,
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
        if (repliedMessage.fileboxMessage != null)
          FileMessageContents(
            fileName: repliedMessage.fileboxMessage!.fileName,
            fileBytes: repliedMessage.fileboxMessage!.fileBytes,
            titleColor: bubbleTextColor,
            subtitleColor: bubbleTextColor,
          ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
