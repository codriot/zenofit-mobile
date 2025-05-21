import 'package:flutter/widgets.dart' show Curves, ScrollController, WidgetsBinding;
import 'package:get/get.dart';

class HeightPickerController extends GetxController {
  var selectedHeight = 150.0.obs;

  double itemHeight = 40.0;
  final double maxHeight = 230;
  final double minHeight = 50;
  final double increment = 1;

  late ScrollController scrollController;

  // Referans alınan sabit container yüksekliği
  final double referenceContainerHeight = 350.0;
  final double referenceItemHeight = 40.0;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();

    // Ekran yüksekliğine göre itemHeight'ı güncelle
    final double currentContainerHeight = Get.height * 0.45;
    itemHeight = calculateResponsiveHeight(
      referenceContainerHeight: currentContainerHeight,
      referenceValue: referenceContainerHeight,
      ratioValue: referenceItemHeight,
    );

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
    selectedHeight.value = height + 4;
    print("selectedHeight: $selectedHeight");
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

  double calculateResponsiveHeight({
    required double referenceContainerHeight,
    required double referenceValue,
    required double ratioValue,
  }) {
    return referenceContainerHeight * (ratioValue / referenceValue);
  }
}
