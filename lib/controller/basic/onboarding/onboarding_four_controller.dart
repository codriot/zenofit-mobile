import 'dart:convert';

import 'package:diet_app_mobile/API/services/storage_service.dart';
import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart'
    show GlobalOnboardingController, OnboardingPageCountEnum;
import 'package:diet_app_mobile/model/user_model.dart';
import 'package:diet_app_mobile/product/controller/height_picker_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:get/get.dart';

class OnboardingFourController extends GetxController {
  final GlobalOnboardingController globalOnboardingController =
      Get.find<GlobalOnboardingController>();

  final heightPickerController = Get.find<HeightPickerController>();

  Future<void> pushToOtherPage() async {
    final userJsonRaw = StorageService.instance.loadData(StorageItems.user);
    final userJson = userJsonRaw is String ? jsonDecode(userJsonRaw) : userJsonRaw;
    final user = UserModel.fromJson(userJson);
    user.height = heightPickerController.selectedHeight.value;
    print("kayıt edildi: ${user.height}");
    await StorageService.instance.saveData(StorageItems.user, user.toJson());
    globalOnboardingController.toggleOnboardingPageCount(
        OnboardingPageCountEnum.onboardingPageFive.index);
    NavigatorController.instance.pushToPage(NavigateRoutesItems.onboardingFive);
  }
}
