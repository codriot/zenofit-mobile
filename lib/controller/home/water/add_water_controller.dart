import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddWaterController extends GetxController {
  // Seçili gün için RxInt (0'dan başlayarak)
  final RxInt selectedDayIndex = 3.obs;
  
  // Günlerin listesi
  final RxList<DateTime> days = <DateTime>[].obs;

  // Su miktarı değerleri
  final RxDouble currentWaterAmount = 1.5.obs;
  final RxDouble targetWaterAmount = 2.5.obs;
  final RxDouble waterProgress = 0.6.obs;

  // Eklenen su miktarları listesi
  final RxList<int> addedWaterAmounts = <int>[].obs;

  // Manuel su girişi için controller
  final TextEditingController manualWaterController = TextEditingController();

  // Seçilebilir su miktarları
  final List<int> waterAmounts = [100, 200, 250, 300, 350 , 400];

  // Seçili miktar
  final RxInt selectedAmount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeDays();
  }

  @override
  void onClose() {
    manualWaterController.dispose();
    super.onClose();
  }

  void _initializeDays() {
    // Bugünün tarihinden başlayarak 7 günlük liste oluştur
    final now = DateTime.now();
    days.value = List.generate(
      7,
      (index) => now.add(Duration(days: index - 3)), // 3 gün önceden başla
    );
  }

  // Gün seçme fonksiyonu
  void selectDay(int index) {
    selectedDayIndex.value = index;
    // TODO: Seçili güne ait su verilerini yükle
  }

  // Su miktarı seçme fonksiyonu
  void selectWaterAmount(int amount) {
    selectedAmount.value = amount;
    // Seçilen miktarı mevcut su miktarına ekle
    addWater(amount);
  }

  // Manuel su ekleme fonksiyonu
  void addManualWater() {
    final amount = int.tryParse(manualWaterController.text);
    if (amount != null && amount > 0) {
      addWater(amount);
      manualWaterController.clear();
    } else {
      Get.snackbar(
        'Hata',
        'Lütfen geçerli bir miktar giriniz',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Su ekleme işlemi
  void addWater(int amount) {
    // Eklenen miktarı listeye ekle
    addedWaterAmounts.add(amount);
    
    // Toplam su miktarını hesapla
    double totalAmount = 0;
    for (var waterAmount in addedWaterAmounts) {
      totalAmount += waterAmount / 1000; // ml'yi L'ye çevir
    }
    
    // Toplam miktarı güncelle
    currentWaterAmount.value = totalAmount;
    
    // Progress'i güncelle
    waterProgress.value = currentWaterAmount.value / targetWaterAmount.value;
    if (waterProgress.value > 1) waterProgress.value = 1;
  }

  // Tarih formatını döndüren fonksiyon
  String getFormattedDate(DateTime date) {
    final now = DateTime.now();
    if (date.day == now.day && date.month == now.month && date.year == now.year) {
      return 'Bugün, ${date.day} ${_getMonthName(date.month)}';
    }
    return '${date.day} ${_getMonthName(date.month)}';
  }

  // Ay ismini döndüren fonksiyon
  String _getMonthName(int month) {
    const months = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık'
    ];
    return months[month - 1];
  }

  void onSavePressed() {
    if (manualWaterController.text.isNotEmpty) {
      final amount = int.tryParse(manualWaterController.text);
      if (amount != null && amount > 0) {
        addWater(amount);
        manualWaterController.clear();
      } else {
        Get.snackbar(
          'Hata',
          'Lütfen geçerli bir miktar giriniz',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
    }
  }
} 