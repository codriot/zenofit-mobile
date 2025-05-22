import 'package:get/get.dart';
import 'package:diet_app_mobile/controller/home/water/add_water_controller.dart';

class AddWaterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddWaterController>(() => AddWaterController());
  }
} 