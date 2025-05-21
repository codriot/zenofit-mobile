import 'package:diet_app_mobile/API/services/storage_service.dart';
import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart';
import 'package:diet_app_mobile/model/onboarding/onboarding_selection_card_model.dart';
import 'package:diet_app_mobile/model/user_model.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:get/get.dart';

class OnboardingFiveController extends GetxController {
  final GlobalOnboardingController globalOnboardingController =
      Get.find<GlobalOnboardingController>();

  late RxList<bool> isActiveList;

  Future<void> pushToOtherPage() async {
    final userJson = StorageService.instance.loadData(StorageItems.user);
    final user = UserModel.fromJson(userJson);
    int selectedIndex = isActiveList.indexWhere((element) => element == true);
    user.activityLevel = onboardingSelectionCardModelFood[selectedIndex].title;
    print("kayıt edildi: ${user.activityLevel}");
    await StorageService.instance.saveData(StorageItems.user, user.toJson());
    globalOnboardingController.toggleOnboardingPageCount(
        OnboardingPageCountEnum.onboardingPageSix.index);
    NavigatorController.instance.pushToPage(NavigateRoutesItems.onboardingSix);
  }

  final List<OnboardingSelectionCardModel> onboardingSelectionCardModelFood = [
    OnboardingSelectionCardModel(title: "Balık", icon: "fish"),
    OnboardingSelectionCardModel(title: "Atıştırmalık", icon: "food"),
    OnboardingSelectionCardModel(title: "Protein", icon: "proteins"),
    OnboardingSelectionCardModel(title: "Süt Ürünleri", icon: "dairy"),
    OnboardingSelectionCardModel(title: "Sebzeler", icon: "carrot"),
    OnboardingSelectionCardModel(title: "Meyveler", icon: "fruits"),
    OnboardingSelectionCardModel(title: "Organik", icon: "organic-food"),
    OnboardingSelectionCardModel(title: "Vegan", icon: "broccoli"),
    OnboardingSelectionCardModel(title: "Tatlılar", icon: "cake-slice"),
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
