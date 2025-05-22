

import 'package:diet_app_mobile/controller/home/home_view_controller.dart';
import 'package:diet_app_mobile/controller/home/water/add_water_controller.dart';
import 'package:get/get.dart';

class HomeViewBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewController>(() => HomeViewController());
    Get.lazyPut<AddWaterController>(() => AddWaterController());
  }
}