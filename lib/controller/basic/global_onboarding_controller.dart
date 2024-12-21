

import 'package:get/get.dart';

class GlobalOnboardingController extends GetxController{
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
}

enum OnboardingPageCountEnum{
  onboardingPageOne,
  onboardingPageTwo,
  onboardingPageThree,
  onboardingPageFour,
  onboardingPageFive,
  onboardingPageSix,
}