
import 'package:diet_app_mobile/model/onboarding/onboarding_selection_card_model.dart';
import 'package:get/state_manager.dart';

class OnboardingSixController extends GetxController {
  final List<OnboardingSelectionCardModel> onboardingSelectionCardModelFood = [
    OnboardingSelectionCardModel(title: "Kilo Yönetimi", icon: "task"),
    OnboardingSelectionCardModel(title: "Kas Yapma", icon: "biceps"),
    OnboardingSelectionCardModel(title: "Gene Sağlık Ve Zindelik", icon: "mental-health"),
    OnboardingSelectionCardModel(title: "Özel Sağlık Durumuna Yönelik", icon: "healthy-heart"),
    OnboardingSelectionCardModel(title: "Beslenme", icon: "carrot"),
    OnboardingSelectionCardModel(title: "Glütensiz ve Alerji Odaklı", icon: "wheet"),
    OnboardingSelectionCardModel(title: "Detoks ve Arınma", icon: "drop"),
    OnboardingSelectionCardModel(title: "Hamilelik ve Emzirme Dönemi", icon: "feeding-bottle"),
    OnboardingSelectionCardModel(title: "Diğer", icon: "menu"),
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
