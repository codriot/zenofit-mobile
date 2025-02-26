import 'package:diet_app_mobile/controller/home/meal/meal_add_fast_item_controller.dart';
import 'package:get/get.dart';

class MealAddFastItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MealAddFastItemController>(() => MealAddFastItemController());
  }
} 