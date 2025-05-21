import 'package:diet_app_mobile/API/services/general_serivce.dart';
import 'package:diet_app_mobile/API/services/storage_service.dart';
import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart';
import 'package:diet_app_mobile/model/onboarding/onboarding_selection_card_model.dart';
import 'package:diet_app_mobile/model/user_model.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:get/get.dart';
import 'dart:convert';

class OnboardingSixController extends GetxController {
  final GlobalOnboardingController globalOnboardingController =
      Get.find<GlobalOnboardingController>();
  final RxBool isLoading = false.obs;

  late RxList<bool> isActiveList;

  Future<void> pushToOtherPage() async {
    isLoading.value = true;
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
      int selectedIndex = isActiveList.indexWhere((element) => element == true);
      user.goal = onboardingSelectionCardModelFood[selectedIndex].title;
      
      // Get email and password from storage
      final email = StorageService.instance.loadData(StorageItems.email);
      final password = StorageService.instance.loadData(StorageItems.password);
      // Create final data to send
      final Map<String, dynamic> finalUserData = user.toJson();
      finalUserData['email'] = email;
      finalUserData['password'] = password;
      
      print("kayıt edildi: ${user.goal}");
      await StorageService.instance.saveData(StorageItems.user, user.toJson());
      print("user verileri: $user");
      
      await GeneralService.instance
          .authorizedPut('/users/me', data: finalUserData)
          .whenComplete(() {
        NavigatorController.instance.pushToPage(NavigateRoutesItems.home);
      });
    } catch (e) {
      print('Error in pushToOtherPage: $e');
      Get.snackbar(
        'Hata',
        'Veri gönderilirken bir hata oluştu',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  final List<OnboardingSelectionCardModel> onboardingSelectionCardModelFood = [
    OnboardingSelectionCardModel(title: "Kilo Yönetimi", icon: "task"),
    OnboardingSelectionCardModel(title: "Kas Yapma", icon: "biceps"),
    OnboardingSelectionCardModel(
        title: "Gene Sağlık Ve Zindelik", icon: "mental-health"),
    OnboardingSelectionCardModel(
        title: "Özel Sağlık Durumuna Yönelik", icon: "healthy-heart"),
    OnboardingSelectionCardModel(title: "Beslenme", icon: "carrot"),
    OnboardingSelectionCardModel(
        title: "Glütensiz ve Alerji Odaklı", icon: "wheet"),
    OnboardingSelectionCardModel(title: "Detoks ve Arınma", icon: "drop"),
    OnboardingSelectionCardModel(
        title: "Hamilelik ve Emzirme Dönemi", icon: "feeding-bottle"),
    OnboardingSelectionCardModel(title: "Diğer", icon: "menu"),
  ];

  @override
  void onInit() {
    super.onInit();
    // RxList'i initialize et
    isActiveList = List.generate(
      onboardingSelectionCardModelFood.length,
      (index) => false,
    ).obs;
  }

  void toggleSelection(int index) {
    for (int i = 0; i < isActiveList.length; i++) {
      if (i == index) {
        // Eğer bu index zaten aktifse devre dışı bırak
        isActiveList[i] = !isActiveList[i];
      } else {
        // Diğer tüm indexleri pasif yap
        isActiveList[i] = false;
      }
    }
  }
}
