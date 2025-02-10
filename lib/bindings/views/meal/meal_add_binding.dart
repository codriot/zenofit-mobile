import 'package:get/get.dart';
import '../../../controller/basic/meal/meal_add_controller.dart';

class MealAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MealAddController>(() => MealAddController());
  }
} 