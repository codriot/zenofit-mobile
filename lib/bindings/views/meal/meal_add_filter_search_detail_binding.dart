import 'package:get/get.dart';
import 'package:diet_app_mobile/controller/home/meal/meal_add_filter_search_detail_controller.dart';

class MealAddFilterSearchDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MealAddFilterSearchDetailController>(() => MealAddFilterSearchDetailController());
  }
} 