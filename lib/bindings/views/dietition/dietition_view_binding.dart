import 'package:diet_app_mobile/controller/dietitian/dietitian_view_controller.dart';
import 'package:get/get.dart';

class DietitianViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DietitianViewController>(() => DietitianViewController());
  }
}
