import 'dart:io';

import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/chat_responder.dart';

import '../../../../../data/models/onboarding/file_model.dart';
import '../../../../widgets/chatbox/chatbox_appbar.dart';
import '../../../../widgets/chatbox/chatbox_bubble_group.dart';
import '../../../../widgets/chatbox/chatbox_bubbles_view.dart';
import '../../../../widgets/chatbox/chatbox_contextual_menu.dart';
import '../../../../widgets/chatbox/chatbox_headline.dart';
import '../../../../widgets/chatbox/chatbox_message.dart';
import '../../../../widgets/chatbox/super_message/match_headline.dart';
import '../../../../widgets/chatbox/super_message/super_message_headline.dart';
import '../../../../widgets/paginater/paginate_responder.dart';

List<ChatBubbleGroup> groupByDirection(List<ChatboxMessage> messages) {
  List<ChatBubbleGroup> bubbleGroups = [];
  List<ChatboxMessage> messagesToGroup = [];
  if (messages.isNotEmpty) {
    int index = 0;
    BubbleDirection direction = messages.first.direction;
    do {
      if (messages[index].direction != direction) {
        bubbleGroups.add(ChatBubbleGroup(messages: messagesToGroup));
        messagesToGroup = [];
        direction = messages[index].direction;
        messagesToGroup.add(messages[index]);
      } else {
        messagesToGroup.add(messages[index]);
      }
      if (index == messages.length - 1) {
        bubbleGroups.add(ChatBubbleGroup(messages: messagesToGroup));
      }
      index++;
    } while (index < messages.length);
  }
  return bubbleGroups;
}

class ProfileDetails {
  final String profile;
  final String name;
  final String username;
  final String title;
  final String location;
  final bool online;

  const ProfileDetails({
    required this.profile,
    required this.name,
    required this.username,
    required this.title,
    required this.location,
    required this.online,
  });
}

class SuperMessageDetails {
  final bool sendingOwner;

  const SuperMessageDetails({
    required this.sendingOwner,
  });
}

class ChatboxView extends StatelessWidget {
  final List<ChatboxMessage> messages;
  final ProfileDetails details;
  final SuperMessageDetails? superMessageDetails;
  final bool isConsideredMatch;
  final Widget postBox;
  final Function(List<String>, String) onSendMessage;
  final Function(List<FileModel>) onSendMessageWithAttachments;
  final Function(File) onSendFile;
  final Function(String) onEmitReply;
  final Function(ChatboxMessage) onLongClick;
  final Function(String) onClickContextualMenu;
  final Function() onUnfocus;
  final VoidCallback onPaginate;
  final VoidCallback onCloseReply;
  final bool showHeaders;
  final bool showMessages;
  final ChatRespondent responder;
  final ChatboxMessage? focusedMessage;
  final VoidCallback onClickView;
  final List<String> pinnedMessages;
  final VoidCallback onInfo;

  const ChatboxView({
    super.key,
    required this.messages,
    required this.details,
    required this.postBox,
    this.superMessageDetails,
    this.isConsideredMatch = false,
    required this.onSendMessage,
    required this.onSendMessageWithAttachments,
    required this.onSendFile,
    required this.onPaginate,
    required this.onEmitReply,
    required this.onCloseReply,
    required this.onLongClick,
    required this.onClickContextualMenu,
    required this.onUnfocus,
    this.showHeaders = true,
    this.focusedMessage,
    required this.responder,
    this.showMessages = true,
    required this.onClickView,
    required this.pinnedMessages,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return ChatboxScreen(
      groups: showMessages ? groupByDirection(messages) : [],
      details: details,
      superMessageDetails: superMessageDetails,
      postBox: postBox,
      onSendMessage: onSendMessage,
      onSendMessageWithAttachments: onSendMessageWithAttachments,
      onSendFile: onSendFile,
      onCloseReply: onCloseReply,
      onEmitReply: onEmitReply,
      onLongClick: onLongClick,
      onClickContextualMenu: onClickContextualMenu,
      onPaginate: onPaginate,
      onUnfocus: onUnfocus,
      showHeaders: showHeaders,
      responder: responder,
      focusedMessage: focusedMessage,
      showMessages: showMessages,
      onClickView: onClickView,
      pinnedMessages: pinnedMessages,
      onInfo: onInfo,
    );
  }
}

class ChatboxScreen extends StatelessWidget {
  final List<ChatBubbleGroup> groups;
  final ProfileDetails details;
  final SuperMessageDetails? superMessageDetails;
  final bool isConsideredMatch;
  final Widget postBox;

  final Function(List<String>, String) onSendMessage;
  final Function(List<FileModel>) onSendMessageWithAttachments;
  final Function(File) onSendFile;
  final VoidCallback onCloseReply;
  final Function(String) onEmitReply;
  final Function(ChatboxMessage) onLongClick;
  final Function(String) onClickContextualMenu;
  final Function() onUnfocus;
  final VoidCallback onPaginate;
  final bool showHeaders;
  final ChatRespondent responder;
  final ChatboxMessage? focusedMessage;
  final bool showMessages;
  final VoidCallback onClickView;
  final VoidCallback onInfo;

  final List<String> pinnedMessages;

  const ChatboxScreen({
    super.key,
    required this.groups,
    required this.details,
    required this.postBox,
    this.superMessageDetails,
    this.isConsideredMatch = false,
    required this.onSendMessage,
    required this.onSendMessageWithAttachments,
    required this.onSendFile,
    required this.onPaginate,
    required this.onEmitReply,
    required this.onLongClick,
    required this.onCloseReply,
    required this.onClickContextualMenu,
    required this.onUnfocus,
    this.focusedMessage,
    this.showHeaders = true,
    required this.responder,
    this.showMessages = true,
    required this.onClickView,
    required this.pinnedMessages,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatboxAppbar(
        profile: details.profile,
        name: details.name,
        online: details.online,
        onTap: onUnfocus,
        onInfo: onInfo,
      ),
      bottomNavigationBar: focusedMessage != null
          ? ChatboxContextualMenu(
              chatboxMessage: focusedMessage!,
              onTap: onClickContextualMenu,
            )
          : null,
      body: GestureDetector(
        onTap: onUnfocus,
        child: Column(
          children: [
            Expanded(
              child: ChatboxBubblesView(
                onEmitReply: onEmitReply,
                onLongClick: onLongClick,
                pinnedMessages: pinnedMessages,
                header: !showHeaders
                    ? showMessages
                        ? PaginateResponder(
                            onPaginate: onPaginate,
                          )
                        : Container()
                    : Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: 20.0,
                        spacing: 20.0,
                        children: [
                          ChatboxHeadline(
                            profile: details.profile,
                            username: details.username,
                            name: details.name,
                            title: details.title,
                            location: details.location,
                            onClickView: onClickView,
                          ),
                          postBox,
                          if (superMessageDetails != null && !isConsideredMatch)
                            SuperMessageHeadline(
                              message: superMessageDetails!.sendingOwner
                                  ? "You sent a super message to ${details.name}"
                                  : "You got a super message from ${details.name}",
                            ),
                          if (isConsideredMatch)
                            const MatchHeadline(
                                message:
                                    "You can now send each other messages."),
                          Container(height: 40),
                        ],
                      ),
                groups: groups,
              ),
            ),
            if (focusedMessage == null)
              ChatResponder(
                chatRespondent: responder,
                sendMessage: onSendMessage,
                sendAttachments: onSendMessageWithAttachments,
                sendFile: onSendFile,
                closeReply: onCloseReply,
              ),
          ],
        ),
      ),
    );
  }
}
