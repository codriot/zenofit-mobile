import 'package:get/get.dart';
import '../../../model/home/meal_model.dart';
import '../../../model/recipe_model.dart';
import '../../../API/services/general_serivce.dart';
import 'package:flutter/material.dart';

class MealAddDetailController extends GetxController {
  final Rx<MealModel?> selectedMeal = Rx<MealModel?>(null);
  final RxList<RecipeModel> recipes = <RecipeModel>[].obs;
  final RxBool isLoading = false.obs;

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
    _loadRecipes();
    calculateTotalMacros();
  }

  void _initializeMealData() {
    final arguments = Get.arguments;
    if (arguments != null && arguments['meal'] != null) {
      selectedMeal.value = arguments['meal'] as MealModel;
      if (selectedMeal.value != null && 
          selectedMeal.value!.recommendedContents.isNotEmpty) {
        selectedMeal.value!.recommendedContents[0].isSelected = true;
      }
    }
  }

  // Toplam kaloriyi hesapla ve subtitle'ı güncelle
  void _updateSubtitleWithTotalCalories() {
    if (selectedMeal.value != null) {
      double totalCalories = 0;
      for (var content in selectedMeal.value!.recommendedContents) {
        totalCalories += content.calories;
      }
      
      // Subtitle'ı güncelle
      if (totalCalories > 0) {
        selectedMeal.value!.subtitle = 'Önerilen Öğün - ${totalCalories.toInt()} kalori';
      } else {
        selectedMeal.value!.subtitle = 'Önerilen Öğün';
      }
      selectedMeal.refresh();
    }
  }

  Future<void> _loadRecipes() async {
    try {
      isLoading.value = true;
      // Öğün tipine göre API'den veri çekme
      String mealType = selectedMeal.value?.title.toLowerCase() ?? 'breakfast';
      
      // Türkçe öğün isimlerini İngilizce'ye çevirme
      switch (mealType) {
        case 'kahvaltı':
          mealType = 'breakfast';
          break;
        case 'öğle yemeği':
          mealType = 'lunch';
          break;
        case 'akşam yemeği':
          mealType = 'dinner';
          break;
      }
      
      final loadedRecipes = await GeneralService.instance.getRecipesByMealType(mealType);
      
      if (loadedRecipes.isNotEmpty) {
        selectedMeal.value!.recommendedContents = loadedRecipes;
        selectedMeal.refresh();
        _updateSubtitleWithTotalCalories(); // Toplam kaloriyi güncelle
      } else {
        // API'den veri gelmezse varsayılan verileri kullan
        selectedMeal.value = MealModel.fromType(mealType);
      }
    } catch (e) {
      print('Error loading recipes: $e');
      // Hata durumunda varsayılan verileri kullan
      if (selectedMeal.value != null) {
        String mealType = selectedMeal.value!.title.toLowerCase();
        // Türkçe öğün isimlerini İngilizce'ye çevirme
        switch (mealType) {
          case 'kahvaltı':
            mealType = 'breakfast';
            break;
          case 'öğle yemeği':
            mealType = 'lunch';
            break;
          case 'akşam yemeği':
            mealType = 'dinner';
            break;
        }
        selectedMeal.value = MealModel.fromType(mealType);
      }
    } finally {
      isLoading.value = false;
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
      maxCarbs += content.carbohydrateContent;
      maxProtein += content.proteinContent;
      maxFat += content.fatContent;
    }

    // Seçili öğünlerin değerlerini topla
    for (var content in selectedMeal.value?.recommendedContents ?? []) {
      if (content.isSelected) {
        totalCarbs += content.carbohydrateContent;
        totalProtein += content.proteinContent;
        totalFat += content.fatContent;
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
      final newContent = RecipeModel(
        recipeId: DateTime.now().millisecondsSinceEpoch,
        name: mealData['title'],
        cookTime: 'PT0M',
        prepTime: 'PT0M',
        totalTime: 'PT0M',
        recipeIngredientParts: [],
        calories: 0,
        proteinContent: double.tryParse(mealData['proteinText'].toString().replaceAll(' gram', '')) ?? 0,
        carbohydrateContent: double.tryParse(mealData['carbsText'].toString().replaceAll(' gram', '')) ?? 0,
        fatContent: double.tryParse(mealData['fatText'].toString().replaceAll(' gram', '')) ?? 0,
        saturatedFatContent: 0,
        cholesterolContent: 0,
        sodiumContent: 0,
        fiberContent: 0,
        sugarContent: 0,
        recipeInstructions: [],
        isSelected: mealData['isSelected'] as bool,
        backgroundColor: mealData['backgroundColor'] as Color,
      );

      selectedMeal.value!.recommendedContents.add(newContent);
      selectedMeal.refresh();
      calculateTotalMacros();
      _updateSubtitleWithTotalCalories(); // Toplam kaloriyi güncelle
    }
  }

  // Filtrelenmiş arama için özel metod
  void addFilteredMeal(Map<String, dynamic> meal) {
    if (selectedMeal.value != null) {
      final newContent = RecipeModel(
        recipeId: DateTime.now().millisecondsSinceEpoch,
        name: meal['title'],
        cookTime: 'PT0M',
        prepTime: 'PT0M',
        totalTime: 'PT0M',
        recipeIngredientParts: [],
        calories: 0,
        proteinContent: (meal['protein'] as int).toDouble(),
        carbohydrateContent: (meal['carbs'] as int).toDouble(),
        fatContent: (meal['fat'] as int).toDouble(),
        saturatedFatContent: 0,
        cholesterolContent: 0,
        sodiumContent: 0,
        fiberContent: 0,
        sugarContent: 0,
        recipeInstructions: [],
        isSelected: true,
      );

      selectedMeal.value!.recommendedContents.add(newContent);
      selectedMeal.refresh();
      calculateTotalMacros();
      _updateSubtitleWithTotalCalories(); // Toplam kaloriyi güncelle
    }
  }

  // Makro değerlerini almak için getter
  Map<String, Map<String, dynamic>> getTotalMacros() {
    return totalMacros;
  }
} 