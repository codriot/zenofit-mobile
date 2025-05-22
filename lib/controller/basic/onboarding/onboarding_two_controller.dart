import 'dart:convert';
import 'package:diet_app_mobile/API/services/storage_service.dart';
import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart';
import 'package:diet_app_mobile/model/user_model.dart';
import 'package:diet_app_mobile/product/controller/age_picker_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:get/get.dart';

class OnboardingTwoController extends GetxController {
  final GlobalOnboardingController globalOnboardingController =
      Get.find<GlobalOnboardingController>();

      final agePickerController = Get.find<AgePickerController>();

  Future<void> pushToOtherPage() async {
    
    final userJsonRaw = StorageService.instance.loadData(StorageItems.user);
    final userJson = userJsonRaw is String ? jsonDecode(userJsonRaw) : userJsonRaw;
    final user = UserModel.fromJson(userJson);

    user.age = agePickerController.selectedAge.value;
    print("kayıt edildi: ${user.age}");
    await StorageService.instance.saveData(StorageItems.user, user.toJson());
    globalOnboardingController.toggleOnboardingPageCount(
        OnboardingPageCountEnum.onboardingPageThree.index);
    NavigatorController.instance.pushToPage(NavigateRoutesItems.onboardingThree);
  }
}
