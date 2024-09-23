import 'dart:io';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../core/resources/asset_constants.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/resources/spacing_theme.dart';
import '../../../core/resources/typography_theme.dart';
import '../../../data/models/onboarding/file_model.dart';
import '../card/card_container.dart';
import '../constants/text_style.dart';
import '../grid/circular_svg_texttile.dart';
import '../keyboard/emoji_keyboard.dart';
import '../layout/wrap_stack.dart';
import '../svg/padded_svg.dart';
import '../svg/svg_asset.dart';
import '../utils/keyboard.dart';
import 'chat_responder.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({
    super.key,
    required this.placeholderText,
    required this.sendMessage,
    this.onChange,
    required this.focusNode,
    this.minMaxLines,
    required this.keyboardType,
    this.textCapitalization,
    required this.inputType,
    required this.initialValue,
    this.sendButtonEnabled = true,
    this.searchEnabled = false,
    this.clearEnabled = false,
    this.attachmentsEnabled = false,
    this.enabledEmoji = false,
    required this.sendAttachments,
    required this.sendFile,
  });

  final String placeholderText;
  final Function? sendMessage;
  final Function? onChange;
  final FocusNode focusNode;
  final MinMax<int>? minMaxLines;
  final TextInputType keyboardType;
  final TextCapitalization? textCapitalization;
  final InputType inputType;
  final bool sendButtonEnabled;
  final bool searchEnabled;
  final bool clearEnabled;
  final bool enabledEmoji;
  final bool attachmentsEnabled;
  final String initialValue;
  final Function(List<FileModel>) sendAttachments;
  final Function(File) sendFile;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {

  final currencyFormatter = CurrencyTextInputFormatter.currency(
      locale: 'en', decimalDigits: 2, symbol: '\$', enableNegative: false);

  String inputText = "";
  final myController = TextEditingController();
  bool showEmojis = false;
  bool showAttachmentOptions = false;
  @override
  void initState() {
    super.initState();
    myController.addListener(() {
      setState(() {
        inputText = myController.text;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      myController.text = widget.initialValue;
      inputText = widget.initialValue;
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> textFormatter = [];
    if (widget.inputType == InputType.normal &&
        widget.keyboardType == TextInputType.phone) {
      textFormatter = [MaskTextInputFormatter(mask: '###-###-####')];
    }
    if (widget.inputType == InputType.otp) {
      textFormatter = [MaskTextInputFormatter(mask: '#-#-#-#-#-#')];
    }
    if (widget.inputType == InputType.currency) {
      textFormatter = [currencyFormatter];
    }
    return KeyboardVisibilityProvider(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Wrap(
          children: [
            if (showAttachmentOptions)
              FloatingCard(
                height: 130,
                animated: true,
                child: WrappedStack(
                  alignment: MainAxisAlignment.center,
                  direction: Axis.horizontal,
                  spacing: 10,
                  widgets: [
                    CircularSvgTextTile(
                      asset: AssetConstant.fileIcon,
                      title: "Document",
                      dark: true,
                      onTap: () async {
                        // final file = await fileManager.pickFile();
                        // if (file != null) {
                        //   widget.sendFile(file);
                        // }
                        setState(() {
                          showAttachmentOptions = false;
                        });
                      },
                    ),
                    CircularSvgTextTile(
                      asset: "camera-01",
                      title: "Camera",
                      dark: true,
                      onTap: () async {
                      //   final model = await fileManager
                      //       .getPhotoWithModel(ImageSource.camera);
                      //   if (model != null) {
                      //     widget.sendAttachments([model]);
                      //   }
                      //   setState(() {
                      //     showAttachmentOptions = false;
                      //   });
                      },
                    ),
                    CircularSvgTextTile(
                      asset: "image-04",
                      title: "Gallery",
                      dark: true,
                      onTap: () async {
                        // widget.sendAttachments(await fileManager
                        //     .selectMultiplePhotos(ImageSource.camera));
                        // setState(() {
                        //   showAttachmentOptions = false;
                        // });
                      },
                    ),
                    // CircularSvgTextTile(
                    //   asset: "video-recorder",
                    //   title: "Video",
                    //   dark: true,
                    //   onTap: () async {
                    //     // final model = await fileManager
                    //     //     .pickVideoWithModel(ImageSource.gallery);
                    //     // if (model != null) {
                    //     //   widget.sendAttachments([model]);
                    //     // }
                    //     setState(() {
                    //       showAttachmentOptions = false;
                    //     });
                    //   },
                    // ),
                  ],
                ),
              ),
            Column(
              children: [
                _textField(textFormatter),
                if (showEmojis && widget.enabledEmoji)
                  KeyboardVisibilityBuilder(
                    builder: (context, isKeyboardVisible) =>
                        (!isKeyboardVisible)
                            ? EmojiKeyboard(controller: myController)
                            : Container(),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding _textField(List<TextInputFormatter> textFormatter) {
    Widget? suffixIcon;
    if (widget.clearEnabled) {
      suffixIcon = ChatInputIcon(
        onPressed: () {
          if (widget.clearEnabled) {
            widget.focusNode.unfocus();
            myController.text = "";
            widget.onChange!("");
          }
        },
        asset: "x-circle",
      );
    }
    if (widget.attachmentsEnabled) {
      suffixIcon = ChatInputIcon(
        onPressed: () {
          setState(() {
            showAttachmentOptions = !showAttachmentOptions;
          });
        },
        asset: "attachment-01",
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              maxLines: widget.minMaxLines?.max ?? 1,
              minLines: widget.minMaxLines?.min ?? 1,
              textInputAction: TextInputAction.done,
              keyboardType: widget.keyboardType == TextInputType.name
                  ? TextInputType.text
                  : widget.keyboardType,
              textCapitalization: widget.textCapitalization != null
                  ? widget.textCapitalization!
                  : widget.keyboardType == TextInputType.name
                      ? TextCapitalization.words
                      : TextCapitalization.none,
              inputFormatters: textFormatter,
              onFieldSubmitted: (value) {
                if (widget.sendMessage != null && inputText != "") {
                  widget.sendMessage!(value);
                  myController.text = "";
                }
              },
              controller: myController,
              onChanged: (value) {
                setState(() {
                  inputText = value;
                  if (widget.onChange != null) {
                    widget.onChange!(value);
                  }
                });
              },
              showCursor: true,
              focusNode: widget.focusNode,
              style:  BaseTextStyle(
                fontSize: TypographyTheme.paragraph_p3,
                color: ColorConstant.neutral900,
                fontWeight: FontWeight.w400,
              ),
              decoration: ChatInputDecoration.createChatInput(
                prefixIcon: ChatInputIcon(
                  onPressed: widget.enabledEmoji
                      ? () {
                          setState(() {
                            showAttachmentOptions = false;
                            showEmojis = !showEmojis;
                            Keyboard.invoke(!showEmojis);
                          });
                        }
                      : null,
                  asset: widget.searchEnabled ?AssetConstant.searchIcon : AssetConstant.faceHappyIcon,
                ),
                suffixIcon: suffixIcon ??
                    Container(
                      width: 0,
                    ),
                placeholder: widget.placeholderText,
              ),
            ),
          ),
          if (widget.sendButtonEnabled)
            ChatInputSend(
              inputText: inputText,
              onPressed: () {
                if (widget.sendMessage != null && inputText != "") {
                  if (widget.inputType == InputType.currency) {
                    final message = currencyFormatter.getUnformattedValue();
                    widget.sendMessage!(message.toString());
                  } else {
                    widget.sendMessage!(inputText);
                  }
                  myController.text = "";
                }
              },
            ),
        ],
      ),
    );
  }
}

class ChatInputDecoration {
  static InputDecoration createChatInput(
      {required Widget suffixIcon,
      required Widget prefixIcon,
      required String placeholder}) {
    return InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: placeholder,
      hintStyle:  BaseTextStyle(
        fontSize: TypographyTheme.paragraph_p3,
        color: ColorConstant.neutral500,
      ),
      filled: true,
      fillColor: ColorConstant.light2,
      contentPadding:  const EdgeInsets.symmetric(
          horizontal: Spacing.spacing_x_sm, vertical: 12.0),
      enabledBorder: OutlineInputBorder(
        borderSide:  BorderSide(width: 0, color: ColorConstant.light2),
        borderRadius: BorderRadius.circular(50.0),
      ),
      border: OutlineInputBorder(
        borderSide:  BorderSide(width: 0, color: ColorConstant.light2),
        borderRadius: BorderRadius.circular(50.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:  BorderSide(width: 0, color: ColorConstant.light2),
        borderRadius: BorderRadius.circular(50.0),
      ),
    );
  }
}

class ChatInputSend extends StatelessWidget {
  final String inputText;
  final VoidCallback onPressed;
  const ChatInputSend({
    super.key,
    required this.inputText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Spacing.spacing_x_sm),
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color:
              inputText == "" ? ColorConstant.primary400 : ColorConstant.primary500,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: inputText == "" ? null : onPressed,
          icon:  const PaddedSvg(
            padding:EdgeInsets.only(left: 6.5, right: 3.5),
            asset: AssetConstant.sendIcon,
            size: 30,
            color: ColorConstant.shade00,
          ),
        ),
      ),
    );
  }
}

class ChatInputIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final String asset;
  const ChatInputIcon({
    super.key,
    this.onPressed,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: IconButton(
        splashColor: ColorConstant.neutral100,
        onPressed: onPressed,
        alignment: Alignment.center,
        icon: SvgAsset(
          asset: asset,
          width: 24,
          height: 24,
          color: ColorConstant.neutral600,
        ),
      ),
    );
  }
}
