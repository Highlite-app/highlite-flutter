import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chatbox/chatbox_message.dart';

import '../../../../core/resources/color_constants.dart';
import '../../../../core/resources/typography_theme.dart';
import '../../animated/sized_opacity.dart';
import '../../constants/text_style.dart';
import '../chatbox_bubble.dart';

class ChatboxTextBubble extends StatelessWidget {
  final String message;
  final BubbleDirection direction;
  final BubblePosition position;
  final bool pinned;

  const ChatboxTextBubble({
    super.key,
    required this.message,
    required this.direction,
    required this.position,
    this.pinned = false,
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

  Color get color {
    var bubbleColor = ColorConstant.neutral100;
    if (direction == BubbleDirection.right) {
      bubbleColor = ColorConstant.primary500;
    }
    return bubbleColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: direction == BubbleDirection.left
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            direction == BubbleDirection.right && pinned
                ? const Pin(spacingInLeft: false)
                : Container(),
            Stack(
              clipBehavior: Clip.none,
              alignment: direction == BubbleDirection.left
                  ? AlignmentDirectional.bottomStart
                  : AlignmentDirectional.bottomEnd,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: radius,
                  ),
                  constraints: const BoxConstraints(maxWidth: 250),
                  padding: const EdgeInsets.only(
                    top: 6,
                    bottom: 8,
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: direction == BubbleDirection.left
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      TextBubble(
                        message: message,
                        direction: direction,
                        showTimestamp: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            direction == BubbleDirection.left && pinned
                ? const Pin(spacingInLeft: true)
                : Container(),
          ],
        ),
      ],
    );
  }
}

class TextBubble extends StatelessWidget {
  final String message;
  final bool edited;
  final bool showTimestamp;
  final String? timestamp;
  final BubbleDirection direction;

  const TextBubble({
    super.key,
    required this.message,
    required this.direction,
    this.timestamp,
    this.showTimestamp = false,
    this.edited = false,
  });

  @override
  Widget build(BuildContext context) {
    var bubbleTextColor = ColorConstant.shade100;
    var timestampTextColor = ColorConstant.neutral700;
    if (direction == BubbleDirection.right) {
      bubbleTextColor = ColorConstant.shade00;
      timestampTextColor = ColorConstant.primary100;
    }
    return Column(
      crossAxisAlignment: direction == BubbleDirection.left
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        EasyRichText(
          message,
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
        if (timestamp != null)
          SizedOpacity(
            height: 16,
            width: edited ? 80 : 45,
            visible: showTimestamp,
            child: Row(
              children: [
                if (edited)
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
                  timestamp!,
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
    );
  }
}
