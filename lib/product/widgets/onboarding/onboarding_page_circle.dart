

import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralOnboardingPageCircleComponent extends StatelessWidget {
  GeneralOnboardingPageCircleComponent({super.key});
  final GlobalOnboardingController globalOnboardingController =
      Get.find<GlobalOnboardingController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.instance.bottomNormal,
      child: SizedBox(
        width: 40 +
            40 +
            (globalOnboardingController.onboardingPageCount.length *
                AppSizes.instance.smallValue),
        height: 8,
        child: Center(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: globalOnboardingController.onboardingPageCount.length,
            itemBuilder: (context, index) => Obx(
              () => _buildCircleSmall(
                  color: globalOnboardingController.onboardingPageCount[index]
                      ? AppColor.vividBlue.getColor()
                      : AppColor.crystalBell.getColor(),
                  width: globalOnboardingController.onboardingPageCount[index]
                      ? 40
                      : 8),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildCircleSmall({required double width, required Color color}) {
    return Container(
      margin: AppPadding.instance.leftSmall,
      width: width,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
    );
  }
}
