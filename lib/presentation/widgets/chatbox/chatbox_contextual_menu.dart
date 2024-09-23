import 'package:flutter/material.dart';


import '../../../core/resources/asset_constants.dart';
import '../../../core/resources/l10n/translation_key.dart';
import '../contextual_menu/contextual_menu.dart';
import 'chatbox_message.dart';

class ChatboxContextualMenu extends StatelessWidget {
  final ChatboxMessage chatboxMessage;
  final Function(String) onTap;
  const ChatboxContextualMenu({
    super.key,
    required this.chatboxMessage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ContextualMenuWidget(
      options: [
        if (chatboxMessage.textable() &&
            chatboxMessage.direction == BubbleDirection.right)
          const ContextualMenuOption(
              icon: AssetConstant.editSelectedIcon, text: TranslationKeys.edit, bordered: true),
        const ContextualMenuOption(
          icon: AssetConstant.shareIcon,
          text: TranslationKeys.reply,
        ),
        const ContextualMenuOption(
          icon: AssetConstant.pinIcon,
          text: TranslationKeys.pin,
        ),
        if (chatboxMessage.textable())
          const ContextualMenuOption(
            icon: AssetConstant.copyIcon,
            text: TranslationKeys.copy,
          ),
        if (chatboxMessage.direction == BubbleDirection.right)
          const ContextualMenuOption(
              icon: AssetConstant.refreshIcon5, text: TranslationKeys.unSend),
        // NOTE FOR Submenu
        // const ContextualMenuOption(
        //   icon: "dots-horizontal",
        //   text: TranslationKeys.more,
        //   submenu: [
        //     // For MVP2
        //     // const ContextualMenuOption(
        //     //     icon: "send-01", text: TranslationKeys.forward),
        //   ],
        // )
      ],
      onTap: onTap,
    );
  }
}
