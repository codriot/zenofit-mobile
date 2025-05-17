import 'package:get/get.dart';
import '../../../model/home/meal_model.dart';
import 'package:flutter/material.dart';

class MealAddDetailController extends GetxController {
  final Rx<MealModel?> selectedMeal = Rx<MealModel?>(null);

  // Toplam makro değerlerini tutacak RxMap
  final RxMap<String, Map<String, dynamic>> totalMacros = RxMap({
    'carbs': {'amount': 0, 'percentage': 0},
    'protein': {'amount': 0, 'percentage': 0},
    'fat': {'amount': 0, 'percentage': 0},
  });

  @override
  void onInit() {
    super.onInit();
    _initializeMealData();
    calculateTotalMacros(); // Başlangıçta hesapla
  }

  void _initializeMealData() {
    final arguments = Get.arguments;
    if (arguments != null && arguments['meal'] != null) {
      selectedMeal.value = arguments['meal'] as MealModel;
      // İlk öğeyi varsayılan olarak seç
      if (selectedMeal.value != null && 
          selectedMeal.value!.recommendedContents.isNotEmpty) {
        selectedMeal.value!.recommendedContents[0].isSelected = true;
      }
    }
  }

  // Seçilen öğünlerin makrolarını hesapla
  void calculateTotalMacros() {
    num totalCarbs = 0;
    num totalProtein = 0;
    num totalFat = 0;

    // Maksimum değerleri hesapla (tüm öğelerin toplamı)
    num maxCarbs = 0;
    num maxProtein = 0;
    num maxFat = 0;

    // Önce maksimum değerleri hesapla
    for (var content in selectedMeal.value?.recommendedContents ?? []) {
      maxCarbs += content.carbs;
      maxProtein += content.protein;
      maxFat += content.fat;
    }

    // Seçili öğünlerin değerlerini topla
    for (var content in selectedMeal.value?.recommendedContents ?? []) {
      if (content.isSelected) {
        totalCarbs += content.carbs;
        totalProtein += content.protein;
        totalFat += content.fat;
      }
    }
    
    // Yüzdeleri hesapla (maksimum değere göre)
    final carbsPercentage = maxCarbs > 0 ? (totalCarbs / maxCarbs * 100).round() : 0;
    final proteinPercentage = maxProtein > 0 ? (totalProtein / maxProtein * 100).round() : 0;
    final fatPercentage = maxFat > 0 ? (totalFat / maxFat * 100).round() : 0;

    // Değerleri güncelle
    totalMacros.value = {
      'carbs': {'amount': totalCarbs.round(), 'percentage': carbsPercentage},
      'protein': {'amount': totalProtein.round(), 'percentage': proteinPercentage},
      'fat': {'amount': totalFat.round(), 'percentage': fatPercentage},
    };
  }

  // Öğün seçme metodunu güncelle
  void selectMealContent(int index) {
    if (selectedMeal.value != null) {
      selectedMeal.value?.recommendedContents[index].isSelected = 
        !(selectedMeal.value?.recommendedContents[index].isSelected ?? false);
      selectedMeal.refresh();
      // Seçim değiştiğinde makroları yeniden hesapla
      calculateTotalMacros();
    }
  }

  // Hızlı ekleme için özel metod
  void addCustomMeal(Map<String, dynamic> mealData) {
    if (selectedMeal.value != null) {
      final newContent = MealContentModel(
        title: mealData['title'],
        protein: int.tryParse(mealData['proteinText']) ?? 0,
        carbs: int.tryParse(mealData['carbsText']) ?? 0,
        fat: int.tryParse(mealData['fatText']) ?? 0,
        backgroundColor: mealData['backgroundColor'] as Color,
        isSelected: mealData['isSelected'] as bool,
      );

      selectedMeal.value!.recommendedContents.add(newContent);
      selectedMeal.refresh();
      calculateTotalMacros();
    }
  }

  // Filtrelenmiş arama için özel metod
  void addFilteredMeal(Map<String, dynamic> meal) {
    if (selectedMeal.value != null) {
      final newContent = MealContentModel(
        title: meal['title'],
        protein: meal['protein'] as int,
        carbs: meal['carbs'] as int,
        fat: meal['fat'] as int,
        backgroundColor: meal['backgroundColor'] as Color,
        isSelected: true,
      );

      selectedMeal.value!.recommendedContents.add(newContent);
      selectedMeal.refresh();
      calculateTotalMacros();
    }
  }

  // Makro değerlerini almak için getter
  Map<String, Map<String, dynamic>> getTotalMacros() {
    return totalMacros;
  }
} 