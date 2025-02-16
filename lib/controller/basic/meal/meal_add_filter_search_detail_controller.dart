import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diet_app_mobile/controller/basic/meal/meal_add_detail_controller.dart';

class MealAddFilterSearchDetailController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController calorieController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController carbController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();

  final detailController = Get.find<MealAddDetailController>();

  // Reaktif değerler
  final RxString calories = ''.obs;
  final RxString fat = ''.obs;
  final RxString carbs = ''.obs;
  final RxString protein = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    _setupListeners();
  }

  void _setupListeners() {
    // Text controller'ları dinle
    calorieController.addListener(() {
      calories.value = calorieController.text;
    });
    fatController.addListener(() {
      fat.value = fatController.text;
    });
    carbController.addListener(() {
      carbs.value = carbController.text;
    });
    proteinController.addListener(() {
      protein.value = proteinController.text;
    });
  }

  void _initializeData() {
    final arguments = Get.arguments;
    if (arguments != null && arguments['meal'] != null) {
      final meal = arguments['meal'] as Map<String, dynamic>;
      nameController.text = meal['title'] ?? '';
      final calories = meal['calories']?.toString().split(' ').first ?? '';
      calorieController.text = calories;
      fatController.text = meal['fat']?.toString() ?? '';
      carbController.text = meal['carbs']?.toString() ?? '';
      proteinController.text = meal['protein']?.toString() ?? '';

      // Reaktif değerleri güncelle
      this.calories.value = calories;
      fat.value = meal['fat']?.toString() ?? '';
      carbs.value = meal['carbs']?.toString() ?? '';
      protein.value = meal['protein']?.toString() ?? '';
    }
  }

  void onSavePressed() {
    if (_validateInputs()) {
      final mealData = {
        'title': nameController.text,
        'isSelected': true,
        'backgroundColor': const Color(0xFF7CB342),
        'carbsText': carbController.text,
        'proteinText': proteinController.text,
        'fatText': fatController.text,
        'calories': int.tryParse(calorieController.text) ?? 0,
      };

      detailController.addCustomMeal(mealData);
      Get.back();
    }
  }

  bool _validateInputs() {
    if (nameController.text.isEmpty) {
      Get.snackbar(
        'Hata',
        'Lütfen öğün adını giriniz',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (calorieController.text.isEmpty ||
        fatController.text.isEmpty ||
        carbController.text.isEmpty ||
        proteinController.text.isEmpty) {
      Get.snackbar(
        'Hata',
        'Lütfen tüm besin değerlerini giriniz',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    // Listener'ları temizle
    calorieController.removeListener(() {});
    fatController.removeListener(() {});
    carbController.removeListener(() {});
    proteinController.removeListener(() {});

    // Controller'ları dispose et
    nameController.dispose();
    calorieController.dispose();
    fatController.dispose();
    carbController.dispose();
    proteinController.dispose();
    super.onClose();
  }
} 