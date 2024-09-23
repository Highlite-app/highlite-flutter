import 'package:flutter/material.dart';
import '../slidable/slidable_item.dart';
import '../text/centered_text.dart';
import 'conversation_item.dart';

class ConversationModel {
  final String id;
  final String profile;
  final bool superUser;
  final bool online;
  final bool seen;
  final bool favorite;
  final String title;
  final String message;
  final String timestamp;
  final ConversationState state;
  final List<SlidableActionItem> actionItems;

  const ConversationModel({
    required this.id,
    required this.profile,
    required this.superUser,
    required this.online,
    required this.seen,
    required this.favorite,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.state,
    required this.actionItems,
  });
}

class InboxConversationsList<T> extends StatelessWidget {
  final List<T> conversationsList;
  final ConversationModel Function(T) itemBuilder;
  final Function(T) onTap;
  final Function(T, String) onSliderTap;

  const InboxConversationsList({
    super.key,
    required this.conversationsList,
    required this.itemBuilder,
    required this.onTap,
    required this.onSliderTap,
  });

  @override
  Widget build(BuildContext context) {
    if (conversationsList.isEmpty) {
      return const CenteredTextLayout(
        text: "Your inbox is empty.\n Start a conversation to get started!",
      );
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = itemBuilder(conversationsList[index]);
        return Column(
          children: [
            ConversationItem(
              profile: item.profile,
              id: item.id,
              superUser: item.superUser,
              online: item.online,
              seen: item.seen,
              favorite: item.favorite,
              title: item.title,
              message: item.message,
              timestamp: item.timestamp,
              state: item.state,
              onTap: () => onTap(conversationsList[index]),
              onSliderTap: (key) => onSliderTap(conversationsList[index], key),
              actionItems: item.actionItems,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
      itemCount: conversationsList.length,
    );
  }
}
