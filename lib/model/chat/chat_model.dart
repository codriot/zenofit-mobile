import 'package:diet_app_mobile/model/chat/message_model.dart';

class ChatModel {
  final String? imageUrl;
  final String? name;
  final String? surName;
  final String? lastChat;
  final int? unReadMessageCount;
  final List<MessageModel>? messages;
  final bool? isOnline;

  ChatModel(
      {required this.imageUrl,
      required this.name,
      required this.surName,
      required this.lastChat,
      required this.unReadMessageCount,
      required this.messages,
      this.isOnline = false});
}
