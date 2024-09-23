import 'package:flutter/material.dart';

import '../../../core/resources/spacing_theme.dart';
import 'chatbox_bubble_group.dart';
import 'chatbox_message.dart';

class ChatboxBubblesView extends StatelessWidget {
  final List<ChatBubbleGroup> groups;
  final Widget header;
  final Function(String) onEmitReply;
  final Function(ChatboxMessage) onLongClick;
  final List<String> pinnedMessages;

  const ChatboxBubblesView({
    super.key,
    required this.groups,
    required this.header,
    required this.onEmitReply,
    required this.onLongClick,
    required this.pinnedMessages,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      padding: const EdgeInsets.all(Spacing.spacing_md),
      itemCount: groups.length + 1,
      itemBuilder: (context, index) => index < groups.length
          ? ChatboxBubbleGroup(
              pinnedMessages: pinnedMessages,
              group: groups[index],
              onEmitReply: onEmitReply,
              onLongClick: onLongClick,
            )
          : header,
    );
  }
}
