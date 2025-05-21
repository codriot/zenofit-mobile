import 'package:diet_app_mobile/controller/basic/onboarding/onboarding_two_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/widgets/general/general_page_button.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_page_circle.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_top_components.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_two/age_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingTwoView extends GetView<OnboardingTwoController> {
  const OnboardingTwoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            OnboardingTopComponents(title: "Yaşınız Kaç?"),
            AgePickerWidget(),
            const Spacer(),
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
