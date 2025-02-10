import 'package:get/get.dart';
import '../../../model/meal_model.dart';

class MealAddDetailController extends GetxController {
  final Rx<MealModel?> selectedMeal = Rx<MealModel?>(null);

  @override
  void onInit() {
    super.onInit();
    _initializeMealData();
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

  void selectMealContent(int index) {
    if (selectedMeal.value != null) {
      for (var i = 0; i < selectedMeal.value!.recommendedContents.length; i++) {
        selectedMeal.value!.recommendedContents[i].isSelected = i == index;
      }
      selectedMeal.refresh();
    }
  }

  MealContentModel? getSelectedContent() {
    if (selectedMeal.value != null) {
      try {
        return selectedMeal.value!.recommendedContents
            .firstWhere((element) => element.isSelected);
      } catch (e) {
        // Eğer seçili öğe yoksa ilk öğeyi seç ve onu döndür
        if (selectedMeal.value!.recommendedContents.isNotEmpty) {
          selectedMeal.value!.recommendedContents[0].isSelected = true;
          selectedMeal.refresh();
          return selectedMeal.value!.recommendedContents[0];
        }
      }
    }
    return null;
  }

  Map<String, dynamic> getTotalMacros() {
    final selectedContent = getSelectedContent();
    if (selectedContent != null) {
      final totalCalories = (selectedContent.protein * 4) +
          (selectedContent.carbs * 4) +
          (selectedContent.fat * 9);

      return {
        'protein': {
          'percentage': ((selectedContent.protein * 4) / totalCalories * 100).round(),
          'amount': selectedContent.protein
        },
        'carbs': {
          'percentage': ((selectedContent.carbs * 4) / totalCalories * 100).round(),
          'amount': selectedContent.carbs
        },
        'fat': {
          'percentage': ((selectedContent.fat * 9) / totalCalories * 100).round(),
          'amount': selectedContent.fat
        },
      };
    }
    return {
      'protein': {'percentage': 0, 'amount': 0},
      'carbs': {'percentage': 0, 'amount': 0},
      'fat': {'percentage': 0, 'amount': 0},
    };
  }
} 