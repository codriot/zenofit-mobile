class MessageModel {
  final int messageId;
  final int senderId;
  final int receiverId;
  final String messageContent;
  final DateTime sentAt;

  MessageModel({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.messageContent,
    required this.sentAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json['message_id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      messageContent: json['message_content'],
      sentAt: DateTime.parse(json['sent_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message_content': messageContent,
      'sent_at': sentAt.toIso8601String(),
    };
  }
}
