import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diet_app_mobile/controller/basic/meal/meal_add_detail_controller.dart';

class MealAddFilterSearchController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString selectedMealType = 'Kahvaltı'.obs;
  final RxList<Map<String, dynamic>> recentMeals = <Map<String, dynamic>>[].obs;
  final detailController = Get.find<MealAddDetailController>();

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  void _loadInitialData() {
    // Örnek veri - Gerçek uygulamada bu veriler API'den veya veritabanından gelecek
    recentMeals.value = List.generate(
      8,
      (index) => {
        'title': 'Lifatif, Yulaf Ezmesi',
        'calories': '360 kal',
        'amount': '100.0 g',
        'protein': 28,
        'carbs': 128,
        'fat': 18,
        'backgroundColor': const Color(0xFFE67E22),
      },
    );
  }

  void onSearchChanged(String value) {
    // Arama fonksiyonu
    if (value.isEmpty) {
      _loadInitialData();
      return;
    }

    final filteredMeals = recentMeals.where((meal) {
      return meal['title']
          .toString()
          .toLowerCase()
          .contains(value.toLowerCase());
    }).toList();

    recentMeals.value = filteredMeals;
  }

  void onQuickAddPressed() {
    NavigatorController.instance.pushToPage(
      NavigateRoutesItems.addMealFastItem,
    );
  }

  void onAddMealPressed(Map<String, dynamic> meal) {
    NavigatorController.instance.pushToPage(
      NavigateRoutesItems.addMealFilterSearchDetail,
      arguments: {'meal': meal},
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
