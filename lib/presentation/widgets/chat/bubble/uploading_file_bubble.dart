import 'package:flutter/material.dart';
import '../chat_bubble.dart';
import 'file_bubble.dart';

class UploadingFileBubble extends StatelessWidget {
  final FileMessage fileMessage;
  final ChatMessage chatMessage;
  final BorderRadius borderRadius;
  final bool isMe;
  final bool visible;
  const UploadingFileBubble({
    super.key,
    required this.fileMessage,
    required this.chatMessage,
    required this.borderRadius,
    required this.isMe,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return FileChatBubble(
                fileMessage: fileMessage,
                chatMessage: chatMessage,
                borderRadius: borderRadius,
                isMe: isMe,
                visible: visible,
                uploading:true);

  }
}
