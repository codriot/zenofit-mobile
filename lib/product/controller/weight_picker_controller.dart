

import 'package:flutter/widgets.dart' show Curves, ScrollController, WidgetsBinding;
import 'package:get/get.dart';

class WeightPickerController extends GetxController {
  var selectedWeight = 30.0.obs; // Başlangıç kilo değeri 30
  final double itemHeight = 40.0; // Her bir öğenin yüksekliği
  final double barHeight = 2.0; // Çubukların yüksekliği
  final double maxWeight = 150; // Maksimum kilo
  final double minWeight = 10; // Minimum kilo
  final double increment = 0.2; // Kilo artış miktarı

  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    // ScrollController'ı başlatıyoruz
    scrollController = ScrollController();

    // Başlangıç pozisyonunu ayarlıyoruz
    Future.delayed(Duration.zero, () {
      _setInitialPosition();
    });

    // Listener ekliyoruz
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    // Controller kapatıldığında ScrollController'ı temizliyoruz
    scrollController.dispose();
    super.onClose();
  }

  void _setInitialPosition() {
    double initialPosition =
        (selectedWeight.value - minWeight) / increment * itemHeight;
    print("initialPozisiton: $initialPosition");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          initialPosition,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void updateSelectedWeight(double weight) {
    print("weight: $weight");
    selectedWeight.value = weight;
  }

  void _scrollListener() {
    // ScrollController'dan mevcut pozisyonu alıyoruz
    double currentPosition = scrollController.position.pixels;

    // Kilo değeri ile pozisyonu kıyaslayarak selectedWeight'i güncelliyoruz
    double weightValue = minWeight + (currentPosition / itemHeight) * increment;

    // Kilo değerini yuvarlıyoruz (örneğin 30.2, 30.4 vb. olabilir)
    weightValue = (weightValue / increment).roundToDouble() * increment;

    // Eğer seçilen kilo mevcut aralıkta ise güncelleme yapıyoruz
    if (weightValue >= minWeight && weightValue <= maxWeight) {
      updateSelectedWeight(weightValue);
    }
  }
}
