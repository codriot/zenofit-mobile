import 'package:diet_app_mobile/API/services/storage_service.dart';
import 'package:diet_app_mobile/model/home/nutrition_calories_model.dart';
import 'package:get/state_manager.dart';

class HomeViewController extends GetxController {
  final userName = "Bilinmeyen Kullanıcı".obs;
  late NutritionCaloriesModel? userNutiritionCalories;
  final isLoading = false.obs; // Yükleme durumunu takip etmek için

  @override
  Future<void> onInit() async {
    super.onInit();
    loadUserName();
    await loadNutritionCaloriesData();
  }

  void loadUserName() {
    final user = StorageService.instance.loadUser();
    userName.value = user?.name ?? "Bilinmeyen Kullanıcı";
  }

  Future<NutritionCaloriesModel?> loadNutritionCaloriesData() async {
    try {
      isLoading.value = true;
      
      // Sadece local'den veriyi oku
      final localData = StorageService.instance.loadData(StorageItems.nutritionCalories);
      if (localData != null) {
        userNutiritionCalories = NutritionCaloriesModel.fromJson(localData);
        return userNutiritionCalories;
      }
    } catch (e) {
      print("Hata oluştu: $e");
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  var expandedSection = Rxn<ExpansionSection>(); // null olabiliyor

  void toggleSection(ExpansionSection section, bool expanded) {
    expandedSection.value = expanded ? section : null;
  }

  bool isSectionExpanded(ExpansionSection section) =>
      expandedSection.value == section;
}

enum ExpansionSection {
  diet,
  attention,
  shouldEat,
  shouldAvoid,
}
