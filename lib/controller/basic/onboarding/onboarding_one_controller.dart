import 'package:diet_app_mobile/API/services/storage_service.dart';
import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:get/get.dart';

enum GenderType { male, female, none, preferNotToSay }

class OnboardingOneController extends GetxController {
  /// Seçilen cinsiyet tipi
  final GlobalOnboardingController globalOnboardingController =
      Get.find<GlobalOnboardingController>();
  final Rx<GenderType?> selectedGender = Rx<GenderType?>(null);

  /// Cinsiyet seçimi yap
  void selectGender(GenderType gender) {
    if (selectedGender.value == gender) {
      selectedGender.value = null; // Aynı seçeneğe tekrar tıklandıysa kaldır
    } else {
      selectedGender.value = gender;
    }
  }

  Future<void> pushToOtherPage() async {
    if (selectedGender.value == null) {
      Get.snackbar(
        'Uyarı',
        'Lütfen bir cinsiyet seçiniz',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      final user = StorageService.instance.loadUser();
      if (user == null) {
        throw Exception('User data not found');
      }

      user.gender = selectedGender.value.toString().split('.').last;
      await StorageService.instance.saveUser(user);
      
      globalOnboardingController.toggleOnboardingPageCount(
          OnboardingPageCountEnum.onboardingPageTwo.index);
      NavigatorController.instance.pushToPage(NavigateRoutesItems.onboardingTwo);
    } catch (e) {
      print('Error in pushToOtherPage: $e');
      Get.snackbar(
        'Hata',
        'Veri kaydedilirken bir hata oluştu',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Belirli cinsiyet tipi seçili mi?
  bool isGenderSelected(GenderType gender) {
    return selectedGender.value == gender;
  }
}
