import 'dart:convert';

import 'package:diet_app_mobile/API/services/storage_service.dart';
import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart';
import 'package:diet_app_mobile/model/user_model.dart';
import 'package:diet_app_mobile/product/controller/weight_picker_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:get/get.dart';

class OnboardingThreeController extends GetxController {
  final GlobalOnboardingController globalOnboardingController =
      Get.find<GlobalOnboardingController>();

  final weightPickerController = Get.find<WeightPickerController>();

  Future<void> pushToOtherPage() async {
    final userJsonRaw = StorageService.instance.loadData(StorageItems.user);
    final userJson = userJsonRaw is String ? jsonDecode(userJsonRaw) : userJsonRaw;
    final user = UserModel.fromJson(userJson);

    user.weight = weightPickerController.selectedWeight.value;
    print("kayıt edildi: ${user.weight}");
    await StorageService.instance.saveData(StorageItems.user, user.toJson());
    globalOnboardingController.toggleOnboardingPageCount(
        OnboardingPageCountEnum.onboardingPageFour.index);
    NavigatorController.instance.pushToPage(NavigateRoutesItems.onboardingFour);
  }
}
