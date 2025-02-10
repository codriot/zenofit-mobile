import 'package:get/get.dart';
import '../../../controller/basic/meal/meal_add_detail_controller.dart';

class MealDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MealAddDetailController>(() => MealAddDetailController());
  }
} 