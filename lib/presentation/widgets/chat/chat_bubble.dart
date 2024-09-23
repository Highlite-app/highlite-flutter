// ignore_for_file: use_key_in_widget_constructors, overridden_fields

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/core/resources/asset_constants.dart';
import 'package:highlite_flutter_mvp/core/resources/color_constants.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chat/reply_heading.dart';

import '../../../data/models/onboarding/file_model.dart';
import '../buttons/tiny_button.dart';
import '../chatbox/bubble/response_bubble.dart';
import '../gallery/preview_gallery.dart';
import '../profile/profile_picture.dart';
import '../svg/svg_asset.dart';
import 'bubble/file_bubble.dart';
import 'bubble/image_bubble.dart';
import 'bubble/reply_bubble.dart';
import 'bubble/text_bubble.dart';
import 'bubble/uploading_file_bubble.dart';
import 'bubble/video_bubble.dart';

enum BubblePosition { start, middle, end }

enum BubbleStatus { normal, success, error, undeterminedError, warningError }

class FileMessage {
  final String fileName;
  final String? fileUrl;
  final File? file;
  final String bytes;
  const FileMessage(
      {required this.fileName, this.fileUrl, this.file, required this.bytes});
}

class ChatMessage {
  final String? tag;
  final String? message;
  final String chatId;
  final String? messageId;
  final String? attachmentString;
  final ImageProvider? image;
  final File? videoPreview;
  final List<PreviewModel>? previews;
  final List<FileModel>? uploadingPreviews;
  final bool isPreviewVideos;
  final String? timestamp;
  final bool edited;
  bool editable;
  bool shareEnabled;
  final BubbleStatus status;
  final FileMessage? file;
  final FileMessage? uploadingFile;
  final ReplyContent? repliedContent;
  final ResponseContent? responseContent;
  ChatMessage({
    this.tag,
    this.message,
    required this.chatId,
    this.messageId,
    this.attachmentString,
    this.image,
    this.videoPreview,
    this.editable = false,
    this.status = BubbleStatus.normal,
    this.isPreviewVideos = false,
    this.shareEnabled = false,
    this.timestamp,
    this.edited = false,
    this.previews,
    this.uploadingPreviews,
    this.uploadingFile,
    this.file,
    this.repliedContent,
    this.responseContent,
  });
  textable() => message != null && message != "";

  ReplyContent toReplyContent(String name) {
    final previewsList = previews?.map((preview) => preview.url).toList();
    List<String>? photosList;
    List<String>? videosList;
    if (previewsList != null && previews != null) {
      if (previewsList.isNotEmpty) {
        if (!previews!.first.isVideoPreview) {
          photosList = previewsList;
        } else {
          videosList = previewsList;
        }
      }
    }
    return ReplyContent(
      message: message,
      replyTo: name,
      messageId: messageId ?? "",
      photos: photosList,
      previews: videosList,
      fileMessage: null,
    );
  }
}

