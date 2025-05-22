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
      final user = await _updateUserGoal();
      await _updateUserOnServer(user);
      await _fetchAndStoreNutritionData();
      NavigatorController.instance.pushToPage(NavigateRoutesItems.main);
    } catch (e) {
      print('Error in pushToOtherPage: $e');
      Get.snackbar(
        'Hata',
        'Veri gönderilirken bir hata oluştu: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<UserModel> _updateUserGoal() async {
    final userData = StorageService.instance.loadData(StorageItems.user);
    if (userData == null) throw Exception('User data not found');
    final Map<String, dynamic> userJson = userData is String
        ? jsonDecode(userData)
        : userData as Map<String, dynamic>;
    final user = UserModel.fromJson(userJson);

    int selectedIndex = isActiveList.indexWhere((element) => element == true);
    user.goal = onboardingSelectionCardModelFood[selectedIndex].title;

    await StorageService.instance.saveData(StorageItems.user, user.toJson());
    return user;
  }

  Future<void> _updateUserOnServer(UserModel user) async {
    final email = StorageService.instance.loadData(StorageItems.email);
    final password = StorageService.instance.loadData(StorageItems.password);

    final Map<String, dynamic> finalUserData = user.toJson();
    finalUserData['email'] = email;
    finalUserData['password'] = password;

    await GeneralService.instance.authorizedPut('/users/me', data: finalUserData);
  }

  Future<void> _fetchAndStoreNutritionData() async {
    final response = await GeneralService.instance.authorizedGet('/nutrition/ai/calculate-calories');
    if (response != null && response.data is Map<String, dynamic>) {
      await StorageService.instance.saveData(
        StorageItems.nutritionCalories,
        response.data,
      );
    } else {
      throw Exception('Kalori verisi alınamadı');
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
