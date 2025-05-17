
import 'package:diet_app_mobile/controller/main/main_controller.dart';
import 'package:get/get.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController(), fenix: true);
  }
} 