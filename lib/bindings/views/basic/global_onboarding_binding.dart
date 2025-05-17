import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart';
import 'package:get/get.dart';

class GlobalOnboardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GlobalOnboardingController>(() => GlobalOnboardingController(), fenix: true);
  }
} 