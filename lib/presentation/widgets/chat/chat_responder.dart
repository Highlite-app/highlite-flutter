import 'dart:io';
import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/l10n/translation_key.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/buttons/checkbox_button.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/reply_heading.dart';

import '../../../data/models/onboarding/file_model.dart';
import '../buttons/button_selection_view.dart';
import '../buttons/selection_view.dart';
import '../buttons/tag_button.dart';
import 'chat_input.dart';


class MinMax<DataType> {
  MinMax(this.min, this.max);
  final DataType min;
  final DataType max;
}

enum InputType {
  normal,
  otp,
  currency;
}

class ChatRespondent {
  final String tag;
  final List<Selection>? options;
  final List<ButtonSelection>? buttonOptions;
  final bool capitalize;
  final bool searchable;
  final bool clearable;
  final bool enabledEmoji;
  final bool enabledAttachments;
  final bool input;
  final String initialValue;
  final bool forceVertical;
  final MinMax<int>? minMaxLines;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final InputType? inputType;
  final List<String>? tags;
  final List<String>? checkbox ;
  final String? checkBoxHintText ;
  final MinMax<int>? tagsSelection;
  final MinMax<int>? checkboxSelection ;
  final bool isLocationResponder;
  final ReplyContent? replyContent;

  const ChatRespondent({
    this.tag = "",
    this.options,
    this.buttonOptions,
    this.input = false,
    this.capitalize = false,
    this.searchable = false,
    this.clearable = false,
    this.forceVertical = false,
    this.enabledEmoji = false,
    this.enabledAttachments = false,
    this.initialValue = "",
    this.minMaxLines,
    this.tags,
    this.checkbox ,
    this.checkBoxHintText = '' ,
    this.focusNode,
    this.keyboardType,
    this.textCapitalization,
    this.inputType,
    this.tagsSelection,
    this.checkboxSelection,
    this.isLocationResponder = false,
    this.replyContent,
  });

  ChatRespondent copyWithReply({
    ReplyContent? replyContent,
  }) =>
      ChatRespondent(
        options: options,
        buttonOptions: buttonOptions,
        input: input,
        capitalize: capitalize,
        searchable: searchable,
        clearable: clearable,
        forceVertical: forceVertical,
        enabledEmoji: enabledEmoji,
        enabledAttachments: enabledAttachments,
        minMaxLines: minMaxLines,
        initialValue: initialValue,
        tags: tags,
        checkbox: checkbox,
        checkBoxHintText:  checkBoxHintText,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        inputType: inputType,
        tagsSelection: tagsSelection,
        checkboxSelection: checkboxSelection,
        replyContent: replyContent,
      );
}


class ChatResponder extends StatelessWidget {
  const ChatResponder({
    super.key,
    required this.chatRespondent,
    required this.sendMessage,
    required this.sendAttachments,
    required this.sendFile,
    required this.closeReply,
  });
  final ChatRespondent chatRespondent;
  final Function(List<String>, String) sendMessage;
  final Function(List<FileModel>) sendAttachments;
  final Function(File) sendFile;
  final Function() closeReply;
  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Column(
      children: [
        if (chatRespondent.replyContent != null)
          ReplyHeading(
            content: chatRespondent.replyContent!,
            onClose: closeReply,
          ),
        if (chatRespondent.tags != null)
          TagResponder(
            tags: chatRespondent.tags!,
            bottomPadding: bottomPadding,
            onSubmit: (selectedTags) {
              sendMessage(selectedTags, chatRespondent.tag);
            },
            tagsSelection: chatRespondent.tagsSelection!,
          ),
        if(chatRespondent.checkbox!=null)
          CheckBoxButton(checkbox: chatRespondent.checkbox!,
              hinText: chatRespondent.checkBoxHintText,
              maxSelection: chatRespondent.checkboxSelection!,
              onSubmit: (selectedChips){
                sendMessage(selectedChips , chatRespondent.tag);
              },

          ),

        if (chatRespondent.options != null)
          SelectionView(
            bottomPadding: chatRespondent.input == true ? 0 : bottomPadding,
            selections: chatRespondent.options!,
            onSelect: (selection) {
              sendMessage([selection], chatRespondent.tag);
            },
            capitalize: chatRespondent.capitalize,
            searchable: chatRespondent.searchable,
            forceVertical: chatRespondent.forceVertical,
          ),
        if (chatRespondent.buttonOptions != null)
          ButtonSelectionView(
            bottomPadding: chatRespondent.input == true ? 0 : bottomPadding,
            selections: chatRespondent.buttonOptions!,
            onSelect: (selection) {
              sendMessage([selection], chatRespondent.tag);
            },
          ),

        if (chatRespondent.input)
          Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: ChatInput(
              placeholderText: TranslationKeys.typeMessage,
              sendMessage: (message) {
                sendMessage([message], chatRespondent.tag);
              },
              initialValue: chatRespondent.initialValue,
              sendFile: sendFile,
              sendAttachments: sendAttachments,
              focusNode: chatRespondent.focusNode!,
              minMaxLines: chatRespondent.minMaxLines,
              keyboardType: chatRespondent.keyboardType ?? TextInputType.text,
              inputType: chatRespondent.inputType ?? InputType.normal,
              textCapitalization: chatRespondent.textCapitalization,
              searchEnabled: chatRespondent.searchable,
              clearEnabled: chatRespondent.clearable,
              enabledEmoji: chatRespondent.enabledEmoji,
              attachmentsEnabled: chatRespondent.enabledAttachments,
            ),
          ),
      ],
    );
  }
}
