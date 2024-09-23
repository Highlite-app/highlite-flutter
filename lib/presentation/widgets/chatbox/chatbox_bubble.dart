import 'package:flutter/material.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chatbox/bubble/chatbox_file_bubble.dart';
import 'package:highlite_flutter_mvp/presentation/widgets/chatbox/bubble/floating_reply_bubble.dart';

import '../../../core/resources/asset_constants.dart';
import '../../../core/resources/color_constants.dart';
import '../../../core/services/single_uploader_service.dart';
import '../chat/bubble/previews_bubble.dart';
import '../gallery/preview_gallery.dart';
import '../layout/measure_size.dart';
import '../layout/stretched_column.dart';
import '../svg/svg_asset.dart';
import 'bubble/chatbox_text_bubble.dart';
import 'bubble/response_bubble.dart';
import 'chatbox_message.dart';

class ChatboxBubble extends StatefulWidget {
  final ChatboxMessage message;
  final VoidCallback onReply;
  final VoidCallback onLongClick;
  final bool pinned;

  const ChatboxBubble({
    super.key,
    required this.message,
    required this.onReply,
    required this.onLongClick,
    required this.pinned,
  });

  @override
  State<ChatboxBubble> createState() => _ChatboxBubbleState();
}

class _ChatboxBubbleState extends State<ChatboxBubble> {
  double bubbleSize = 0;
  double repliedBubbleSize = 0;

  @override
  Widget build(BuildContext context) {
    Widget chatMessage;
    switch (widget.message.type) {
      case BubbleType.text:
        chatMessage = ChatboxTextBubble(
          message: widget.message.message,
          direction: widget.message.direction,
          position: widget.message.position,
          pinned: widget.pinned,
        );
        break;
      case BubbleType.response:
        return ResponseBubble(
          responseContent: widget.message.response!,
        );
      case BubbleType.images:
        chatMessage = StretchedColumn(
          contentDirection: CrossAxisAlignment.end,
          child: PreviewsBubble(
            previews: widget.message.images!
                .map(
                  (preview) => PreviewModel(
                    url: "",
                    file: preview.file,
                    fileType: preview.fileType,
                    uploading:
                        widget.message.tag == ChatboxMessageTags.uploading,
                  ),
                )
                .toList(),
          ),
        );
        break;
      case BubbleType.file:
        chatMessage = StretchedColumn(
          contentDirection: widget.message.direction == BubbleDirection.right
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.message.direction == BubbleDirection.right && widget.pinned
                  ? const Pin(spacingInLeft: false)
                  : Container(),
              FileChatboxBubble(
                fileboxMessage: widget.message.fileContents!,
                direction: widget.message.direction,
                position: widget.message.position,
                uploading: widget.message.tag == ChatboxMessageTags.uploading,
              ),
              widget.message.direction == BubbleDirection.left && widget.pinned
                  ? const Pin(spacingInLeft: true)
                  : Container(),
            ],
          ),
        );
        break;
      case BubbleType.uploadedImages:
        chatMessage = StretchedColumn(
          contentDirection: widget.message.direction == BubbleDirection.right
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.message.direction == BubbleDirection.right && widget.pinned
                  ? const Pin(spacingInLeft: false)
                  : Container(),
              PreviewsBubble(
                previews: widget.message.urls!
                    .map(
                      (preview) => PreviewModel(
                        url: preview,
                        fileType: FileType.photo,
                        uploading:
                            widget.message.tag == ChatboxMessageTags.uploading,
                      ),
                    )
                    .toList(),
              ),
              widget.message.direction == BubbleDirection.left && widget.pinned
                  ? const Pin(spacingInLeft: true)
                  : Container(),
            ],
          ),
        );
        break;
    }
    return Padding(
      padding: EdgeInsets.only(
          top: repliedBubbleSize != 0 ? repliedBubbleSize - 20 : 0),
      child: GestureDetector(
        onLongPress: widget.onLongClick,
        child: Dismissible(
          behavior: HitTestBehavior.deferToChild,
          key: UniqueKey(),
          movementDuration: const Duration(milliseconds: 100),
          dismissThresholds: const {
            DismissDirection.endToStart: 0.01,
            DismissDirection.startToEnd: 0.01,
          },
          direction: widget.message.direction == BubbleDirection.right
              ? DismissDirection.endToStart
              : DismissDirection.startToEnd,
          confirmDismiss: (DismissDirection direction) async {
            widget.onReply();
            return false;
          },
          onDismissed: (DismissDirection direction) {},
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (widget.message.repliedMessage != null)
                FloatingReplyBubble(
                  direction: widget.message.direction,
                  bubbleSize: bubbleSize,
                  replyBubbleSize: repliedBubbleSize,
                  repliedBubbleSize: (height) {
                    if (repliedBubbleSize != height) {
                      setState(() {
                        repliedBubbleSize = height;
                      });
                    }
                  },
                  message: widget.message,
                ),
              Padding(
                padding: EdgeInsets.only(
                    top: widget.message.repliedMessage != null
                        ? (bubbleSize) + 10
                        : 2),
                child: MeasureSize(
                  onChange: (size) {
                    if (bubbleSize != size.height) {
                      setState(() {
                        bubbleSize = size.height;
                      });
                    }
                  },
                  child: chatMessage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Pin extends StatelessWidget {
  final bool spacingInLeft;

  const Pin({
    super.key,
    required this.spacingInLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (spacingInLeft) const SizedBox(width: 10.0),
        SvgAsset(
          color: ColorConstant.primary500,
          asset: AssetConstant.pinIcon,
          size: 30,
        ),
        if (!spacingInLeft) const SizedBox(width: 10.0),
      ],
    );
  }
}
