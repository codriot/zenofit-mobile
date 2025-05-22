import 'package:get/get.dart';
import 'package:diet_app_mobile/controller/home/water/add_water_controller.dart';
import 'package:diet_app_mobile/controller/home/home_view_controller.dart';

class AddWaterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddWaterController>(() => AddWaterController());
    Get.lazyPut<HomeViewController>(() => HomeViewController());
  }
} 