import 'package:get/state_manager.dart';

class OnboardingOneController extends GetxController {
  /// Seçilen cinsiyet tipi
  var selectedGender = Rxn<GenderType>();

  /// Cinsiyet seçimi yap
  void selectGender(GenderType gender) {
    if (selectedGender.value == gender) {
      selectedGender.value = null; // Aynı seçeneğe tekrar tıklandıysa kaldır
    } else {
      selectedGender.value = gender;
    }
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
