class MessageModel {
  final String? sender;
  final String? imageUrl;
  final String? name;
  final String? surName;
  final String? message;
  final String? time;

  MessageModel(
      {required this.sender,
      required this.imageUrl,
      required this.name,
      required this.surName,
      required this.message,
      required this.time});
}
