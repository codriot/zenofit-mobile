

import 'package:diet_app_mobile/controller/home/chat/chat_view_controller.dart';
import 'package:get/get.dart';

class ChatViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatViewController>(() => ChatViewController(), fenix: true);
  }
}