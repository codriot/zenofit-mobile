import 'package:get/get.dart';
import 'meal_add_detail_controller.dart';

class MealAddDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MealAddDetailController>(() => MealAddDetailController());
  }
} 