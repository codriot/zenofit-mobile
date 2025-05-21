import 'package:diet_app_mobile/controller/basic/onboarding/onboarding_three_controller.dart';

import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart'
    show AppPadding;
import 'package:diet_app_mobile/product/widgets/general/general_page_button.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_page_circle.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_three.dart/weight_picker_widget.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_top_components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingThreeView extends GetView<OnboardingThreeController> {
  const OnboardingThreeView({super.key});

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
                onPressed: controller.pushToOtherPage,
                text: "Next",
                padding: AppPadding.instance.bottomNormal,
                isIconActive: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
