
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/chat_bubble.dart';

import '../../../../../core/services/websocket_service.dart';
mixin class ChatViewManager {
  List<ChatMessage> messages = [];
  final TextEditingController msgController = TextEditingController();

  listenMessageEvent(VoidCallback setState) {
    WebSocketManager.instance.webSocketReceiver("chat_update", (data) {
      final message = ChatMessage(message: data , chatId: "id") ;
      if(!messages.contains(message)){
        messages.add(message);
        setState();
      }

    });
  }

  sendMessage(String sender, VoidCallback setState , String message) {
    final ChatMessage data =
    ChatMessage(chatId: sender, message: message);
  //  WebSocketManager.instance.webSocketSender("chat_update", data.toJson());
    //Reset input
    msgController.text = "";
    setState();
  }

  Alignment setMessageAlignment(String senderName, String userName) {
    switch (senderName == userName) {
      case true:
        return Alignment.topRight;
      case false:
        return Alignment.topLeft;
    }
  }
}