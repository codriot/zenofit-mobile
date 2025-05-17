import 'package:diet_app_mobile/controller/basic/onboarding/onboarding_five_controller.dart';
import 'package:diet_app_mobile/bindings/views/basic/global_onboarding_binding.dart';
import 'package:get/get.dart';

class OnboardingFiveBinding implements Bindings {
  @override
  void dependencies() {
    GlobalOnboardingBinding().dependencies(); // Include global binding
    Get.lazyPut<OnboardingFiveController>(() => OnboardingFiveController());
  }
} 