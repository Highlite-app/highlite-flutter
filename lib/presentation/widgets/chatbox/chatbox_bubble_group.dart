import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';

import '../../../core/resources/spacing_theme.dart';
import 'chatbox_bubble.dart';
import 'chatbox_message.dart';

class ChatBubbleGroup {
  final List<ChatboxMessage> messages;

  const ChatBubbleGroup({required this.messages});
}

class ChatboxBubbleGroup extends StatelessWidget {
  final ChatBubbleGroup group;
  final Function(String) onEmitReply;
  final Function(ChatboxMessage) onLongClick;
  final List<String> pinnedMessages;

  const ChatboxBubbleGroup({
    super.key,
    required this.group,
    required this.onEmitReply,
    required this.onLongClick,
    required this.pinnedMessages,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...group.messages.reversed.mapIndexed(
          (bubble, index) {
            if (bubble.type == BubbleType.response) {
              return ChatboxBubble(
                pinned: false,
                onReply: () {
                  onEmitReply(bubble.chatId);
                },
                onLongClick: () {
                  onLongClick(bubble);
                },
                message: bubble,
              );
            }
            BubblePosition position = BubblePosition.middle;
            if (index == 0) {
              position = BubblePosition.start;
            } else if (index == group.messages.length - 1) {
              position = BubblePosition.end;
            } else {
              if (group.messages.length >= 2) {
                position = BubblePosition.middle;
              }
            }
            return Column(
              children: [
                ChatboxBubble(
                  pinned: pinnedMessages.contains(bubble.chatId),
                  onReply: () {
                    onEmitReply(bubble.chatId);
                  },
                  onLongClick: () {
                    onLongClick(bubble);
                  },
                  message: bubble.copyWith(
                    position: position,
                  ),
                ),
                const SizedBox(height: Spacing.spacing_xx_sm),
              ],
            );
          },
        ).toList(),
        const SizedBox(height: Spacing.spacing_md),
      ],
    );
  }
}
