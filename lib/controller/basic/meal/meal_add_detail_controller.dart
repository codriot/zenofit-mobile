import 'package:get/get.dart';
import '../../../model/meal_model.dart';

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

  MealContentModel? getSelectedContent() {
    if (selectedMeal.value != null) {
      try {
        return selectedMeal.value!.recommendedContents
            .firstWhere((element) => element.isSelected);
      } catch (e) {
        // Artık otomatik seçim yapmıyoruz
        return null;
      }
    }
    return null;
  }

  // Eğer gerekirse, ilk öğeyi seçmek için ayrı bir metod oluşturabiliriz
  void selectFirstContent() {
    if (selectedMeal.value != null && 
        selectedMeal.value!.recommendedContents.isNotEmpty) {
      selectedMeal.value!.recommendedContents[0].isSelected = true;
      selectedMeal.refresh();
    }
  }

  // Makro değerlerini almak için getter
  Map<String, Map<String, dynamic>> getTotalMacros() {
    return totalMacros;
  }
} 