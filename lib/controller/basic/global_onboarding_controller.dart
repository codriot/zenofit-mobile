import 'package:get/get.dart';

class GlobalOnboardingController extends GetxController {
  final onboardingPageCount = [
    true,
    false,
    false,
    false,
    false,
    false,
  ].obs;

  void toggleOnboardingPageCount(int index) {
    for (int i = 0; i < onboardingPageCount.length; i++) {
      onboardingPageCount[i] = false;
    }
    onboardingPageCount[index] = true;
  }

  void togglePreviousOnboardingPage() {
    int currentIndex =
        onboardingPageCount.indexWhere((element) => element == true);

    if (currentIndex >= 0) {
      onboardingPageCount[currentIndex] = false;

      // Eğer currentIndex sıfırdan büyükse bir öncekini true yap
      if (currentIndex > 0) {
        onboardingPageCount[currentIndex - 1] = true;
      }
    }
  }
}

enum OnboardingPageCountEnum {
  onboardingPageOne,
  onboardingPageTwo,
  onboardingPageThree,
  onboardingPageFour,
  onboardingPageFive,
  onboardingPageSix,
}
