// lib/controllers/navigation_controller.dart
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_duration.dart';
import 'package:flutter/animation.dart' show Curves;
import 'package:flutter/widgets.dart' show PageController;
import 'package:get/get.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;
  final PageController pageController = PageController();

  void changeIndex(int index) {
    currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: AppDuration.instance.durationFast, // Animasyon süresi
      curve: Curves.easeInOut, // Animasyon eğrisi
    );
  }
}
