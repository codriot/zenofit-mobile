import 'package:diet_app_mobile/API/services/storage_service.dart';
import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart';
import 'package:diet_app_mobile/model/user_model.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:get/get.dart';
import 'dart:convert';

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
      // Get user data from storage
      final userData = StorageService.instance.loadData(StorageItems.user);
      if (userData == null) {
        throw Exception('User data not found');
      }

      // Parse user data
      final Map<String, dynamic> userJson = userData is String 
          ? jsonDecode(userData) 
          : userData as Map<String, dynamic>;
      
      final user = UserModel.fromJson(userJson);
      
      // Set gender based on selection
      switch (selectedGender.value) {
        case GenderType.male:
          user.gender = "male";
          break;
        case GenderType.female:
          user.gender = "female";
          break;
        case GenderType.none:
          user.gender = "other";
          break;
        case GenderType.preferNotToSay:
          user.gender = "prefer_not_to_say";
          break;
        default:
          user.gender = null;
      }

      // Save updated user data
      await StorageService.instance.saveData(StorageItems.user, user.toJson());
      
      // Navigate to next page
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
