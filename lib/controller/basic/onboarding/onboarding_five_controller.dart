import 'package:diet_app_mobile/model/onboarding/onboarding_selection_card_model.dart';
import 'package:get/state_manager.dart';

class OnboardingFiveController extends GetxController {
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

  late RxList<bool> isActiveList;

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
