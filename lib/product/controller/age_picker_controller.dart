import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgePickerController extends GetxController {
  final ScrollController scrollController = ScrollController();
  var selectedAge = 25.obs; // Varsayılan yaş
  final double itemHeight = 50.0; // Her bir öğenin yüksekliği
  final double visibleRangeTop = 150.0; // Üst çizginin listview içindeki konumu
  final double visibleRangeBottom = 200.0; // Alt çizginin listview içindeki konumu

  // Seçilen yaşa göre font boyutunu ve ağırlığını hesaplayan fonksiyon
  Map<String, dynamic> getTextStyleForAge(int index) {
    double fontSize = 24;
    FontWeight fontWeight = FontWeight.bold;

    if (index == selectedAge.value) {
      fontSize = 24;
      fontWeight = FontWeight.bold;
    } else if (index == selectedAge.value - 1 || index == selectedAge.value + 1) {
      fontSize = 20;
      fontWeight = FontWeight.w500;
    } else if (index == selectedAge.value - 2 || index == selectedAge.value + 2) {
      fontSize = 16;
      fontWeight = FontWeight.w400;
    } else if (index == selectedAge.value - 3 || index == selectedAge.value + 3) {
      fontSize = 12;
      fontWeight = FontWeight.w300;
    } else if (index == selectedAge.value - 4 || index == selectedAge.value + 4) {
      fontSize = 12;
      fontWeight = FontWeight.w300;
    }

    return {
      'fontSize': fontSize,
      'fontWeight': fontWeight,
    };
  }

  void onScrollUpdate() {
    // Scroll sırasında güncel seçimi kontrol et
    final offset = scrollController.offset;

    // ListView'in ortasındaki çizgi ile hizalama
    final double listViewCenter = (visibleRangeTop + visibleRangeBottom) / 2;

    // Ortadaki çizgiye en yakın elemanı seçmek için hesaplama
    final int index = ((offset + listViewCenter - (itemHeight / 2)) / itemHeight).round();

    // Seçili öğeyi güncelle
    if (index >= 0 && index < 100) {
      selectedAge.value = index;
    }
  }

  void onScrollEnd() {
    // Scroll sona erdiğinde seçilen öğeyi tam olarak ortala
    final offset = scrollController.offset;
    final int index = (offset / itemHeight).round();
    final double targetOffset = index * itemHeight;

    scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    // İlk başlatmada scroll güncellemesini hemen başlatmak için
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onScrollUpdate(); // Scroll güncellemesini başlat
    });
  }
}
