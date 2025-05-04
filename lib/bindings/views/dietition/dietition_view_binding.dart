

import 'package:diet_app_mobile/controller/dietition/dietition_view_controller.dart';
import 'package:get/get.dart';

class DietitionViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DietitionViewController>(() => DietitionViewController());
  }
}