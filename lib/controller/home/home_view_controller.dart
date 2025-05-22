import 'package:diet_app_mobile/API/services/storage_service.dart';
import 'package:diet_app_mobile/model/home/nutrition_calories_model.dart';
import 'package:get/get.dart';
import 'package:diet_app_mobile/controller/home/water/add_water_controller.dart';
import 'package:diet_app_mobile/API/services/general_serivce.dart';

class HomeViewController extends GetxController {
  final userName = "Bilinmeyen Kullanıcı".obs;
  final userNutiritionCalories = Rxn<NutritionCaloriesModel>();
  final isLoading = false.obs; // Yükleme durumunu takip etmek için
  
  // Su miktarı değerleri
  final RxDouble currentWaterAmount = 0.0.obs;
  final RxDouble targetWaterAmount = 0.0.obs;
  final RxDouble waterProgress = 0.0.obs;
  
  // Su ekleme geçmişi
  final RxList<int> waterHistory = <int>[].obs;
  
  AddWaterController? _addWaterController;

  @override
  Future<void> onInit() async {
    super.onInit();
    loadUserName();
    await loadNutritionCaloriesData();
    _loadWaterData(); // Önce kendi verilerimizi yükle
    _initializeWaterController();
  }

  void _loadWaterData() {
    final savedData = StorageService.instance.loadData(StorageItems.waterData);
    if (savedData != null) {
      final List<dynamic> savedAmounts = savedData['amounts'] as List<dynamic>;
      waterHistory.assignAll(savedAmounts.map((e) => e as int).toList());
      
      // Toplam su miktarını hesapla
      double totalAmount = 0;
      for (var waterAmount in waterHistory) {
        totalAmount += waterAmount / 1000; // ml'yi L'ye çevir
      }
      currentWaterAmount.value = totalAmount;
      waterProgress.value = currentWaterAmount.value / targetWaterAmount.value;
    }
  }

  void _initializeWaterController() {
    try {
      _addWaterController = Get.find<AddWaterController>();
      
      // Hedef su miktarını ayarla
      targetWaterAmount.value = calculateDailyWaterIntakeLiters();
      
      // AddWaterController'daki verileri senkronize et
      _syncWaterData();
      
      // Su miktarı değişikliklerini dinle
      ever(_addWaterController!.currentWaterAmount, (value) {
        currentWaterAmount.value = value;
        waterProgress.value = currentWaterAmount.value / targetWaterAmount.value;
      });
      
      // Su ekleme geçmişini dinle
      ever(_addWaterController!.addedWaterAmounts, (amounts) {
        waterHistory.assignAll(amounts);
      });
    } catch (e) {
      print("AddWaterController bulunamadı: $e");
    }
  }

  void _syncWaterData() {
    if (_addWaterController != null) {
      // AddWaterController'daki verileri al
      currentWaterAmount.value = _addWaterController!.currentWaterAmount.value;
      waterHistory.assignAll(_addWaterController!.addedWaterAmounts);
      waterProgress.value = currentWaterAmount.value / targetWaterAmount.value;
    }
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

      // Önce local'den veriyi oku
      final localData = StorageService.instance.loadData(StorageItems.nutritionCalories);
      if (localData != null) {
        userNutiritionCalories.value = NutritionCaloriesModel.fromJson(localData);
        return userNutiritionCalories.value;
      }

      // Local'de veri yoksa API'den çek
      final response = await GeneralService.instance.authorizedGet('/nutrition/ai/calculate-calories');
      if (response != null && response.data is Map<String, dynamic>) {
        await StorageService.instance.saveData(
          StorageItems.nutritionCalories,
          response.data,
        );
        userNutiritionCalories.value = NutritionCaloriesModel.fromJson(response.data);
        return userNutiritionCalories.value;
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
