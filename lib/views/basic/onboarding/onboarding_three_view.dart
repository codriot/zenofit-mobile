import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';

import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart'
    show AppPadding;
import 'package:diet_app_mobile/product/widgets/general/general_page_button.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_page_circle.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_three.dart/weight_picker_widget.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_top_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingThreeView extends StatelessWidget {
  OnboardingThreeView({super.key});
  final GlobalOnboardingController globalOnboardingController =
      Get.find<GlobalOnboardingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            OnboardingTopComponents(title: "Kilonuz Kaç?"),
            Expanded(child: WeightPickerWidget()),
            GeneralOnboardingPageCircleComponent(),
            Padding(
              padding: AppPadding.instance.horizontalMedium,
              child: GeneralPageButtonWidget(
                onPressed: () {
                  globalOnboardingController.toggleOnboardingPageCount(
                      OnboardingPageCountEnum.onboardingPageFour.index);
                  NavigatorController.instance
                      .pushToPage(NavigateRoutesItems.onboardingFour);
                },
                text: "Next",
                padding: AppPadding.instance.bottomNormal,
                isIconActive: true,
              ),
            ),
            Padding(
              padding: AppPadding.instance.horizontalMedium,
              child: GeneralPageButtonWidget(
                onPressed: () {
                  globalOnboardingController.toggleOnboardingPageCount(
                      OnboardingPageCountEnum.onboardingPageFour.index);
                  NavigatorController.instance
                      .pushToPage(NavigateRoutesItems.onboardingFour);
                },
                text: "Skip",
                padding: AppPadding.instance.bottomNormal,
                backgroundColor: AppColor.sweetPatato.getColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
