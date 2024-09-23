import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/data/models/onboarding/candidate_user_model.dart';
import 'package:highlite_flutter_mvp/data/models/onboarding/onboarding_data.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/profiled/profiled_chat_headline.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/typing_indicator.dart';
import '../../../core/resources/spacing_theme.dart';
import '../../../data/models/onboarding/country_city.dart';
import '../../../data/models/onboarding/file_model.dart';
import 'bubble_group.dart';
import 'chat_headline.dart';
import 'chat_responder.dart';
import 'location_responder.dart';

class ChatView extends StatefulWidget {
  final bool isChatHeadlineEnabled;
  final bool isProfiledChatHeadlineEnabled;
  final List<BubbleGroup> chatGroups;
  final ChatRespondent chatRespondent;
  final Function(List<String>) onSendMessage;
  final Function(List<FileModel>) onSendAttachments;
  final Function(File) sendFile;
  final Function() closeReply;
  final bool isIndicatorVisible;
  const ChatView({
    super.key,
    this.isChatHeadlineEnabled = true,
    this.isProfiledChatHeadlineEnabled = false,
    required this.chatGroups,
    required this.onSendMessage,
    required this.chatRespondent,
    this.isIndicatorVisible = false,
    required this.onSendAttachments,
    required this.sendFile,
    required this.closeReply,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  void _sendMessage(List<String> message) {
    widget.onSendMessage(message);
  }

  void _sendAttachments(List<FileModel> attachments) {
    widget.onSendAttachments(attachments);
  }

  void _sendFile(File file) {
    widget.sendFile(file);
  }

  @override
  Widget build(BuildContext context) {
    Widget chatScreen = ChatScreen(
      isChatHeadlineEnabled: widget.isChatHeadlineEnabled,
      isProfiledChatHeadlineEnabled: widget.isProfiledChatHeadlineEnabled,
      chatGroups: widget.chatGroups,
      showIndicator: widget.isIndicatorVisible,
    );
    return Container(
      decoration:  BoxDecoration(color: ColorConstant.chatSurface),
      child: Column(
        children: widget.chatRespondent.isLocationResponder == true
            ? [
                Expanded(
                  child: LocationResponder(
                    chatRespondent: widget.chatRespondent,
                    onPress: (CountryCity countryCity) {
                      _sendMessage([countryCity.city, countryCity.country]);
                    },
                  ),
                ),
              ]
            : [
                Expanded(child: chatScreen),
                if (!widget.isIndicatorVisible)
                  ChatResponder(
                    chatRespondent: widget.chatRespondent,
                    sendMessage: (message, tag) => _sendMessage(message),
                    sendAttachments: (attachments) =>
                        _sendAttachments(attachments),
                    sendFile: (file) => _sendFile(file),
                    closeReply: widget.closeReply,
                  ),
              ],
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.isChatHeadlineEnabled,
    required this.isProfiledChatHeadlineEnabled,
    required this.chatGroups,
    required this.showIndicator,
  });

  final bool isChatHeadlineEnabled;
  final bool isProfiledChatHeadlineEnabled;
  final List<BubbleGroup> chatGroups;
  final bool showIndicator;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        children: [
          if (isChatHeadlineEnabled) const ChatHeadline(),
        //  if (isProfiledChatHeadlineEnabled)
          //   BlocBuilder<>(
          //   builder: (context, state) => state.otherUser != null
          //       ? ProfiledChatHeadline(
          //     candidateUser: state.otherUser!,
          //     isSuperMessage: state.isSuperMessage,
          //     isSuperMessageFromMe:
          //     state.chatMessages.last.chatId == state.ownUser?.id,
          //   )
          //       : Container(),
          // ),

          Padding(
            padding: const EdgeInsets.all(Spacing.spacing_md),
            child: Column(
              children: [
                ...chatGroups,
                if (showIndicator)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: TypingIndicator(
                      showIndicator: showIndicator,
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
