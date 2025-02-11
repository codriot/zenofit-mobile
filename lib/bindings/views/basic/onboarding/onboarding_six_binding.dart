import 'package:diet_app_mobile/controller/basic/onboarding/onboarding_six_controller.dart';
import 'package:diet_app_mobile/bindings/views/basic/global_onboarding_binding.dart';
import 'package:get/get.dart';

class OnboardingSixBinding implements Bindings {
  @override
  void dependencies() {
    GlobalOnboardingBinding().dependencies(); // Include global binding
    Get.lazyPut<OnboardingSixController>(() => OnboardingSixController());
  }
} 