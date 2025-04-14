import 'package:diet_app_mobile/model/chat/message_model.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:flutter/cupertino.dart' show Widget;
import 'package:flutter/material.dart' show showModalBottomSheet;
import 'package:flutter/widgets.dart' show BuildContext;
import 'package:get/get.dart';

class ChatDetailController extends GetxController {
  var messages = <MessageModel>[].obs; // Observable list of messages
  var isMenuOpen = false.obs; // Menü durumunu tutacak
  @override
  void onInit() {
    super.onInit();
    messages.addAll(Get.arguments);
  }

  void toggleMenuOpen() {
    isMenuOpen.value = !isMenuOpen.value;
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
    messages.insert(0, newMessage);
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
    messages.insert(0, newMessage);
  }

  void showBlockUserBottomSheet(BuildContext context,
      {required Widget widget}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColor.transparent.getColor(),
      builder: (BuildContext context) {
        return widget;
      },
    );
  }
}
