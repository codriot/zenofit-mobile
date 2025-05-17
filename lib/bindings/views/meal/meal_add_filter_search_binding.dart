import 'package:diet_app_mobile/controller/home/meal/meal_add_filter_search_controller.dart';
import 'package:get/get.dart';

class MealAddFilterSearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MealAddFilterSearchController>(() => MealAddFilterSearchController());
  }
} 