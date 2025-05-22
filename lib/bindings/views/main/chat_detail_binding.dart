
import 'package:diet_app_mobile/controller/home/chat/chat_detail_controller.dart';
import 'package:get/get.dart';

class ChatDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatDetailController>(() => ChatDetailController(), fenix: true);
  }
}