// ignore: must_be_immutable
class ChatBubble extends StatefulWidget {
  bool isMe;
  @override
  Key? key;
  ChatMessage chatMessage;
  BubblePosition position;
  BubbleStatus status;
  bool showAvatar;
  bool isWithAvatar;
  bool isPinned;
  bool applySpacing;
  bool isAssistantAvatar;
  bool allowActionEvents;
  Function() onEdit;
  final Function(ChatMessage) onLongClickMessage;
  final Function(ChatMessage) onReply;
  ChatBubble({
    this.key,
    required this.chatMessage,
    this.isMe = false,
    this.position = BubblePosition.start,
    this.showAvatar = false,
    this.isWithAvatar = false,
    this.applySpacing = false,
    this.isAssistantAvatar = true,
    this.isPinned = false,
    this.allowActionEvents = true,
    this.status = BubbleStatus.normal,
    required this.onEdit,
    required this.onLongClickMessage,
    required this.onReply,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble>
    with SingleTickerProviderStateMixin {
  bool _visible = true;
  double replySize = 0;
  bool _showTimestamp = false;
  double bubbleHeight = 0;

  late AnimationController animationController;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
    if (!_visible) {
      Future.delayed(const Duration(milliseconds: 300)).then(
        (_) => setState(() {
          _visible = true;
        }),
      );
    }
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const cornerActive = 16.00;
    const cornerInactive = 4.00;
    BorderRadius borderRadius;
    if (widget.position == BubblePosition.start) {
      borderRadius = BorderRadius.only(
        topLeft: const Radius.circular(cornerActive),
        topRight: const Radius.circular(cornerActive),
        bottomLeft:
            Radius.circular(!widget.isMe ? cornerInactive : cornerActive),
        bottomRight:
            Radius.circular(!widget.isMe ? cornerActive : cornerInactive),
      );
    } else if (widget.position == BubblePosition.middle) {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(!widget.isMe ? cornerInactive : cornerActive),
        topRight: Radius.circular(!widget.isMe ? cornerActive : cornerInactive),
        bottomLeft:
            Radius.circular(!widget.isMe ? cornerInactive : cornerActive),
        bottomRight:
            Radius.circular(!widget.isMe ? cornerActive : cornerInactive),
      );
    } else {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(!widget.isMe ? cornerInactive : cornerActive),
        bottomLeft: const Radius.circular(cornerActive),
        topRight: Radius.circular(!widget.isMe ? cornerActive : cornerInactive),
        bottomRight: const Radius.circular(cornerActive),
      );
    }

    // Bubble Status
    var bubbleColor = ColorConstant.neutral100;
    if (widget.isMe) {
      bubbleColor = ColorConstant.primary500;
    }
    if (widget.chatMessage.status == BubbleStatus.error) {
      bubbleColor = ColorConstant.destructive500;
    } else if (widget.chatMessage.status == BubbleStatus.success) {
      bubbleColor = ColorConstant.success300;
    } else if (widget.chatMessage.status == BubbleStatus.undeterminedError) {
      bubbleColor = ColorConstant.destructive50;
    } else if (widget.chatMessage.status == BubbleStatus.warningError) {
      bubbleColor = ColorConstant.warning100;
    }
    Widget bubbleContent = InkWell(
      onTap: widget.chatMessage.editable? widget.onEdit:(){},
      child: TextChatBubble(
        bubbleColor: bubbleColor,
        borderRadius: borderRadius,
        isMe: widget.isMe,
        chatMessage: widget.chatMessage,
        visible: _visible,
        onEdit: widget.onEdit,
        showTimestamp: _showTimestamp,
      ),
    );
    if (widget.chatMessage.image != null ||
        widget.chatMessage.previews != null ||
        widget.chatMessage.uploadingPreviews != null) {
      bubbleContent = ImageBubble(
        chatMessage: widget.chatMessage,
        showTimestamp: _showTimestamp,
      );
    }
    if (widget.chatMessage.file != null) {
      bubbleContent = FileChatBubble(
        chatMessage: widget.chatMessage,
        fileMessage: widget.chatMessage.file!,
        borderRadius: borderRadius,
        visible: _visible,
        isMe: widget.isMe,
      );
    }
    if (widget.chatMessage.uploadingFile != null) {
      bubbleContent = UploadingFileBubble(
        chatMessage: widget.chatMessage,
        fileMessage: widget.chatMessage.uploadingFile!,
        borderRadius: borderRadius,
        visible: _visible,
        isMe: widget.isMe,
      );
    }
    if (widget.chatMessage.videoPreview != null) {
      bubbleContent = VideoThumbnail(
        file: widget.chatMessage.videoPreview!,
      );
    }
    if (widget.chatMessage.responseContent != null) {
      return ResponseBubble(
        responseContent: widget.chatMessage.responseContent!,
      );
    }
    double replyMessagePadding = 10;
    if (widget.isMe) {
      if (widget.chatMessage.previews != null) {
        replyMessagePadding = 30;
      }
      if (widget.chatMessage.file != null) {
        replyMessagePadding = 75;
      }
    } else {
      if (widget.chatMessage.previews != null) {
        replyMessagePadding = 80;
      }
      if (widget.chatMessage.file != null) {
        replyMessagePadding = 75;
      }
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _showTimestamp = !_showTimestamp;
        });
      },
      onLongPress: !widget.allowActionEvents
          ? null
          : () => widget.onLongClickMessage(widget.chatMessage),
      child: Dismissible(
        behavior: HitTestBehavior.deferToChild,
        key: UniqueKey(),
        movementDuration: const Duration(milliseconds: 200),
        dismissThresholds: const {
          DismissDirection.endToStart: 0.01,
          DismissDirection.startToEnd: 0.01,
        },
        direction: !widget.allowActionEvents
            ? DismissDirection.none
            : widget.isMe
                ? DismissDirection.endToStart
                : DismissDirection.startToEnd,
        confirmDismiss: (DismissDirection direction) async {
          widget.onReply(widget.chatMessage);
          return false;
        },
        onDismissed: (DismissDirection direction) {},
        child: _bubbleContents(
          replyMessagePadding,
          borderRadius,
          bubbleContent,
        ),
      ),
    );
  }

  AnimatedOpacity _bubbleContents(double replyMessagePadding,
      BorderRadius borderRadius, Widget bubbleContent) {
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      child: Padding(
        padding: EdgeInsets.only(
          top: widget.chatMessage.repliedContent != null
              ? replySize + replyMessagePadding
              : 0,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (widget.chatMessage.repliedContent != null)
              FloatingReplyBubble(
                isMe: widget.isMe,
                chatMessage: widget.chatMessage,
                visible: _visible,
                borderRadius: borderRadius,
                onChange: (size) {
                  setState(() {
                    replySize = size.height;
                  });
                },
                showTimestamp: _showTimestamp,
              ),
            Padding(
              padding: widget.isWithAvatar || widget.applySpacing
                  ? EdgeInsets.only(
                      left: widget.isMe ? 0.0 : 43.0,
                      right: widget.isMe ? 60.0 : 0.0)
                  : const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: widget.isMe
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.isMe && widget.isPinned)
                     SvgAsset(
                      color: ColorConstant.primary500,
                      asset: AssetConstant.pinIcon,
                      size: 30,
                    ),
                  if (widget.isMe && widget.isPinned)
                    const SizedBox(width: 10.0),
                  // AnimatedOpacity(
                  //   opacity: _visible ? 1 : 0,
                  //   duration: const Duration(milliseconds: 500),
                  //   child: CircularRevealAnimation(
                  //     animation: animation,
                  //     centerAlignment:
                  //         widget.isMe ? Alignment.topRight : Alignment.topLeft,
                  //     minRadius: 0,
                  //     maxRadius: 500,
                  //     child: bubbleContent,
                  //   ),
                  // ),
                  bubbleContent,
                  if (!widget.isMe && widget.isPinned)
                    const SizedBox(width: 10.0),
                  if (!widget.isMe && widget.isPinned)
                     SvgAsset(
                      color: ColorConstant.neutral500,
                      asset: AssetConstant.pinIcon,
                      size: 30,
                    ),
                ],
              ),
            ),
            if (widget.showAvatar && widget.isWithAvatar)
              Positioned(
                bottom: widget.chatMessage.timestamp != null ? 10 : -2,
                left: widget.isMe ? null : 0,
                right: widget.isMe ? 8 : null,
                child: widget.isAssistantAvatar
                    ? const CircleAvatar(
                        backgroundImage: AssetImage(AssetConstant.avatarIcon))
                    : const ProfilePicture(
                    size: 32,
                    showOnlineIndicator: false,
                    url:  ""),
                // ChatboxBuilderWidget(
                //         builder: (context, state) => ProfilePicture(
                //             size: 32,
                //             showOnlineIndicator: false,
                //             url: state.otherUser?.profile ?? ""),
                //       ),
              ),
            if (widget.isMe)
              Positioned(
                bottom: 0,
                right: -50,
                child: TinyButton(
                  color: ColorConstant.neutral50,
                  splashColor: ColorConstant.neutral50,
                  onTap: () {},
                  icon: AssetConstant.shareIcon,
                  iconColor: ColorConstant.neutral800,
                  size: 20,
                  iconPadding: 8.0,
                ),
              ),
            if (!widget.isMe)
              Positioned(
                bottom: 0,
                left: -50,
                child: TinyButton(
                  color: ColorConstant.neutral50,
                  splashColor: ColorConstant.neutral50,
                  onTap: () {},
                  icon: AssetConstant.shareIcon,
                  iconColor: ColorConstant.neutral800,
                  size: 20,
                  iconPadding: 8.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}


