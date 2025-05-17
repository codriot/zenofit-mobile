

import 'package:diet_app_mobile/controller/home/home_view_controller.dart';
import 'package:get/get.dart';

class HomeViewBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewController>(() => HomeViewController());
  }
}