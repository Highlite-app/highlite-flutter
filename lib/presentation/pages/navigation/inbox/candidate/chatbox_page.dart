import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:highlite_flutter_mvp/presentation/pages/navigation/inbox/candidate/chatbox_screen.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/chat_responder.dart';

import '../../../../../core/services/websocket_service.dart';
import '../../../../widgets/chatbox/chatbox_message.dart';

/*class ChatboxPage extends StatelessWidget {
  final HighliteMessageChannel channel;
  const ChatboxPage({
    super.key,
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    return ChannelBoxProviderWidget(
      channel: channel,
      child: const ChatboxPageStater(),
    );
  }
}

class ChatboxPageStater extends StatefulWidget {
  const ChatboxPageStater({super.key});

  @override
  State<ChatboxPageStater> createState() => _ChatboxPageStaterState();
}

class _ChatboxPageStaterState extends State<ChatboxPageStater> {
  ChatboxMessage? focusedMessage;
  @override
  Widget build(BuildContext context) {
    return ChannelBoxBuilderWidget(
      builder: (context, state) {
        final postBox = state.showPostAsCandidate
            ? (state.candidate != null)
                ? CandidateBox(candidate: state.candidate!)
                : Container()
            : (state.jobFeed != null)
                ? JobPostBox(post: state.jobFeed!)
                : Container();
        return ChatboxView(
          showMessages: state.showMessages,
          details: state.details,
          focusedMessage: focusedMessage,
          superMessageDetails:
              state.showMessages ? state.superMessageDetails : null,
          isConsideredMatch: state.isConsideredMatch,
          onClickView: () => _onClickView(state),
          postBox: postBox,
          messages: state.messages,
          pinnedMessages: state.channel?.pinMessageId ?? [],
          showHeaders: state.nextToken == null,
          onSendMessage: (messages, tag) {
            context
                .read<ChannelBoxBloc>()
                .add(SendMessageToChatboxEvent(messages, tag));
          },
          responder: state.responder,
          onSendFile: (file) {
            context.read<ChannelBoxBloc>().add(
                  SendFileToChatboxEvent(file, MessageTypes.file),
                );
          },
          onEmitReply: (id) {
            context.read<ChannelBoxBloc>().add(TransitReplyEvent(id));
          },
          onSendMessageWithAttachments: (attachments) {
            if (attachments.isNotEmpty) {
              context.read<ChannelBoxBloc>().add(
                    SendMessageWithAttachmentsToChatboxEvent(
                        attachments, MessageTypes.attachments),
                  );
            }
          },
          onCloseReply: () {
            context.read<ChannelBoxBloc>().add(const CloseReplyEvent());
          },
          onPaginate: () {
            context.read<ChannelBoxBloc>().add(const PaginateMessagesEvent());
          },
          onLongClick: (message) {
            setState(() {
              focusedMessage = message;
            });
          },
          onClickContextualMenu: (text) {
            if (focusedMessage != null) {
              if (text == currentLocalizations.edit) {
                context
                    .read<ChannelBoxBloc>()
                    .add(EditMessageEvent(focusedMessage!));
              } else if (text == currentLocalizations.copy &&
                  focusedMessage!.textable()) {
                focusedMessage!.message.copyToClipboard();
              } else if (text == currentLocalizations.reply) {
                context
                    .read<ChannelBoxBloc>()
                    .add(TransitReplyEvent(focusedMessage!.chatId));
              } else if (text == currentLocalizations.pin) {
                context
                    .read<ChannelBoxBloc>()
                    .add(PinMessageEvent(focusedMessage!));
              } else if (text == currentLocalizations.unsend) {
                context
                    .read<ChannelBoxBloc>()
                    .add(UnsendMessageEvent(focusedMessage!));
              }
              setState(() {
                focusedMessage = null;
              });
            }
          },
          onUnfocus: () {
            setState(() {
              focusedMessage = null;
            });
          },
          onInfo: () {
            globalNavKey.currentState!.push(
              MaterialPageRoute(
                builder: (_) => ChatboxInfoPage(
                  details: state.details,
                  onClickView: () => _onClickView(state),
                  postBox: postBox,
                  channel: state.channel!,
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _onClickView(
    ChannelBoxState state,
  ) {
    if (state.candidateChatbox) {
      globalNavKey.currentContext!.push(
        CompanyProfile.previewRoute,
        extra: state.channel!.companyUsers.items.first,
      );
    } else {
      globalNavKey.currentContext!.push(
        CandidateProfile.previewRoute,
        extra: state.channel!.candidateUsers.items.first.asCandidate(),
      );
    }
  }
}*/

class ChatBoxPage extends StatefulWidget {
  const ChatBoxPage({super.key});

  @override
  State<ChatBoxPage> createState() => _ChatBoxPageState();
}

class _ChatBoxPageState extends State<ChatBoxPage> {
  @override
  Widget build(BuildContext context) {
    return const ChatBoxPageStartedUI();
  }
}

class ChatBoxPageStartedUI extends StatefulWidget {
  const ChatBoxPageStartedUI({super.key});

  @override
  State<ChatBoxPageStartedUI> createState() => _ChatBoxPageStartedUIState();
}

class _ChatBoxPageStartedUIState extends State<ChatBoxPageStartedUI> {

   FocusNode? focusNode ;
  ChatboxMessage message1 =
      const ChatboxMessage(tag: '', chatId: '', message: "Hi");
  ChatboxMessage message2 =
      const ChatboxMessage(tag: '', chatId: '', message: 'Hello !');
  ChatboxMessage message3 =
      ChatboxMessage(tag: '', chatId: '', message: 'Hey there !');

  late List<ChatboxMessage> chatMessage;

  late ProfileDetails profileDetails;


  



  @override
  void initState() {
    focusNode = FocusNode();
    WebSocketManager.instance.initializeSocketConnection();

    //Listen chat channel
    // listenMessageEvent(() {
    //   setState(() {});
    // });
    chatMessage = [message1, message2, message3];

    profileDetails = const ProfileDetails(
        profile: "https://w7.pngwing.com/pngs/481/1016/png-transparent-shell-logo-royal-dutch-shell-logo-company-business-shell-miscellaneous-company-service-thumbnail.png",
        name: "Srijan",
        username: "Sreejan@2306",
        title: "Senior Flutter Developer",
        location: "India",
        online: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChatboxView(
        showHeaders:  true,
        messages: chatMessage,
        details: profileDetails,
        postBox: Container(),
        onSendMessage: (message, tag) {

        },
        onSendMessageWithAttachments: (attachment) {},
        onSendFile: (file) {},
        onPaginate: () {},
        onEmitReply: (emit) {},
        onCloseReply: () {},
        onLongClick: (message) {},
        onClickContextualMenu: (string) {},
        onUnfocus: () {},
        responder:  ChatRespondent(input: true ,focusNode:focusNode , inputType: InputType.normal),
        onClickView: () {},
        pinnedMessages: (["a"]),
        onInfo: () {});
  }
}
