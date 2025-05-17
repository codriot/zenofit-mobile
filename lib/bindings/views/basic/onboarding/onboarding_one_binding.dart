import 'package:diet_app_mobile/bindings/views/basic/global_onboarding_binding.dart';
import 'package:diet_app_mobile/controller/basic/onboarding/onboarding_one_controller.dart';
import 'package:get/get.dart';

class OnboardingOneBinding implements Bindings {
  @override
  void dependencies() {
    GlobalOnboardingBinding().dependencies(); // Include global binding
    Get.lazyPut<OnboardingOneController>(() => OnboardingOneController());
  }
}
