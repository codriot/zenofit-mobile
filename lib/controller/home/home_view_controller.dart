import 'package:diet_app_mobile/API/services/storage_service.dart';
import 'package:diet_app_mobile/model/home/nutrition_calories_model.dart';
import 'package:get/get.dart';
import 'package:diet_app_mobile/controller/home/water/add_water_controller.dart';

class HomeViewController extends GetxController {
  final userName = "Bilinmeyen Kullanıcı".obs;
  late NutritionCaloriesModel? userNutiritionCalories;
  final isLoading = false.obs; // Yükleme durumunu takip etmek için
  
  // Su miktarı değerleri
  final RxDouble currentWaterAmount = 0.0.obs;
  final RxDouble targetWaterAmount = 0.0.obs;
  final RxDouble waterProgress = 0.0.obs;
  
  // Su ekleme geçmişi
  final RxList<int> waterHistory = <int>[].obs;
  
  late final AddWaterController _addWaterController;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadUserName();
    await loadNutritionCaloriesData();
    _initializeWaterController();
  }

  void _initializeWaterController() {
    _addWaterController = Get.find<AddWaterController>();
    
    // Hedef su miktarını ayarla
    targetWaterAmount.value = calculateDailyWaterIntakeLiters();
    
    // AddWaterController'daki verileri senkronize et
    _syncWaterData();
    
    // Su miktarı değişikliklerini dinle
    ever(_addWaterController.currentWaterAmount, (value) {
      currentWaterAmount.value = value;
      waterProgress.value = currentWaterAmount.value / targetWaterAmount.value;
    });
    
    // Su ekleme geçmişini dinle
    ever(_addWaterController.addedWaterAmounts, (amounts) {
      waterHistory.assignAll(amounts);
    });
  }

  void _syncWaterData() {
    // AddWaterController'daki verileri al
    currentWaterAmount.value = _addWaterController.currentWaterAmount.value;
    waterHistory.assignAll(_addWaterController.addedWaterAmounts);
    waterProgress.value = currentWaterAmount.value / targetWaterAmount.value;
  }

  @override
  void onReady() {
    super.onReady();
    // Sayfa hazır olduğunda verileri tekrar senkronize et
    _syncWaterData();
  }

  void loadUserName() {
    final user = StorageService.instance.loadUser();
    userName.value = user?.name ?? "Bilinmeyen Kullanıcı";
  }

  Future<NutritionCaloriesModel?> loadNutritionCaloriesData() async {
    try {
      isLoading.value = true;

      // Sadece local'den veriyi oku
      final localData =
          StorageService.instance.loadData(StorageItems.nutritionCalories);
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

  double calculateDailyWaterIntakeLiters() {
    final user = StorageService.instance.loadUser();
    final weightKg = user?.weight;
    if (weightKg == null) {
      return 0;
    }
    return (weightKg * 33) / 1000; // litre cinsinden
  }
}

enum ExpansionSection {
  diet,
  attention,
  shouldEat,
  shouldAvoid,
}
