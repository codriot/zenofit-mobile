import 'package:diet_app_mobile/model/chat/message_model.dart';

class ChatModel {
  final String? imageUrl;
  final String? name;
  final String? surName;
  final String? lastChat;
  final int? unReadMessageCount;
  final List<MessageModel>? messages;
  final bool? isOnline;
  final int? userId;

  ChatModel({
    this.imageUrl,
    this.name,
    this.surName,
    this.lastChat,
    this.unReadMessageCount,
    this.messages,
    this.isOnline = false,
    this.userId,
  });

  ChatModel copyWith({
    String? imageUrl,
    String? name,
    String? surName,
    String? lastChat,
    int? unReadMessageCount,
    List<MessageModel>? messages,
    bool? isOnline,
    int? userId,
  }) {
    return ChatModel(
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      surName: surName ?? this.surName,
      lastChat: lastChat ?? this.lastChat,
      unReadMessageCount: unReadMessageCount ?? this.unReadMessageCount,
      messages: messages ?? this.messages,
      isOnline: isOnline ?? this.isOnline,
      userId: userId ?? this.userId,
    );
  }
}
