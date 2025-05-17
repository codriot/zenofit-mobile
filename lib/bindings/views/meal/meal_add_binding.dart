import 'package:get/get.dart';
import '../../../controller/home/meal/meal_add_controller.dart';

class MealAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MealAddController>(() => MealAddController());
  }
} 