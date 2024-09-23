import '../../../data/models/onboarding/file_model.dart';
import 'bubble/response_bubble.dart';

class ChatboxMessageTags {
  static const String uploading = "uploading";
}

enum BubbleDirection {
  left,
  right;
}

enum BubblePosition { start, middle, end }

enum BubbleType { text, response, images, uploadedImages, file }

class RepliedMessage {
  final String? message;
  final String repliedTo;
  final FileboxMessage? fileboxMessage;

  const RepliedMessage({
    this.message,
    required this.repliedTo,
    this.fileboxMessage,
  });
}

class FileboxMessage {
  final String fileName;
  final String fileBytes;

  const FileboxMessage({required this.fileName, required this.fileBytes});
}

class ChatboxMessage {
  final BubblePosition position;
  final BubbleDirection direction;
  final BubbleType type;
  final String tag;
  final String chatId;
  final String message;
  final ResponseContent? response;
  final List<FileModel>? images;
  final List<String>? urls;
  final FileboxMessage? fileContents;
  final RepliedMessage? repliedMessage;
  final bool pin;

  const ChatboxMessage({
    required this.tag,
    required this.chatId,
    this.message = "",
    this.type = BubbleType.text,
    this.position = BubblePosition.middle,
    this.direction = BubbleDirection.right,
    this.response,
    this.images,
    this.urls,
    this.fileContents,
    this.repliedMessage,
    this.pin = false,
  });

  textable() => type == BubbleType.text && message != "";

  ChatboxMessage copyWith({
    BubblePosition? position,
    BubbleDirection? direction,
    String? message,
    bool? pin,
  }) =>
      ChatboxMessage(
        tag: tag,
        chatId: chatId,
        message: message ?? this.message,
        type: type,
        images: images,
        urls: urls,
        response: response,
        fileContents: fileContents,
        repliedMessage: repliedMessage,
        position: position ?? this.position,
        direction: direction ?? this.direction,
        pin: pin ?? this.pin,
      );
}
