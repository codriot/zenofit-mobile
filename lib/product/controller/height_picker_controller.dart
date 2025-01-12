


import 'package:flutter/widgets.dart' show Curves, ScrollController, WidgetsBinding;
import 'package:get/get.dart';
class HeightPickerController extends GetxController {
  var selectedHeight = 150.0.obs; // Başlangıç yükseklik değeri
  final double itemHeight = 40.0; // Her bir öğenin yüksekliği
  final double maxHeight = 230; // Maksimum yükseklik
  final double minHeight = 50; // Minimum yükseklik
  final double increment = 1; // Artış miktarı

  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();

    Future.delayed(Duration.zero, _setInitialPosition);
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _setInitialPosition() {
    double initialPosition =
        (selectedHeight.value - minHeight) / increment * itemHeight;
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

  void updateSelectedHeight(double height) {
    selectedHeight.value = height;
  }

  void _scrollListener() {
    double currentPosition = scrollController.position.pixels;
    double heightValue =
        minHeight + (currentPosition / itemHeight) * increment;
    heightValue = (heightValue / increment).roundToDouble() * increment;

    if (heightValue >= minHeight && heightValue <= maxHeight) {
      updateSelectedHeight(heightValue);
    }
  }
}
