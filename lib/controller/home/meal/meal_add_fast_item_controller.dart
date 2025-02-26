import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diet_app_mobile/controller/home/meal/meal_add_detail_controller.dart';

class MealAddFastItemController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController calorieController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController carbController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();

  final RxString selectedMealType = 'Kahvaltı'.obs;
  final detailController = Get.find<MealAddDetailController>();

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

      // Detail view'daki listeye ekleme
      detailController.addCustomMeal(mealData);
      
      // Geri dön
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
    nameController.dispose();
    calorieController.dispose();
    fatController.dispose();
    carbController.dispose();
    proteinController.dispose();
    super.onClose();
  }
} 