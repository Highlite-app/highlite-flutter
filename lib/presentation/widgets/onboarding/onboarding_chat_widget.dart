import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/appBar/onboarding_appbar.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/dialogs/reset_dialog.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/utils/iterable.dart';
import '../chat/bubble_group.dart';
import '../chat/chat_bubble.dart';
import '../chat/chat_responder.dart';
import '../chat/chat_screen.dart';
import '../drawer/onboarding_drawer.dart';

class OnboardingChatWidget extends StatefulWidget {
  final List<ChatMessage> messages;
  final ChatRespondent chatRespondent;
  final bool showIndicator;
  final bool isLogin;
  final VoidCallback onLoadChat;
  final Function(List<String> message) onSendMessage;
  final Function(ChatMessage, int) onEdit;
  final bool enabledRefresh;
  const OnboardingChatWidget({
    super.key,
    required this.messages,
    required this.chatRespondent,
    required this.showIndicator,
    required this.isLogin,
    required this.onLoadChat,
    required this.onSendMessage,
    required this.onEdit,
    required this.enabledRefresh,
  });

  @override
  State<OnboardingChatWidget> createState() => _OnboardingChatWidgetState();
}

class _OnboardingChatWidgetState extends State<OnboardingChatWidget> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onLoadChat();
    });
  }

  List<BubbleGroup> _chatGroups(List<ChatBubble> messages) {
    List<BubbleGroup> list = [];
    if (messages.isNotEmpty) {
      String chatId = messages.first.chatMessage.chatId;
      List<ChatBubble> bubbles = [];
      int index = 0;
      messages.asMap().forEach(
        (ind, bubble) {
          if (chatId != bubble.chatMessage.chatId) {
            bubbles[bubbles.length - 1].isWithAvatar =
                !bubbles[bubbles.length - 1].isMe;
            list.add(
                BubbleGroup(chatBubbles: bubbles, key: ValueKey("$index")));
            bubbles = [];
            index++;
            chatId = bubble.chatMessage.chatId;
          }
          ChatBubble bubbleToAdd = bubble;
          bubbleToAdd.key = ValueKey("$ind");
          bubbleToAdd.isMe = bubble.chatMessage.chatId != 'bot';
          bubbleToAdd.applySpacing = !bubble.isMe;
          bubbleToAdd.showAvatar = !bubble.isMe;
          bubbles.add(bubbleToAdd);
          if (ind == messages.length - 1) {
            bubbles[bubbles.length - 1].isWithAvatar =
                !bubbles[bubbles.length - 1].isMe;
            list.add(
                BubbleGroup(chatBubbles: bubbles, key: ValueKey("$index")));
            bubbles = [];
            index++;
            chatId = bubble.chatMessage.chatId;
          }
        },
      );
    }
    return list;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OnBoardingAppBar(
        onClickReset: () {
          ResetDialog.showResetDialog(context: context , onLoadChat: widget.onLoadChat);
        },
        messages: widget.messages,
        enabledRefreshButton: widget.enabledRefresh,
      ),
      drawer: OnboardingDrawer(
        //scaffoldState: _scaffoldState,
        reset: () {
           ResetDialog.showResetDialog(context: context , onLoadChat: widget.onLoadChat);
        },
        isLogin: widget.isLogin,
      ),
      body: ChatView(
        chatGroups: _chatGroups(
          widget.messages
              .mapIndexed(
                (e, index) => ChatBubble(
                  chatMessage: e,
                  onEdit:() {
                    debugPrint("OnTap Edit");
                    widget.onEdit(e, index);
                  },
                  onReply: (chatMessage) {},
                  onLongClickMessage: (chatMessage) {},
                  allowActionEvents: false,
                ),
              )
              .toList(),
        ),
        closeReply: () {},
        onSendMessage: widget.onSendMessage,
        onSendAttachments: (attachments) {},
        sendFile: (file) {},
        chatRespondent: widget.chatRespondent,
        isIndicatorVisible: widget.showIndicator,
      ),
    );
  }

}
