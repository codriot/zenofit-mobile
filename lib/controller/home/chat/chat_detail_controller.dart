import 'package:diet_app_mobile/model/chat/message_model.dart';
import 'package:get/get.dart';

class ChatDetailController extends GetxController {
  var messages = <MessageModel>[].obs; // Observable list of messages

  @override
  void onInit() {
    super.onInit();
    messages.addAll(Get.arguments);
  }

  void sendMessage(String content) {
    final newMessage = MessageModel(
      sender: "Sen",
      imageUrl: "person", // Kullanıcı resmi
      name: "Senin Adın", // Kullanıcı adı
      surName: "Soyadın", // Kullanıcı soyadı
      message: content,
      time: DateTime.now().toString().substring(11, 16), // Zamanı al
    );
    messages.add(newMessage);
  }

  void receiveMessage(String content) {
    final newMessage = MessageModel(
      sender: "Dyt. Furkan Yıldırım",
      imageUrl: "person", // Diğer kişinin resmi
      name: "Dyt.",
      surName: "Furkan Yıldırım",
      message: content,
      time: DateTime.now().toString().substring(11, 16), // Zamanı al
    );
    messages.add(newMessage);
  }
}
