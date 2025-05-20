import 'package:diet_app_mobile/API/services/storage_service.dart';
import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart';
import 'package:diet_app_mobile/model/user_model.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:get/get.dart';

class OnboardingOneController extends GetxController {
  /// Seçilen cinsiyet tipi
  final GlobalOnboardingController globalOnboardingController =
      Get.find<GlobalOnboardingController>();
  var selectedGender = Rxn<GenderType>();

  /// Cinsiyet seçimi yap
  void selectGender(GenderType gender) {
    if (selectedGender.value == gender) {
      selectedGender.value = null; // Aynı seçeneğe tekrar tıklandıysa kaldır
    } else {
      selectedGender.value = gender;
    }
  }

  Future<void> pushToOtherPage() async {
    final userJson = StorageService.instance.loadData(StorageItems.user);
    final user = UserModel.fromJson(userJson);
    user.gender = selectedGender.value?.name;
    print("kayıt edildi: ${user.gender}");
    await StorageService.instance.saveData(StorageItems.user, user.toJson());
    globalOnboardingController.toggleOnboardingPageCount(
        OnboardingPageCountEnum.onboardingPageTwo.index);
    NavigatorController.instance.pushToPage(NavigateRoutesItems.onboardingTwo);
  }

  /// Belirli cinsiyet tipi seçili mi?
  bool isGenderSelected(GenderType gender) => selectedGender.value == gender;
}

enum GenderType {
  male,
  female,
  none,
  preferNotToSay,
}
